//
//  CustomCharacterInfoSectionView.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 17/01/25.
//

import SwiftUI

struct CustomCharacterInfoSectionView: View {
    var symbol: String
    var sectionName: String
    var info: String
    
    var body: some View {
        VStack {
            HStack {
                Text(Image(systemName: symbol))
                Text(sectionName)
                Spacer()
            }.foregroundStyle(.secondary)
            
            HStack {
                Spacer()
                Text(info)
                    .font(.title2)
                    .padding()
                Spacer()
            }
        }
        .cornerRadius(12)
    }
}

#Preview {
    CustomCharacterInfoSectionView(
        symbol: "heart.fill",
        sectionName: "STATUS",
        info: "Alive")
}
