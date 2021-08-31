import UIKit

final class ExamSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    // MARK: - Persistent Storage
    //    lazy var examQueriesStorage: ExamQueriesStorage = CoreDataExamQueriesStorage(maxStorageLimit: 10)
    //    lazy var examResponseCache: ExamResponseStorage = CoreDataExamResponseStorage()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    
    // MARK: - Use Cases
    func makeHomeUseCase() -> HomeUseCase {
        return DefaultHomeUseCase(examRepository: makeExamRepository())
    }
    func makeDetailUseCase() -> DetailUseCase {
        return DefaultDetailUseCase(examRepository: makeExamRepository())
    }
    
    // MARK: - Repositories
    func makeExamRepository() -> ExamRepository {
        return DefaultExamRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    // MARK: - Home
    func makeHomeViewController(closures: HomeViewModelClosures) -> HomeViewController {
        return HomeViewController.create(with: makeHomeViewModel(closures: closures))
    }
    
    func makeHomeViewModel(closures: HomeViewModelClosures) -> HomeViewModel {
        return DefaultHomeViewModel(homeUseCase: makeHomeUseCase(),
                                        closures: closures)
    }
    
    // MARK: - Detail
    func makeDetailViewController(closures: DetailViewModelClosures, html_url:String) -> DetailViewController {
        return DetailViewController.create(with: makeDetailViewModel(closures: closures, html_url:html_url))
    }
    
    func makeDetailViewModel(closures: DetailViewModelClosures, html_url:String) -> DetailViewModel {
        return DefaultDetailViewModel(detailUseCase: makeDetailUseCase(),
                                        closures: closures, html_url: html_url)
    }
    
    // MARK: - Flow Coordinators
    func makeExamFlowCoordinator(navigationController: UINavigationController) -> ExamFlowCoordinator {
        return ExamFlowCoordinator(navigationController: navigationController,
                                    dependencies: self)
    }
}

extension ExamSceneDIContainer: ExamFlowCoordinatorDependencies {
    
}
