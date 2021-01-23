//
//  PopularMovieListViewController.swift
//  TMDbApp
//
//  Created by Cem Kazım on 26.12.2020.
//

import UIKit
import SDWebImage

class PopularMovieListViewController: UIViewController, PopularMovieListViewModelDelegate {
    
    // MARK: - UI Objects -
    
    lazy var popularMovieTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PopularMovieListTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.popularMovieListTableViewCellId)
        tableView.backgroundColor = .clear
        return tableView
    }()
    lazy var popularMovieSearchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barStyle = UIBarStyle.black
        searchController.searchBar.backgroundColor = UIColor.clear
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.placeholder = ConstantTexts.searchText
        searchController.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchController.searchBar.setValue(ConstantTexts.cancelButtonText, forKey: ConstantTexts.cancelButtonTextId)
        return searchController
    }()
    lazy var loaderActivityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    // MARK: - View Model Property -
    
    lazy var popularMovieListViewModel: PopularMovieListViewModel = {
        let viewModel = PopularMovieListViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    // MARK: - Lifecycles -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Methods -
    
    
    func setupSearchController() {
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = popularMovieSearchController
        } else {
            popularMovieSearchController.hidesNavigationBarDuringPresentation = false
            navigationItem.titleView = popularMovieSearchController.searchBar
        }
    }
    
    func setupView() {
        updateBackgroundColor(view, CustomColors.firstChangableColor, CustomColors.secondChangableColor)
        navigationItem.title = ConstantTexts.popularMoviesText
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.addSubview(popularMovieTableView)
        view.addSubview(loaderActivityIndicatorView)
        loaderActivityIndicatorView.startAnimating()
        setupConstraints()
        setupSearchController()
        removeNavigationBar()
    }
    
    func setupConstraints() {
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                popularMovieTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                popularMovieTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                popularMovieTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                popularMovieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
                
                loaderActivityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loaderActivityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                popularMovieTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                popularMovieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                popularMovieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                popularMovieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                
                loaderActivityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loaderActivityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
    
    func setMovieModelList(_ movieModelList: [MovieModel]) {
        popularMovieListViewModel.movieModelList = movieModelList
        popularMovieTableView.reloadData()
        loaderActivityIndicatorView.stopAnimating()
    }
    
    func getCellData(with movieModelList: MovieModel, cell: PopularMovieListTableViewCell) {
        cell.movieNameLabel.text = movieModelList.title
        cell.movieImageView.sd_setImage(with: URL(string: movieModelList.imageUrl ?? ""))
        cell.movieReleaseDateLabel.text = "\(ConstantTexts.releaseDateText)\(movieModelList.releaseDate ?? "")"
    }
}

// MARK: - MovieListViewController: UITableViewDelegate, UITableViewDataSource -

extension PopularMovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if popularMovieSearchController.isActive {
            return popularMovieListViewModel.filteredMovieModelList.count
        } else {
            return popularMovieListViewModel.movieModelList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.popularMovieListTableViewCellId) as? PopularMovieListTableViewCell {
            if popularMovieSearchController.isActive {
                getCellData(with: popularMovieListViewModel.filteredMovieModelList[indexPath.row], cell: cell)
            } else {
                getCellData(with: popularMovieListViewModel.movieModelList[indexPath.row], cell: cell)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailViewController = MovieDetailViewController()
        let movieDetailViewModel = MovieDetailViewModel(movieResultModel: popularMovieListViewModel.movieResults[indexPath.row])
        movieDetailViewController.movieDetailViewModel = movieDetailViewModel
        pushTo(movieDetailViewController)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -20, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}

// MARK: - MovieListViewController: UISearchBarDelegate, UISearchResultsUpdating -

extension PopularMovieListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        // code was here...
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        popularMovieListViewModel.filteredMovieModelList.removeAll(keepingCapacity: false)
        if let searchTerm = searchController.searchBar.text {
            let filteredArray = popularMovieListViewModel.movieModelList.filter { result in
                return (result.title?.lowercased().contains(searchTerm.lowercased()) ?? false)
            }
            popularMovieListViewModel.filteredMovieModelList = filteredArray
            if !searchController.isBeingDismissed {
                popularMovieTableView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        popularMovieSearchController.searchBar.endEditing(true)
        popularMovieTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        popularMovieSearchController.isActive = false
        popularMovieSearchController.searchBar.endEditing(true)
        popularMovieSearchController.searchBar.showsCancelButton = false
        popularMovieTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        popularMovieSearchController.isActive = false
        popularMovieSearchController.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        popularMovieSearchController.isActive = true
        popularMovieSearchController.searchBar.showsCancelButton = true
        popularMovieTableView.reloadData()
    }
}
