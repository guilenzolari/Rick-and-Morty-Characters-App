//
//  ScreenSize+View.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 17/01/25.
//

import SwiftUI

extension View {
    /// Retorna a largura da tela
    func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }

    /// Retorna a altura da tela
    func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
