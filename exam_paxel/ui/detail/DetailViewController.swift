import UIKit
import WebKit

class DetailViewController: UIViewController, StoryboardInstantiable {

    private var viewModel: DetailViewModel!
    
    @IBOutlet weak var webKitDetail: WKWebView!
    // MARK: - Lifecycle
    
    static func create(with viewModel: DetailViewModel) -> DetailViewController {
        let view = DetailViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind(to: viewModel)
    }

    private func bind(to viewModel: DetailViewModel) {
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - Private

    private func setupViews() {
        title = viewModel.screenTitle
        view.accessibilityIdentifier = AccessibilityIdentifier.DetailView
        
        initData()
    }
    
    func initData() {
        let url: URL = URL(string: viewModel.html_url)!
        let urlRequest =  URLRequest(url: url)
        webKitDetail.load(urlRequest)
    }
    
    @IBAction func btnBackDetail(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateLoading(_ loading: DetailViewModelLoading?) {
        LoadingView.hide()
    }
}
