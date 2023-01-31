//
//  ViewController.swift
//  TVShowInfo
//
//  Created by Brendon Crowe on 1/30/23.
//

import UIKit

class ShowSearchController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var shows = [ShowDetails]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet {
            loadShows()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
    }
    
    private func configVC() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    private func loadShows() {
        ShowAPIClient.getShows(searchQuery: searchQuery) { [weak self] result in
            switch result {
            case .failure(let appError):
                print("there was an error \(appError)")
            case.success(let shows):
                self?.shows = shows
            }
        }
    }
}

extension ShowSearchController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowCell else {
            fatalError("could not load show Cell")
        }
        
        let show = shows[indexPath.row]
        cell.configureCell(for: show)
        return cell
    }
}

extension ShowSearchController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}

extension ShowSearchController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            shows.removeAll()
            return
        }
        searchQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "beef"
    }
}
