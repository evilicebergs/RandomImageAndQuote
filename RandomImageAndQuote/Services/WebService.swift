//
//  WebService.swift
//  RandomImageAndQuote
//
//  Created by Artem Golovchenko on 2024-11-12.
//

import Foundation

class WebService {
    
    func getImages(ids: [Int]) async throws -> [RandomImage] {
        
        var randomImages: [RandomImage] = []
        
        for id in ids {
            let randImage = try await decodeImage(id: id)
            randomImages.append(randImage)
        }
        
        return randomImages
    }
    
    private func decodeImage(id: Int) async throws -> RandomImage {
        
        guard let imageURL = Constants.imageURL(), let quoteURL = Constants.quoteURL else {
            throw NetworkError.badURL
        }
        
        async let (imageData, _) = URLSession.shared.data(from: imageURL)
        async let (quoteData, _) = URLSession.shared.data(from: quoteURL)
        
        guard let quote = try? JSONDecoder().decode(Quote.self, from: try await quoteData) else {
            throw NetworkError.decodingError
        }
        
        return RandomImage(image: try await imageData, quote: quote)
        
    }
    
}

enum NetworkError: Error {
    case badURL
    case invalidImage(Int)
    case decodingError
}
