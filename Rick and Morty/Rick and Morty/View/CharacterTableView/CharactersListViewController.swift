//
//  ViewController.swift
//  Rick and Morty
//
//  Created by Guilherme Ferreira Lenzolari on 09/12/24.
//

import UIKit
import SwiftUI

protocol CharacterListViewProtocol: AnyObject {
    func updateCharacterList(with characters: [Character])
    func displayError(message: String)
}

final class CharactersListViewController: UIViewController {
    
    //MARK: Variables
    var presenter: CharacterListPresenter?
    private let image = UIImage(systemName: "person.circle.fill")!
    private let tableView = CharactersTableView()
    
    private var isLoadingMoreData = false
    private var filteredCharacters: [Character] = []
    private var isFiltering: Bool {
        return !(searchBar.text?.isEmpty ?? true)
    }

    private func setupNavigationBar(){
        self.navigationItem.title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Characters"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupUI()
        self.presenter?.fetchCharacters()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        showLoading()
    }
    
    //MARK: Setup UI
    private func setupUI() {
        buildwHierarchy()
        setupConstraint()
    }
}

extension CharactersListViewController {
    func setupConstraint() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    func buildwHierarchy() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        self.view.addSubview(searchBar)
        self.view.addSubview(loadingIndicator)
    }
}

extension CharactersListViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 100 {

            if !isLoadingMoreData {
                isLoadingMoreData = true
                presenter?.fetchCharacters()
                isLoadingMoreData = false
            }
        }
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCharacters.count : presenter?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            fatalError("The table view could not dequeue a Custom Cell in ViewController")
        }
        
        let characterInfo = isFiltering ? filteredCharacters[indexPath.row] : presenter?.characters[indexPath.row]
        cell.configure(image: self.image, name: characterInfo?.name ?? "Character Unavailable", specie: characterInfo?.species ?? "Specie Unavailable")
 
        if let character = characterInfo {
            presenter?.fetchCharacterImage(for: character, completion: { [weak cell] image in
                DispatchQueue.main.async {
                    cell?.updateImage(image)
                }
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let character = isFiltering ? filteredCharacters[indexPath.row] : presenter?.characters[indexPath.row]
        
        guard let selectedCharacter = character else { return }
        
        let characterDetailView = CharactersDetailView(
            character: selectedCharacter,
            presenter: self.presenter)
        
        let hostingController = UIHostingController(rootView: characterDetailView)
        
        self.navigationController?.pushViewController(hostingController, animated: true)
    }
}

extension CharactersListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCharacters = []
        } else {
            filteredCharacters = presenter?.characters.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            } ?? []
        }
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredCharacters = []
        tableView.reloadData()
    }
}

extension CharactersListViewController: CharacterListViewProtocol {
    func updateCharacterList(with characters: [Character]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.hideLoading()
        }
    }
    
    private func showLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }
    }

    private func hideLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }

    
    func displayError(message: String) {
        DispatchQueue.main.async {
            self.hideLoading()
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}



