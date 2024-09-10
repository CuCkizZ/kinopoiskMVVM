//
//  ViewController.swift
//  MVVM
//
//  Created by Nikita Beglov on 25.06.2024.
//

import UIKit

final class MainViewController: UIViewController, UISearchControllerDelegate {
    
    private lazy var activityIndicator = UIActivityIndicatorView()
    private lazy var cellDataSource: [MainCellModel] = []
    private var viewModel: MainViewModelProtocol = MainViewModel()
    
    private lazy var tableView = UITableView()
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getStart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
}

// MARK: - Private MainViewControllerConfiguration

private extension MainViewController {
    
    func setupView() {
        view.backgroundColor = .white
        title = "Фильмы"
        navigationItem.searchController = searchController
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        bindViewModel()
        bindView()
        setupSearchController()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainCellView.self, forCellReuseIdentifier: MainCellView.mainCellIdentifire)
    }
    
    func setupSearchController() {
        searchController.searchBar.placeholder = "Введите запрос"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    //    MARK: BindView
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func bindView() {
        viewModel.cellDataSource.bind { [weak self] films in
            guard let self = self, let films = films else { return }
            self.cellDataSource = films
            tableView.reloadData()
        }
    }
}

// MARK: - MainViewControllerTableViewExtension

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCellView.mainCellIdentifire,
                                                       for: indexPath) as? MainCellView
        else {
            return UITableViewCell()
        }
        let film = cellDataSource[indexPath.row]
        cell.configure(viewModel: film)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filmId = cellDataSource[indexPath.row].filmId
        viewModel.presentDetailVC(self, filmId: filmId)
    }
}

// MARK: - MainViewControllerSearchBarConfiguration

extension MainViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        if searchText != "" {
            viewModel.getFilms()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
    }
}
