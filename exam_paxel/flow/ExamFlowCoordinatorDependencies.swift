import UIKit

protocol ExamFlowCoordinatorDependencies  {
    func makeHomeViewController(closures: HomeViewModelClosures) -> HomeViewController
    
    func makeDetailViewController(closures: DetailViewModelClosures, html_url:String) -> DetailViewController
    
}

class ExamFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: ExamFlowCoordinatorDependencies
    
    private weak var homeVC: HomeViewController?
    
    init(navigationController: UINavigationController,
         dependencies: ExamFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with closures, this way this flow do not need to be strong referenced
        showHome()
        
        UITabBar.appearance().tintColor = UIColor(named: "color_primary")
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    private func showHome() {
        let closures = HomeViewModelClosures(showDetail: showDetail)
        let vc = dependencies.makeHomeViewController(closures: closures)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        homeVC = vc
    }
    
    private func showDetail(html_url: String) {
        let closures = DetailViewModelClosures()
        let vc = dependencies.makeDetailViewController(closures: closures, html_url: html_url)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
