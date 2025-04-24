//
//  MoviesListBuilder.swift
//  
//
//  Created by Al-attar on 23/04/2025.
//

import SwiftUI
import Domain
import AppEnvironment

public struct MoviesListBuilder {
    
    private init() { }
    
    public static func build(
        moviesUseCase: MoviesUseCaseProtocol,
        environment: AppEnvironmentProtocol,
        navigationHandler: @escaping MoviesListViewModel.NavigationActionHandler
    ) -> UIViewController {
        let view = MovieListViewController.init(
            nibName: MovieListViewController.Identifier,
            bundle: Bundle.module
        )
        let viewModel = MoviesListViewModel(
            moviesUseCase: moviesUseCase,
            environment: environment,
            navigationHandler: navigationHandler
        )
        view.configure(with: viewModel)
        return view
    }
}

