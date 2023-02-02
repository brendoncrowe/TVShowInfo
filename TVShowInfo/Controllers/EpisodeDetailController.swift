//
//  EpisodeDetailController.swift
//  TVShowInfo
//
//  Created by Brendon Crowe on 2/2/23.
//

import UIKit

class EpisodeDetailController: UIViewController {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeDescription: UITextView!
    
    var episode: Episode?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    private func updateUI() {
        if let episode = episode {
            let episodeSummary = episode.summary?.replacingOccurrences(of:"<p>", with: "").replacingOccurrences(of: "</p>", with: "").replacingOccurrences(of: "<i>", with: "").replacingOccurrences(of: "</i>", with: "").replacingOccurrences(of: "<br>", with: "").replacingOccurrences(of: "</br>", with: "")
            episodeTitleLabel.text = episode.name
            episodeDescription.text = episodeSummary
            episodeImageView.getImage(with: episode.image!.medium) { [weak self] result in
                switch result {
                case .failure:
                    DispatchQueue.main.async {
                        self?.episodeImageView.image = UIImage(systemName: "exclamationmark.triangle")
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.episodeImageView.image = image
                    }
                }
            }
        }
    }
}
