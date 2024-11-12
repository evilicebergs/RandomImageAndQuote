//
//  ViewModel.swift
//  RandomImageAndQuote
//
//  Created by Artem Golovchenko on 2024-11-12.
//

import Foundation
import UIKit

@MainActor
class ViewModel: ObservableObject {
    
    @Published var randomImages: [ImageViewModel] = []
    
    func getRandomimages(ids: [Int]) async {
        do {
            let randomImages = try await WebService().getImages(ids: ids)
            self.randomImages = randomImages.map(ImageViewModel.init)
        } catch {
            print(error)
        }
    }
    
}

struct ImageViewModel: Identifiable {
    
    let id = UUID()
    fileprivate let randomImage: RandomImage
    
    var image: UIImage? {
        UIImage(data: randomImage.image)
    }
    
    var quote: String {
        randomImage.quote.content
    }
}
