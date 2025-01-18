//
//  CharactersDetailView.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 17/01/25.
//

import SwiftUI

struct CharactersDetailView: View {
    var image: String
    let padding: CGFloat = 16
    var caracterName: String
    
    var body: some View {
        NavigationStack {
            List {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: screenWidth() - 2 * padding,
                           height: screenHeight() / 3)
                    .clipped()
                    .cornerRadius(30)
                    .listRowBackground(Color.clear)
                
                CharactersInfoGridView()
                
            }
            .navigationTitle(caracterName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CharactersDetailView(image: "Rick", caracterName: "Rick Sanchez")
}
