//
//  CharactersDetailView.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 17/01/25.
//

import SwiftUI

struct CharactersDetailView: View {
    var character: Character
    let casesOfError: [String] = ["unknown", ""]
    var presenter: CharacterListPresenter?
    
    private var characterInfo: [(symbol: String, title: String, value: String)] {
        [
            ("heart.fill", "Status", character.status),
            ("person.fill", "Specie", character.species),
            ("figure.stand.dress.line.vertical.figure", "Gender", character.gender),
            ("questionmark.circle.fill", "Type", character.type),
            ("globe", "Origin", character.origin.name),
            ("house.fill", "Location", character.location.name)
        ]
            .filter { !casesOfError.contains($0.value)}
    }
    
    var body: some View {
            List {
                if let presenter = self.presenter {
                    if let image = presenter.cache.getImage(for: character.id) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: screenWidth(), height: screenHeight() / 3)
                            .clipped()
                            .cornerRadius(30)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .listRowBackground(Color.clear)
                    }
                }

                
                Section {
                    ForEach(characterInfo, id: \.title) { info in
                        CustomCharacterInfoSectionView(
                            symbol: info.symbol,
                            sectionName: info.title,
                            info: info.value
                        ).padding()
                    }
                }
            }
            .navigationTitle(character.name)
    }
}
