//
//  File.swift
//  
//
//  Created by Al-attar on 23/04/2025.
//

import UIKit

public struct MovieDetailsBuilder {
    
    private init() { }
    
    public static func build(
        movieAdapter: MovieAdapter
    ) -> UIViewController {
        let view = MovieDetailsViewController.init(
            nibName: MovieDetailsViewController.Identifier,
            bundle: Bundle.module
        )
        view.movieAdapter = movieAdapter
        return view
    }
}
