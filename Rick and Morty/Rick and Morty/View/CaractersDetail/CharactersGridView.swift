//
//  CharactersGridView.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 17/01/25.
//
import SwiftUI

struct CharactersInfoGridView: View {
    let data = [
        ("heart.fill", "STATUS", "Alive"),
        ("person.fill", "SPECIE", "Human"),
        ("figure.stand.dress.line.vertical.figure", "GENDER", "Male"),
        ("questionmark.circle.fill", "TYPE", "Normal"),
        ("globe", "ORIGIN", "Earth"),
        ("house.fill", "LOCATION", "Citadel of Ricks")
    ]
    
    var body: some View {
        ForEach(0..<data.count / 2, id: \.self) { row in
            HStack {
                let leftItem = data[row * 2]
                CustomCharacterInfoSectionView(
                    symbol: leftItem.0,
                    sectionName: leftItem.1,
                    info: leftItem.2
                )
                .frame(maxWidth: .infinity)
                
                if (row * 2 + 1) < data.count {
                    let rightItem = data[row * 2 + 1]
                    CustomCharacterInfoSectionView(
                        symbol: rightItem.0,
                        sectionName: rightItem.1,
                        info: rightItem.2
                    )
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

#Preview {
    CharactersInfoGridView()
}
