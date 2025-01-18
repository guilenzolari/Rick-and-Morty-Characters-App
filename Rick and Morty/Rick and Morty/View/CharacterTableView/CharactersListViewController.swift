//
//  ViewController.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 09/12/24.
//

import UIKit

protocol CharacterListViewProtocol: AnyObject {
    func updateCharacterList(with characters: [Character])
    func displayError(message: String)
}

final class CharactersListViewController: UIViewController {
    
    //MARK: Variables
    var presenter: CharacterListPresenter?
    private let image = UIImage(named: "Rick")!
    
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
        self.presenter?.fetchCharacters()
        
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
        return self.presenter?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            fatalError("The table view could not dequeue a Custom Cell in ViewController")
        }
        
        let characterInfo = self.presenter?.characters[indexPath.row]
        cell.configure(image: self.image, name: characterInfo?.name ?? "Name Unavailable", specie: characterInfo?.species ?? "Especie Unavailable")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
}

extension CharactersListViewController: CharacterListViewProtocol {
    func updateCharacterList(with characters: [Character]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func displayError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}



