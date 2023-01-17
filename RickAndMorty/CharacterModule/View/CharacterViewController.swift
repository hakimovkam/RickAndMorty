//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 03.01.2023.
//

import UIKit

class CharacterViewController: UIViewController {
    
    var presenter: CharacterViewPresenterProtocol!
    
    //MARK: - UI elements
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.1540856957, green: 0.1691044867, blue: 0.1987410784, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
        private let searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            return searchBar
        }()
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.1540856957, green: 0.1691044867, blue: 0.1987410784, alpha: 1)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "CharacterTableView")
        
        setupViews()
        setConstraints()
        
    }


}

class TableViewCell: UITableViewCell {
    
}

extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return presenter?.characters?.results.count ?? 0 }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableView", for: indexPath)
        let character = presenter?.characters?.results[indexPath.row]
        cell.textLabel?.text = character?.name
        cell.textLabel?.textColor = .white
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = #colorLiteral(red: 0.1540856957, green: 0.1691044867, blue: 0.1987410784, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.2247067988, green: 0.2396971881, blue: 0.2693860531, alpha: 1)
        }
        return cell
    }
}

extension CharacterViewController: CharacterViewProtocol {
    func didUpdateCharacters() {
        tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

extension CharacterViewController {
    func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.1540856957, green: 0.1691044867, blue: 0.1987410784, alpha: 1)
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.title = "Rick and Morty"
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            ])
    }
}
