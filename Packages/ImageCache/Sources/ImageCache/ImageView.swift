//
//  RemoteImageView.swift
//  
//
//  Created by Al-attar on 23/04/2025.
//

import SwiftUI

public struct RemoteImageView: View {
    
    @State private var image: Image?
    private let resource: RemoteImageResource
    
    /// Instanciate remote image resource
    /// - Parameter resource: instance of `RemoteImageResource`
    public init(resource: RemoteImageResource) {
        self.resource = resource
        self.image = resource.placeholder
    }
    
    func loadImage() {
        ImageCache.shared.load(
            url: NSURL(string: resource.url?.absoluteString ?? "")!
        ) { url, newImage in
            guard let newImage else { return }
            image = Image(uiImage: newImage)
        }
    }
    
    public var body: some View {
        ZStack {
            if let image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                EmptyView()
            }
        }
        .onAppear {
            loadImage()
        }
    }
}
