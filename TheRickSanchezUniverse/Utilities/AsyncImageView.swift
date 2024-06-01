//
//  AsyncImageView.swift
//  TheRickSanchezUniverse
//
//  Created by Ahmed MAbdelfattah on 30/05/2024.
//

import SwiftUI
import Combine

struct AsyncImageView: View {
    @StateObject private var imageLoader: ImageLoader
    var imageURL: String
    
    init(imageURL: String) {
        self.imageURL = imageURL
        _imageLoader = StateObject(wrappedValue: ImageLoader(imageURL: imageURL))
    }
    
    var body: some View {
        Group {
            if let uiImage = imageLoader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .shadow(radius: 10)
            } else {
                Color.gray.frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let imageURL: String
    
    init(imageURL: String) {
        self.imageURL = imageURL
        load()
    }
    
    func load() {
        if let cachedImage = ImageCache.shared.object(forKey: NSString(string: imageURL)) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil, let downloadedImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                ImageCache.shared.setObject(downloadedImage, forKey: NSString(string: self.imageURL))
                self.image = downloadedImage
            }
        }.resume()
    }
}

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}
