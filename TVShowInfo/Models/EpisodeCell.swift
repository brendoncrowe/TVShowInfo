//
//  EpisodeCell.swift
//  TVShowInfo
//
//  Created by Brendon Crowe on 2/2/23.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeAirDateLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeImageView: UIImageView!
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        episodeImageView.layer.cornerRadius = 8
        episodeImageView.layer.borderWidth = 0.25
    }
    
    
    func configureCell(for episode: Episode) {
        guard let episodeImageString = episode.image?.medium else {
            return
        }
        episodeTitleLabel.text = episode.name
        episodeAirDateLabel.text = episode.airdate
        episodeNumberLabel.text = "episode \(String(episode.number))"
        
        episodeImageView.getImage(with: episodeImageString) { [weak self] result in
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
