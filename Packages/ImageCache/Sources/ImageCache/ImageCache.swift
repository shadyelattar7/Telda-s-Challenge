// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit

public class ImageCache {
    
    public static let shared = ImageCache()
    private let urlSession: URLSession
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [NSURL: [(NSURL, UIImage?) -> Void]]()
    private var runningRequests = [NSURL: URLSessionDataTask]()
    
    public final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    public init(session: URLSession = URLSession.shared) {
        self.urlSession = session
    }
    
    public final func load(
        url: NSURL,
        queue: DispatchQueue = .main,
        completion: @escaping (NSURL, UIImage?) -> Void
    ) {
        if let cachedImage = image(url: url) {
            queue.async {
                completion(url, cachedImage)
            }
            return
        }
        
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        
        let task = urlSession.dataTask(with: url as URL) { data, _, error in
            defer {
                self.runningRequests.removeValue(forKey: url)
                self.loadingResponses.removeValue(forKey: url)
            }
            guard let responseData = data,
                  let image = UIImage(data: responseData),
                  let blocks = self.loadingResponses[url],
                  error == nil
            else {
                queue.async {
                    completion(url, nil)
                }
                return
            }
            
            self.cachedImages.setObject(image, forKey: url, cost: responseData.count)
            
            for block in blocks {
                queue.async {
                    block(url, image)
                }
                return
            }
        }
        
        task.resume()
        runningRequests[url] = task
    }
    
    public func cancelLoad(_ url: NSURL) {
        runningRequests[url]?.cancel()
        runningRequests.removeValue(forKey: url)
    }
}
