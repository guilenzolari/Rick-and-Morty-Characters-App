//
//  CustomCell.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 09/12/24.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .label
        return imageView
    }()
    
    private let characterName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.text = "Error"
        return label
    }()
    
    private let characterSpecie: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.text = "Error"
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray // Cor padrão do chevron
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(image: UIImage, name: String, specie: String) {
        self.myImageView.image = image
        self.characterName.text = name
        self.characterSpecie.text = specie
    }
    
    private func setupUI() {
        self.contentView.addSubview(myImageView)
        self.contentView.addSubview(characterName)
        self.contentView.addSubview(characterSpecie)
        self.contentView.addSubview(chevronImageView)
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        characterName.translatesAutoresizingMaskIntoConstraints = false
        characterSpecie.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Constraints para myImageView
            myImageView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            myImageView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            myImageView.heightAnchor.constraint(equalToConstant: 60),
            myImageView.widthAnchor.constraint(equalToConstant: 60),
            
            // Constraints para characterName
            characterName.leadingAnchor.constraint(equalTo: self.myImageView.trailingAnchor, constant: 16),
            characterName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            characterName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: -20),
            characterName.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            // Constraints para characterSpecie
            characterSpecie.leadingAnchor.constraint(equalTo: self.myImageView.trailingAnchor, constant: 16),
            characterSpecie.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            characterSpecie.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            characterSpecie.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 9),
            
            // Constraints para chevronImageView
            chevronImageView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            chevronImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 12),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
        // Tornando a imagem redonda
        myImageView.layer.cornerRadius = 30 // Metade da largura/altura
        myImageView.clipsToBounds = true
        
    }
}
