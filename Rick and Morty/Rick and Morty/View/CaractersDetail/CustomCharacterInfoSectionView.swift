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
        HStack {
            HStack {
                Text(Image(systemName: symbol))
                Text(sectionName)
            }.foregroundStyle(.secondary)
            
            Spacer()
            
            HStack {
                Text(info)
            }
        }
    }
}

#Preview {
    CustomCharacterInfoSectionView(
        symbol: "heart.fill",
        sectionName: "STATUS",
        info: "Alive")
}
