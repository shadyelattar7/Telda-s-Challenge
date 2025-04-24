//
//  MoviesEndpoint.swift
//
//
//  Created by Al-attar on 23/04/2025.
//

import Foundation
import CoreNetwork

public enum MoviesEndpoint {
    case getMovies(page: Int)
    case getMoviesDetails(movieId: Int)
    case searchMovies(query: String)
}

extension MoviesEndpoint: HTTPEndpoint {
    public var baseURL: String {
        CommonMovieService.baseURL
    }
    
    public var path: String {
        switch self {
        case .getMovies:
            return "/discover/movie"
        case .getMoviesDetails(let movieId):
            return "/movie/\(movieId)"
        case .searchMovies:
            return "/search/movie"
        }
    }
    
    public var method: HttpMethod {
        .get
    }
    
    public var httpBody: Encodable? {
        nil
    }
    
    public var headers: [String : String]? {
        nil
    }
    
    public var queryParameters: [URLQueryItem]? {
        switch self {
        case .getMovies(let page):
            var customeQueries = [
                URLQueryItem(name: "page", value: "\(page)")
            ]
            customeQueries.append(contentsOf: CommonMovieService.queryItems)
            return customeQueries
        case .getMoviesDetails:
            return CommonMovieService.queryItems
        case .searchMovies(let query):
            var customQueries = [
                URLQueryItem(name: "query", value: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            ]
            customQueries.append(contentsOf: CommonMovieService.queryItems)
            return customQueries
        }
    }
    
    public var timeout: TimeInterval? {
        30
    }
}
