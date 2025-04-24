//
//  MoviesRepository.swift
//  
//
//  Created by Al-attar on 23/04/2025.
//

import Foundation
import Combine
import CoreNetwork
import Domain
import MoviesAPI

// MARK: - MoviesRepository
public final class MoviesRepository {

    // MARK: Private Properties
    private let netWork: NetworkClientProtocol
    
    // MARK: Initialization
    public init(netWork: NetworkClientProtocol) {
        self.netWork = netWork
    }
}

// MARK: - MoviesRepositoryProtocol
extension MoviesRepository: MoviesRepositoryProtocol {
    public func getMovies(
        page: Int
    ) -> AnyPublisher<MoviesListEntity, Error> {
        netWork.send(
            MoviesListEntity.self,
            endpoint: MoviesEndpoint.getMovies(
                page: page
            )
        )
    }
    
    public func getMovieDetails(
        movieId: Int
    ) -> AnyPublisher<MovieEntity, Error> {
        netWork.send(
            MovieEntity.self,
            endpoint: MoviesEndpoint.getMoviesDetails(movieId: movieId)
        )
    }
    
    public func searchMovies(
        query: String
    ) -> AnyPublisher<MoviesListEntity, Error> {
        netWork.send(
            MoviesListEntity.self,
            endpoint: MoviesEndpoint.searchMovies(query: query)
        )
    }
}

