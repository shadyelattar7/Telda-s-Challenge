//
//  MoviesListEntity.swift
//  
//
//  Created by Al-attar on 23/04/2025.
//

import Foundation

public struct MoviesListEntity: Decodable, Equatable {
    
    public let page: Int
    public let results: [MovieEntity]
    public let totalPages: Int
    public let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    private init(
        page: Int,
        results: [MovieEntity],
        totalPages: Int,
        totalResults: Int
    ) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

extension MoviesListEntity {
    public static var mock: Self {
        .init(
            page: 1,
            results: [.mock, .mock],
            totalPages: 5,
            totalResults: 50
        )
    }
}
