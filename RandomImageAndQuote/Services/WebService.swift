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
        
        try await withThrowingTaskGroup(of: (Int, RandomImage).self) { group in
            for id in ids {
                group.addTask {
                    return (id, try await self.decodeImage(id: id))
                }
            }
            for try await (_, img) in group {
                randomImages.append(img)
            }
        }
        return randomImages
    }
    
    private func decodeImage(id: Int) async throws -> RandomImage {
        
        guard let imageURL = Constants.imageURL() else {
            throw NetworkError.badURL
        }
        
        async let (imageData, _) = URLSession.shared.data(from: imageURL)
        //async let (quoteData, _) = URLSession.shared.data(from: quoteURL)
        
//        guard let quote = try? JSONDecoder().decode(Quote.self, from: try await quoteData) else {
//            throw NetworkError.decodingError
//        }
        let quote = Quote(content: "Testing Quote")
        
        return RandomImage(image: try await imageData, quote: quote)
        
    }
    
}

enum NetworkError: Error {
    case badURL
    case invalidImage(Int)
    case decodingError
}
