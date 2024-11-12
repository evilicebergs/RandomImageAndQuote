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
        
        randomImages = []
        do {
            //this version waits to the end of downloading
//            let randomImages = try await WebService().getImages(ids: ids)
//            self.randomImages = randomImages.map(ImageViewModel.init)
            
            //add images to view concurrently
            try await withThrowingTaskGroup(of: (Int, RandomImage).self) { group in
                
                for id in ids {
                    group.addTask {
                        return (id, try await WebService().decodeImage(id: id))
                    }
                }
                
                for try await (_, img) in group {
                    randomImages.append(ImageViewModel(randomImage: img))
                }
                
            }
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
