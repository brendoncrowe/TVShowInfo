//
//  ShowCell.swift
//  TVShowInfo
//
//  Created by Brendon Crowe on 1/30/23.
//

import UIKit
import ImageKit

class ShowCell: UITableViewCell {
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var showRatingLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        showImageView.layer.cornerRadius = 16
        showImageView.layer.borderWidth = 0.25
    }
    
    func configureCell(for show: Show) {
        let showImageURL = show.show.image.medium
        showTitleLabel.text = show.show.name
        if let average = show.show.rating.average {
            showRatingLabel.text = "Rating: \(String(format: "%.2f", average))"
        } else {
            showRatingLabel.text = "Rating: N/A"
        }
        showImageView.getImage(with: showImageURL) { [weak self] result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.showImageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.showImageView.image = image
                }
            }
        }
    }
}
