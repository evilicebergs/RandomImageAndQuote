//
//  Constants.swift
//  RandomImageAndQuote
//
//  Created by Artem Golovchenko on 2024-11-12.
//

import Foundation

struct Constants {
    
    static func imageURL() -> URL? {
        return URL(string: "https://picsum.photos/200/300?uuid\(UUID().uuidString)")
    }
    
    static let quoteURL = URL(string: "https://api.quotable.io/random")
}
