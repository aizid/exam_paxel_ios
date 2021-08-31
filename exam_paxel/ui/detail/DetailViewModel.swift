import Foundation

struct DetailViewModelClosures {
}

enum DetailViewModelLoading {
    case fullScreen
}

protocol DetailViewModelInput {
    
}

protocol DetailViewModelOutput {
    var html_url: String { get }
    
    var loading: Observable<DetailViewModelLoading?> { get }
    var screenTitle: String { get }
}

protocol DetailViewModel: DetailViewModelInput, DetailViewModelOutput { }

final class DefaultDetailViewModel: DetailViewModel {
    
    private let detailUseCase: DetailUseCase
    private let closures: DetailViewModelClosures?
    internal let html_url: String

    private var detailLoadTask: Cancellable? { willSet { detailLoadTask?.cancel() } }
    
    // MARK: - OUTPUT
    
    let loading: Observable<DetailViewModelLoading?> = Observable(.none)
    let screenTitle = NSLocalizedString("Detail", comment: "")
    
    init(detailUseCase: DetailUseCase,
         closures: DetailViewModelClosures? = nil, html_url:String) {
        self.detailUseCase = detailUseCase
        self.closures = closures
        self.html_url = html_url
    }
}

// MARK: - INPUT. View event methods
extension DefaultDetailViewModel {

    func viewDidLoad() { }

    func didCancel() {
        detailLoadTask?.cancel()
    }
    
}
