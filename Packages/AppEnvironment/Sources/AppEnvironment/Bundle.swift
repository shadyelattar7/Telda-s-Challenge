//
//  BundleProtocol.swift
//  
//
//  Created by Al-attar on 23/04/2025.
//

import Foundation

protocol BundleProtocol {
    func getConfigValue(key: String) -> String?
}

extension Bundle: BundleProtocol {
    private static let ConfigurationKeys = "ConfigurationKeys"
    
    func getConfigValue(key: String) -> String? {
        guard let configDictionary = self.object(forInfoDictionaryKey: Bundle.ConfigurationKeys) as? [String : String], let configValue = configDictionary[key] else {
            return nil
        }
        return configValue
    }
}
