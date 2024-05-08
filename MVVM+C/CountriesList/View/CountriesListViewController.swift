//
//  CountriesListViewController.swift
//  exercise
//
//  Created by viamkovyi on 2024-03-10.
//

import Combine
import UIKit

protocol CountriesListViewControllerViewModel: ObservableObject {
    associatedtype Country: CountryTableViewCellViewModel, Hashable
    
    var countries: [Country] { get }
    var isLoading: Bool { get }
    
    var error: PassthroughSubject<Error, Never> { get }
    
    func loadData()
    func userDidSearch(text: String?)
}

final class CountriesListViewController<ViewModel>: ViewController, UISearchResultsUpdating where ViewModel: CountriesListViewControllerViewModel  {
    
    private typealias DataSource = UITableViewDiffableDataSource<Section, Row>
    
    private enum Section: Hashable {
        case countries
    }
    
    private enum Row: Hashable {
        case country(ViewModel.Country)
    }
    
    private let viewModel: ViewModel
    private let tableView: UITableView = .init()
    private var activityIndicatorView: UIActivityIndicatorView?
    
    private var dataSource: DataSource?
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("We don't use storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataSource()
        setupSubviews()
        setupSearchController()
        bindToViewModel()
        updateView()
        
        viewModel.loadData()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.bindFrameToSuperviewBounds()
    }
    
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }
    
    private func bindToViewModel() {
        viewModel
            .objectDidChange(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.updateView() }
            .store(in: &cancellables)
        
        viewModel
            .error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.handleError($0) }
            .store(in: &cancellables)
    }
    
    private func updateView() {
        updateActivityIndicatorIfNeeded()
        updateDataSource()
    }
    
    private func updateActivityIndicatorIfNeeded() {
        if viewModel.isLoading,
           activityIndicatorView == nil {
            let activity = UIActivityIndicatorView(style: .large)
            activity.translatesAutoresizingMaskIntoConstraints = false
            activity.startAnimating()
            view.addSubview(activity)
            
            activity.bindToCenter()
            
            activityIndicatorView = activity
        } else if activityIndicatorView != nil {
            activityIndicatorView?.stopAnimating()
            activityIndicatorView?.removeFromSuperview()
            activityIndicatorView = nil
        }
    }
    
    private func handleError(_ error: Error) {
        let alertViewController = UIAlertController(
            title: error.localizedDescription,
            message: nil,
            preferredStyle: .alert
        )
        
        present(alertViewController, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.userDidSearch(text: searchController.searchBar.text)
    }
}

// MARK: - Data Source
private extension CountriesListViewController {
    func setupDataSource() {
        tableView.register(CountryTableViewCellView.self, forCellReuseIdentifier: CountryTableViewCellView.reuseIdentifier)
        
        let dataSource = UITableViewDiffableDataSource<Section, Row>(tableView: tableView) { tableView, indexPath, row in
            switch row {
            case let .country(item):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCellView.reuseIdentifier) as? CountryTableViewCellView else { fatalError("Unexpected cell type") }
                cell.configure(with: item)
                return cell
            }
        }
        
        self.dataSource = dataSource
    }
    
    func updateDataSource() {
        guard var snapshot = dataSource?.snapshot() else { return }
        defer { dataSource?.apply(snapshot, animatingDifferences: true) }
        
        snapshot.deleteAllItems()
        
        guard !viewModel.isLoading else { return }
        
        snapshot.appendSections([.countries])
        snapshot.appendItems(viewModel.countries.map(Row.country))
    }
}

