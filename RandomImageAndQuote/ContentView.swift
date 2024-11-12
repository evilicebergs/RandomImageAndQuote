//
//  ContentView.swift
//  RandomImageAndQuote
//
//  Created by Artem Golovchenko on 2024-11-12.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var randomImageList = ViewModel()
    
    var body: some View {
        List(randomImageList.randomImages) { randomImage in
            HStack {
                Image(uiImage: randomImage.image!)
                    .resizable()
                    .scaledToFit()
                Text(randomImage.quote)
            }
        }
        .task {
            await randomImageList.getRandomimages(ids: Array(100...200))
        }
    }
}

#Preview {
    ContentView()
}
