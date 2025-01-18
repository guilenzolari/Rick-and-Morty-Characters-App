//
//  CharactersDetailView.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 17/01/25.
//

import SwiftUI

struct CharactersDetailView: View {
    var character: Character
    var image: UIImage?
    
    var body: some View {
        NavigationStack {
            List {
                
                if let image = self.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: screenWidth(),
                               height: screenHeight() / 3)
                        .clipped()
                        .cornerRadius(30)
                        .listRowBackground(Color.clear)
                }

                CharactersInfoGridView()
                
            }
            .navigationTitle(character.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
//    CharactersDetailView(image: "Rick", caracterName: "Rick Sanchez")
}
