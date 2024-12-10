//
//  ViewController.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 09/12/24.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    //MARK: Variables
    let image = UIImage(named: "Rick")!
    let characters: [Character] = [
        Character(id: 0,
                  name: "Rick",status: "Alive",species: "Human",type: "",gender: "",origin: Location(name: "", url: ""),location: Location(name: "", url: ""),image: "",episode: [],url: "",created: ""),
        Character(id: 1,
               name: "Morty",status: "Morty",species: "Alien",type: "",gender: "",origin: Location(name: "", url: ""),location: Location(name: "", url: ""),image: "",episode: [],url: "",created: ""),
        Character(id: 2,
               name: "Marge",status: "Marge",species: "Unknow",type: "",gender: "",origin: Location(name: "", url: ""),location: Location(name: "", url: ""),image: "",episode: [],url: "",created: ""),
        Character(id: 3,
               name: "Alice",status: "Alice",species: "Human",type: "",gender: "",origin: Location(name: "", url: ""),location: Location(name: "", url: ""),image: "",episode: [],url: "",created: "")
    ]
    
    //MARK: UIComponents
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        
        return tableView
    }()
    
    private func setupNavigationBar(){
        self.navigationItem.title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK: Setup UI
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
        
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            fatalError("The table view could not dequeue a Custom Cell in ViewController")
        }
        
        let characterInfo = self.characters[indexPath.row]
        cell.configure(image: self.image, name: characterInfo.name, specie: characterInfo.species)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
    
}
