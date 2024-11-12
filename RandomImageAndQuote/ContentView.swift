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
        NavigationStack {
            List(randomImageList.randomImages) { randomImage in
                HStack {
                    Image(uiImage: randomImage.image!)
                        .resizable()
                        .scaledToFit()
                    Text(randomImage.quote)
                }
            }
            .navigationTitle("Images")
            .task {
                await randomImageList.getRandomimages(ids: Array(100...200))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await randomImageList.getRandomimages(ids: Array(100...200))
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                    }

                }
            }
        }
    }
}

#Preview {
    ContentView()
}
