//
//  MovieAdapter.swift
//  
//
//  Created by Al-attar on 23/04/2025.
//

import Foundation
import Domain
import Extensions

public struct MovieAdapter: Identifiable, Hashable {
    
    public typealias ID = Int
    
    public let id: Int
    public let title: String
    public let overview: String
    public let posterTiny: String
    public let posterOriginal: String
    public let voteAverage: Double
    public let releaseDate: String?
}

// MARK: - Initialization from entities
extension MovieAdapter {
    
    /// Initialize adapter object from given movie entity
    /// - Parameters:
    ///   - movie: base entity
    ///   - baseImageURL: url for the image
    public init(
        _ movie: MovieEntity,
        baseImageURL: String
    ) {
        self.id = movie.id
        self.title = movie.title
        self.overview = movie.overview
        
        self.posterTiny = Self.generatePosterLink(
            baseImageURL: baseImageURL,
            path: movie.posterPath,
            size: .w154
        )
        self.posterOriginal = Self.generatePosterLink(
            baseImageURL: baseImageURL,
            path: movie.posterPath,
            size: .original
        )
        self.voteAverage = (movie.voteAverage * 10).rounded() / 10
        self.releaseDate = movie.releaseDate?.extractYear()
    }
    
    private static func generatePosterLink(
        baseImageURL: String,
        path: String?,
        size: MovieImageSize
    ) -> String {
        return "https://\(baseImageURL)\(size)\(path ?? "")"
    }
}

// MARK: - Mocks
extension MovieAdapter {
    static var mock: MovieAdapter {
        .init(
            id: 1,
            title: "Movie Name",
            overview: "Movie OverView, Movie OverView, Movie OverView, Movie OverView, Movie OverView.",
            posterTiny: "Image Poster Path URL",
            posterOriginal: "Image Poster Path URL",
            voteAverage: 6.9,
            releaseDate: "1994"
        )
    }
}
