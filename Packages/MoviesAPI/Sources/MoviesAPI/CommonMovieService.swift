//
//  CommonMovieService.swift
//  
//
//  Created by Al-attar on 23/04/2025.
//

import Foundation
import AppEnvironment

/// Common urls that will be used, not the best place to read from Environment directly, should be injected with a environment protocol.
// TODO: Modify this logic to be got injected from AppEnvironment.
public enum CommonMovieService {
    
    static let supportedLanguages = Set(Bundle.main.localizations)
    
    public static var baseURL: String {
        let apiBaseURL: String = AppEnvironment.current.getValue(.apiBaseURL)
        let apiVersion: String = AppEnvironment.current.getValue(.apiVersion)
        return "https://\(apiBaseURL)/\(apiVersion)"
    }
    
    public static var baseImagesURL: String {
        let apiImageBaseURL: String = AppEnvironment.current.getValue(.apiImageBaseURL)
        return "https://\(apiImageBaseURL)"
    }
    
    public static var apiKey: String {
        AppEnvironment.current.getValue(.apiKey)
    }
    
    public static var language: String {
        guard let current = Locale.current.language.languageCode?.identifier,
              CommonMovieService.supportedLanguages.contains(current) else {
            return "en"
        }
        return current
    }
    
    public static var queryItems: [URLQueryItem] {
        let apiKeyItem = URLQueryItem(name: "api_key", value: CommonMovieService.apiKey)
        let language = URLQueryItem(name: "language", value: CommonMovieService.language)
        return [apiKeyItem, language]
    }
}
