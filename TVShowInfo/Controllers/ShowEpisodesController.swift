//
//  ShowEpisodesController.swift
//  TVShowInfo
//
//  Created by Brendon Crowe on 2/1/23.
//

import UIKit

class ShowEpisodesController: UIViewController {
    
    
    var showID: Int = 0
    
    var episodes = [Episode]() {
        didSet {
           getSeasonSections()
        }
    }
    
    var seasonSections = [[Episode]]() {
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
        tableView.delegate = self
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
    
    private func getSeasonSections() {
        let sortedEpisodes = episodes.sorted { $0.season < $1.season }
        let uniqueSeasons = Set(sortedEpisodes.map { $0.season })
        var sections = Array(repeating: [Episode](), count: uniqueSeasons.count)
        var currentIndex = 0
        var currentSeason = sortedEpisodes.first?.season ?? 0
        
        for episode in sortedEpisodes {
            if episode.season == currentSeason {
                sections[currentIndex].append(episode)
            } else {
                currentIndex += 1
                currentSeason = episode.season
                sections[currentIndex].append(episode)
            }
        }
        seasonSections = sections
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController else {
            fatalError("could not load navigationController ")
        }
        guard let episodeDVC = navController.viewControllers.first as? EpisodeDetailController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Could not load EpisodeDetailController")
        }
        episodeDVC.episode = seasonSections[indexPath.section][indexPath.row]
    }
    
    @IBAction func dismissView(_ segue: UIStoryboardSegue) {
        dismiss(animated: true)
    }

}

extension ShowEpisodesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(seasonSections[section].first?.season ?? 0)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasonSections[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return seasonSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodeCell else {
            fatalError("could not dequeue an episodeCell")
        }
        let episode = seasonSections[indexPath.section][indexPath.row]
        cell.configureCell(for: episode)
        return cell
    }
}

extension ShowEpisodesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
