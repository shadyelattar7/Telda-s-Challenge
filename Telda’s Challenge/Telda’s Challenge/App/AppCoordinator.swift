//
//  AppCoordinator.swift
//  Telda’s Challenge
//
//  Created by Al-attar on 24/04/2025.
//

import UIKit
import Data
import Domain
import CoreNetwork
import Presentation
import AppEnvironment

/// Main application coordinator.
final class AppCoordinator {
    
    // MARK: Properties
    private weak var window: UIWindow?
    private let environment: AppEnvironmentProtocol
    private let rootController: UINavigationController
    
    // MARK: Initializationz
    init(
        window: UIWindow?,
        environment: AppEnvironmentProtocol = AppEnvironment.current,
        rootController: UINavigationController = UINavigationController()
    ) {
        self.window = window
        self.environment = environment
        self.rootController = rootController
    }
    
    // MARK: Start The Coordinator.
    func start() {
        // TODO: Use DIContainer for network, useCases and repos.
        let network = NetworkClient()
        let repo = MoviesRepository(netWork: network)
        let useCase = MoviesUseCase(repository: repo)
        
        let view = MoviesListBuilder.build(
            moviesUseCase: useCase,
            environment: environment
        ) { [weak self] destintation in
                guard let self else { return }
                switch destintation {
                case .openMovieDetails(let movieAdapter):
                    openMovieDetails(movieAdapter)
                }
            }
        self.rootController.viewControllers = [view]
        self.window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
}

private extension AppCoordinator {
    func openMovieDetails(_ movieAdapter: MovieAdapter) {
        let view = MovieDetailsBuilder.build(movieAdapter: movieAdapter)
        self.rootController.pushViewController(view, animated: true)
    }
}

