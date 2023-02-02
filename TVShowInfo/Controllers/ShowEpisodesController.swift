//
//  ShowEpisodesController.swift
//  TVShowInfo
//
//  Created by Brendon Crowe on 2/1/23.
//

import UIKit

class ShowEpisodesController: UIViewController {
    
    
    var showID: Int = 0 {
        didSet {
            print(showID)
        }
    }
    
    var episodes = [Episode]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        loadData()
    }
    
    private func configVC() {
        tableView.dataSource = self
    }
    
    private func loadData() {
        EpisodeAPIClient.getEpisodes(with: showID) { result in
            switch result {
            case .failure(let appError):
                print("There was an error: \(appError)") // if this was a production app, print would NOT be used here as well as in other places in the app
            case .success(let episodes):
                self.episodes = episodes
            }
        }
    }
}

extension ShowEpisodesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        let episode = episodes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = episode.name
        content.secondaryText = "Season \(String(episode.season))"
        cell.contentConfiguration = content
        return cell
    }
}
