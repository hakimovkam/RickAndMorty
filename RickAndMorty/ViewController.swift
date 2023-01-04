//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 03.01.2023.
//

import UIKit

class ViewController: UIViewController {

    private let data = ["Rick Sanchez", "Morty Smith", "Summer Smith", "Beth Smith", "Jerry Smith", "Abadango Cluster Princess", "Abradolf Lincler", "Adjudicator Rick", "Agency Director", "Alan Rails", "Albert Einstein", "Alexander", "Alien Googah", "Alien Morty", "Alien Rick", "Amish Cyborg", "Annie", "Antenna Morty", "Antenna Rick", "Ants in my Eyes Johnson"]
    
    var characterManager = CharacterManager()
    
    let searchController = UISearchController(searchResultsController: nil)
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let button: UIButton = {
        let button = UIButton()
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        if #available(iOS 15.0, *) {
            button.configuration = .filled()
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 15.0, *) {
            button.configuration?.title = "Go!"
        } else {
            button.titleLabel?.text = "Go1"
        }
        if #available(iOS 15.0, *) {
            button.configuration?.baseBackgroundColor = .systemBlue
        } else {
            button.backgroundColor = .systemBlue
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupViews()
        setConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableView")

    }

    @objc func buttonPressed() {
        characterManager.performRequest(with: characterManager.urlString)
        
    }
}

class TableViewCell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
    
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return data.count }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableView", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    
}

//MARK: - setup Views
extension ViewController {
    
    func setupViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.title = "Rick and Morty"
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

//MARK: - CharacterManagerDelegate
extension ViewController: CharacterManagerDelegate {
    func didUpdateCharacter(_ characterManager: CharacterManager, character: CharacterModel) {
        print("updateData")
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
