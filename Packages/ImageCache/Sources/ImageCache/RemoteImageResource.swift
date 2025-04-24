//
//  RemoteImageResource.swift
//
//
//  Created by Al-attar on 23/04/2025.
//

import SwiftUI

public struct RemoteImageResource: Hashable {
    public let url: URL?
    public let placeholder: Image?
    
    /// Initialize resouce object
    /// - Parameters:
    ///   - path: original path from API response. Internally this pasth will be modified. For more details, please check `makeUrlWithDeviceScale` method
    ///   - placeholder: placeholder image that will be displayed while target image is loading or in error cases
    public init(
        path: String,
        placeholder: Image?
    ) {
        self.url = URL(string: path)
        self.placeholder = placeholder
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.url)
    }
}
