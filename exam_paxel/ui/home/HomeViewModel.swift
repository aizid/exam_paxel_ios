import Foundation

struct HomeViewModelClosures {
    let showDetail: (_ html_url:String) -> Void
}

enum HomeViewModelLoading {
    case fullScreen
}

protocol HomeViewModelInput {
    func getRepoSearchList(query: String)
    
    func showDetail(html_url:String)
}

protocol HomeViewModelOutput {
    var getRepoSearchListResponse: Observable<GithubRes?> { get }
    
    var loading: Observable<HomeViewModelLoading?> { get }
    var error: Observable<String> { get }
    var screenTitle: String { get }
    var errorTitle: String { get }
    
    var getRepoSearchListResponseisEmpty: Bool { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput { }

final class DefaultHomeViewModel: HomeViewModel {
    
    
    private let homeUseCase: HomeUseCase
    private let closures: HomeViewModelClosures?
    
    private var homeLoadTask: Cancellable? { willSet { homeLoadTask?.cancel() } }
    
    private var getRepoSearchListResponseLoadTask: Cancellable? { willSet { getRepoSearchListResponseLoadTask?.cancel() } }
    
    // MARK: - OUTPUT
    let getRepoSearchListResponse: Observable<GithubRes?> = Observable(nil)
    
    var getRepoSearchListResponseisEmpty: Bool { return getRepoSearchListResponse.value == nil }
    
    let loading: Observable<HomeViewModelLoading?> = Observable(.none)
    let error: Observable<String> = Observable("")
    let screenTitle = NSLocalizedString("Home", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    
    init(homeUseCase: HomeUseCase,
         closures: HomeViewModelClosures? = nil) {
        self.homeUseCase = homeUseCase
        self.closures = closures
    }
    
    // MARK: - Private
    private func RepoSearchListResponse(_ repoSearchListResponse: GithubRes) {
        getRepoSearchListResponse.value = repoSearchListResponse
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading Login", comment: "")
    }
}

// MARK: - INPUT. View event methods
extension DefaultHomeViewModel {
    
    func getRepoSearchList(query: String) {
        loading.value = .fullScreen
        
        getRepoSearchListResponseLoadTask = homeUseCase.getRepoSearchList(query: query,
            completion: { result in
                switch result {
                case .success(let res):
                    self.RepoSearchListResponse(res)
                case .failure(let error):
                    self.handle(error: error)
                }
                self.loading.value = .none
        })
    }
    
    func didCancel() {
        homeLoadTask?.cancel()
        
        getRepoSearchListResponseLoadTask?.cancel()
    }
    
    func showDetail(html_url:String){
        closures?.showDetail(html_url)
    }
    
}
