//
//  MoviesListViewModel.swift
//  
//
//  Created by Al-attar on 23/04/2025.
//

import SwiftUI
import Combine
import Extensions
import Domain
import MoviesAPI
import AppEnvironment

// MARK: - MoviesListViewModel
public final class MoviesListViewModel: ObservableObject {
    
    // MARK: Private properties
    private let cancelBag: CancelBag
    private var currentPage = 1
    
    // MARK: Public properties
    @Published public var movies: [MovieAdapter] = []
    @Published public var filteredMovies: [MovieAdapter] = []
    @Published public var showError = false
    @Published public var showingSortingOption = false
    public var isMorePagesAvailable = false
    
    // MARK: UseCases
    let moviesUseCase: MoviesUseCaseProtocol
    let environment: AppEnvironmentProtocol
    private let navigationHandler: NavigationActionHandler
    
    // MARK: Initialization
    public init(
        moviesUseCase: MoviesUseCaseProtocol,
        environment: AppEnvironmentProtocol,
        navigationHandler: @escaping NavigationActionHandler
    ) {
        self.cancelBag = .init()
        self.moviesUseCase = moviesUseCase
        self.environment = environment
        self.navigationHandler = navigationHandler
    }
}

extension MoviesListViewModel {
    func viewDidAppear() {
        loadMovies()
    }
    
    func loadMoreMovies() {
        currentPage += 1
        loadMovies()
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }
}

// MARK: - Actions
extension MoviesListViewModel {
    enum Actions {
        case openMovieDetails(MovieAdapter)
    }
    
    func handleAction(_ action: Actions) {
        switch action {
        case .openMovieDetails(let adapter):
            handleOpenMovieDetailsAction(adapter)
        }
    }
    
    private func handleOpenMovieDetailsAction(_ adapter: MovieAdapter) {
        navigationHandler(.openMovieDetails(adapter))
    }
}

// MARK: - API Caller
extension MoviesListViewModel {
    public func loadMovies() {
        moviesUseCase
            .getMovies(
                page: currentPage
            )
            .receive(on: RunLoop.main)
            .toResult()
            .sink { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let response):
                    handleMovies(response)
                case .failure:
                    showError = true
                }
            }
            .store(in: cancelBag)
    }
    
    public func searchMovies(with query: String) {
        // First, clear the previous filtered results
        filteredMovies = []

        // If query is empty, just show the full list
        if query.isEmpty {
            filteredMovies = movies // Show all movies
            return
        }

        // Make the API call to search movies
        moviesUseCase
            .searchMovies(query: query)
            .receive(on: RunLoop.main)
            .toResult()
            .sink { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    // Handle the successful response
                    let imageBaseURL: String = self.environment.getValue(.apiImageBaseURL)
                    self.filteredMovies = response.results.compactMap {
                        MovieAdapter($0, baseImageURL: imageBaseURL) // Map API response to movie adapters
                    }
                case .failure:
                    // Handle failure
                    self.showError = true
                }
            }
            .store(in: cancelBag)
    }

    
    func handleMovies(_ response: MoviesListEntity) {
        isMorePagesAvailable = response.totalPages > response.page
        let imageBaseURL: String = environment.getValue(.apiImageBaseURL)
        movies.append(contentsOf: response.results.compactMap {
            MovieAdapter($0, baseImageURL: imageBaseURL)
        })
        filteredMovies = movies
    }
}

// MARK: - configration Cell
extension MoviesListViewModel {
    func configrationCell( _ cell : MovieCell , index : Int){
        let modelOfCell = movies[index]
        cell.configuration(viewModel: modelOfCell)
    }
}


// MARK: - Navigation
extension MoviesListViewModel {
    
    public typealias NavigationActionHandler = (MoviesListViewModel.NavigationAction) -> Void
    
    public enum NavigationAction {
        case openMovieDetails(MovieAdapter)
    }
}
