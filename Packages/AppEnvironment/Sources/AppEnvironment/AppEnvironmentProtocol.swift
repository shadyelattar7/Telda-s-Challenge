//
//  AppEnvironmentProtocol.swift
//  
//
//  Created by Al-attar on 23/04/2025.
//

import Foundation

/// A protocol defining the interface for accessing environment-related information.
public protocol AppEnvironmentProtocol {
    /// Indicates whether the application is in debug mode.
    var isDebug: Bool { get }
    
    /// Indicates whether the application is in release mode.
    var isRelease: Bool { get }
    
    /// Retrieves a typed value for a given configuration key from the environment.
    ///
    /// - Parameters:
    ///   - key: The configuration key for which the value needs to be retrieved.
    ///
    /// - Returns: The value associated with the specified configuration key, cast to the type specified by the caller.
    ///
    /// - Note: This method is designed to retrieve values from environment configurations, such as info.plist or a custom configuration file.
    ///         It is the responsibility of the conforming type to handle the casting and retrieval of values based on the provided key.
    ///
    /// - Example:
    ///   ```swift
    ///   let apiKey: String = environment.getValue(.apiSecretKey)
    ///   ```
    ///
    /// - Warning: Ensure that the provided `EnvironmentConfigurationKeys` is valid and corresponds to the expected type.
    ///            Incorrect key types may result in runtime errors or unexpected behavior.
    func getValue<T>(
        _ key: EnvironmentConfigurationKeys
    ) -> T
}
