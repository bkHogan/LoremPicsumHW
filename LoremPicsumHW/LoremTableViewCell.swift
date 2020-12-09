//
//  LoremTableViewCell.swift
//  LoremPicsumHW
//
//  Created by Field Employee on 12/9/20.
//

import UIKit

class LoremTableViewCell: UITableViewCell {

    @IBOutlet weak var loremImageView: UIImageView!
    
    @IBOutlet weak var loremIDLabel: UILabel!
    
    func configure(with lorem: Lorem) {
        self.loremIDLabel.text = "ID: " + lorem.id
        NetworkingManager.shared.getImageData(from: lorem.loremImageURL) {(data, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.loremImageView.image = UIImage(data: data)
            }
        }
    }
}
