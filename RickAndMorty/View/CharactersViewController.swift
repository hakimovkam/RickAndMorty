//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Камиль Хакимов on 03.01.2023.
//

import UIKit

final class CharactersViewController: UIViewController {
    
    private var data: [CharacterModel] = []
    
    private var page: Int = 0
    
    var characterManager = CharacterManager()
    
    let searchController = UISearchController(searchResultsController: nil)
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.1540856957, green: 0.1691044867, blue: 0.1987410784, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let button: UIButton = {
        let button = UIButton()

        button.addTarget(self, action: #selector(loadNewCharacter), for: .touchUpInside)
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
            button.configuration?.baseBackgroundColor = #colorLiteral(red: 1, green: 0.5963680148, blue: 0, alpha: 1)
        } else {
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5963680148, blue: 0, alpha: 1)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterManager.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableView")
        
        loadNewCharacter()
        setupViews()
        setConstraints()
    }

    @objc func loadNewCharacter() {
        self.characterManager.performRequestCharacter(with: self.characterManager.urlString)
        page += 1
    }
}

//MARK: - CharacterManagerDelegate
extension CharactersViewController: CharacterManagerDelegate {
    
    func didUpdateCharacter(_ characterManager: CharacterManager, character: [CharacterModel]) {
        DispatchQueue.main.async {
            for i in 0...19 {
                self.data.append(character[i])
            }
            self.tableView.reloadData()
            
            let indexPath = IndexPath(row: self.data.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


//MARK: - TableViewCell
class TableViewCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
    
}

//MARK: - UITableViewDelegate
extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return data.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableView", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].name
        cell.textLabel?.textColor = .white
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = #colorLiteral(red: 0.1540856957, green: 0.1691044867, blue: 0.1987410784, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.2247067988, green: 0.2396971881, blue: 0.2693860531, alpha: 1)
        }
        
        cell.imageView?.image = UIImage(named: "1")
        return cell
    }
    
}

//MARK: - setup Views
extension CharactersViewController {
    
    func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.1540856957, green: 0.1691044867, blue: 0.1987410784, alpha: 1 )
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Rick and Morty"
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
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

/* add function of hide and show search bar programatically */
