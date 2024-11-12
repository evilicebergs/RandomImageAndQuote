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
        
        
        
    }
    
}
