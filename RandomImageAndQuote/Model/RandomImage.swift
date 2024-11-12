//
//  RandomImage.swift
//  RandomImageAndQuote
//
//  Created by Artem Golovchenko on 2024-11-12.
//

import Foundation

struct RandomImage: Decodable {
    let image: Data
    let quote: Quote
}

struct Quote: Decodable {
    let content: String
}
