//
//  MovieListViewController.swift
//
//
//  Created by Al-attar on 23/04/2025.
//

import UIKit
import Extensions
import Combine

class MovieListViewController: UIViewController {
    
    // MARK: Identifier
    public static let Identifier = String(describing: MovieListViewController.self)
    
    
    //MARK: - @IBOutlet
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    //MARK: - Properties
    private var viewModel: MoviesListViewModel!
    private let cellScaling: CGFloat = 0.6
    private var cancellables = Set<AnyCancellable>()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchResultsTableView: UITableView!
    private var isSearchActive = false
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupCollectionView()
        setupSearchController()
        setupNavigationBar()
    }
    
    //MARK: - Private func
    private func bind() {
        viewModel.viewDidAppear()
        viewModel.$movies
            .sink { [weak self] _ in
                self?.movieCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$filteredMovies
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.searchResultsTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setupCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        let nib = UINib(nibName: "MovieCell", bundle: Bundle.module)
        movieCollectionView.register(nib, forCellWithReuseIdentifier: "MovieCell")
        customLayout()
    }
    
    private func setupNavigationBar() {
        title = "Home"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemRed]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupSearchController() {
        // Create and configure the search results table view
        searchResultsTableView = UITableView()
        
        // Add the table view to the view hierarchy
        view.addSubview(searchResultsTableView)
        
        // Disable autoresizing mask translation to use Auto Layout
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set Auto Layout constraints
        NSLayoutConstraint.activate([
            searchResultsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchResultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchResultCell")
        searchResultsTableView.isHidden = true
        
        // Set the table's background to clear
        searchResultsTableView.backgroundColor = .clear
        
        // Configure the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        searchController.searchBar.tintColor = .white
        
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    //MARK: - Public func
    public func configure(with viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: - Collection View Delegation and Data Source
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: MovieCell.self, for: indexPath)
        viewModel.configrationCell(cell, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = self.viewModel.movies[indexPath.row]
        viewModel.handleAction(.openMovieDetails(selectedMovie))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230, height: 400)
    }
    
    func customLayout(){
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = movieCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        movieCollectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
    }
}

extension MovieListViewController: UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let collectionView = scrollView as? UICollectionView {
             let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
             let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
             
             var offset = targetContentOffset.pointee
             let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
             let roundedIndex = round(index)
             
             offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
             targetContentOffset.pointee = offset
         }
    }
}

// MARK: - UISearchResultsUpdating
extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {
            return
        }
        viewModel.searchMovies(with: query)
        isSearchActive = !query.isEmpty
        if isSearchActive {
            movieCollectionView.isHidden = true
            searchResultsTableView.isHidden = false
        } else {
            movieCollectionView.isHidden = false
            searchResultsTableView.isHidden = true
        }
    }
}

// MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
        movieCollectionView.isHidden = false
        searchResultsTableView.isHidden = true
    }
}

//MARK: - Table View Delegation and Data Source
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        let movie = viewModel.filteredMovies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = viewModel.filteredMovies[indexPath.row]
        viewModel.handleAction(.openMovieDetails(selectedMovie))
    }
}
