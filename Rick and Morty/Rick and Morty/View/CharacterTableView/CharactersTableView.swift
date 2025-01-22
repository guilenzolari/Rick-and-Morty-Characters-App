//
//  CharactersTableView.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 22/01/25.
//
import UIKit
import Foundation

final class CharactersTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.backgroundColor = .systemBackground
        self.allowsSelection = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
    }
}
