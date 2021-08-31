import UIKit

class HomeViewController: UIViewController, StoryboardInstantiable, Alertable, SeeDetails {
    
    private var viewModel: HomeViewModel!
    static let myNotification = Notification.Name("SortSelection")
    
    @IBOutlet weak var tblHome: UITableView!
    @IBOutlet weak var searchBarHome: UISearchBar!
    
    var inputQuery: String = "ios"
    var notifListRes: [Item] = [Item]()
    
    let mRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Lifecycle
    
    static func create(with viewModel: HomeViewModel) -> HomeViewController {
        let view = HomeViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: HomeViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        
        viewModel.getRepoSearchListResponse.observe(on: self) { [weak self] in self?.getRepoSearchListResponse($0) }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initDataRequest()
        NotificationCenter.default.addObserver(self, selector: #selector(onNotificationProductSelected(notification:)), name: HomeViewController.myNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: HomeViewController.myNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Private
    
    private func setupViews() {
        title = viewModel.screenTitle
        view.accessibilityIdentifier = AccessibilityIdentifier.HomeView
        searchBarHome.delegate = self
        tblHome.refreshControl = mRefreshControl
    }
    
    func initDataRequest() {
        viewModel.getRepoSearchList(query: inputQuery)
    }
    
    private func updateLoading(_ loading: HomeViewModelLoading?) {
        LoadingView.hide()
        
        switch loading {
        case .fullScreen: LoadingView.show()
        case .none: 
            print("")
        }
    }
    
    // MARK: - initDataResponse
    private func getRepoSearchListResponse(_ githubRes: GithubRes?) {
        guard githubRes != nil else { return }
        
        notifListRes = githubRes!.items
        tblHome.reloadData()
        self.mRefreshControl.endRefreshing()
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }
    
    func showDetails(_ sender:HomeTableViewCell, id:Int?) {
        if id != nil {
            let datas = notifListRes[id!]
            viewModel.showDetail(html_url: datas.html_url!)
        } else {
            let alert = UIAlertController(title: title, message: "Id not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
            }))
            self.present(alert, animated: true)
        }
        
    }

    @objc private func refresh(sender: UIRefreshControl) {
        if !inputQuery.isEmpty {
            viewModel.getRepoSearchList(query: inputQuery)
        } else {
            self.mRefreshControl.endRefreshing()
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        if searchText.count > 2 {
            inputQuery = searchText
            viewModel.getRepoSearchList(query: inputQuery)
        } else {
            let alert = UIAlertController(title: title, message: "Enter at least 3 characters!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
            }))
            self.present(alert, animated: true)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // viewModel.
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifListRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        cell.delegate = self
        let data = notifListRes[indexPath.row]
        cell.setData(data: data, position: indexPath.row)
        return cell
        
    }
    
    @objc func onNotificationProductSelected(notification:Notification) {
        
    }
    
}
