//
//  LoremTableViewCell.swift
//  LoremPicsumHW
//
//  Created by Field Employee on 12/9/20.
//

import UIKit

class LoremTableViewCell: UITableViewCell {

    @IBOutlet weak var frontImageView: UIImageView!
//    @IBOutlet weak var loremImageView: UIImageView!
    
    @IBOutlet weak var loremNameLabel: UILabel!
//    @IBOutlet weak var loremNameLabel: UILabel!
    @IBOutlet weak var speciesNameLabel: UILabel!
    
    func configure(with lorem: Lorem) {
        self.loremNameLabel.text = lorem.name
        // self.speciesNameLabel.text = lorem.types
        NetworkingManager.shared.getImageData(from: lorem.frontImageURL) {(data, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.frontImageView.image = UIImage(data: data)
            }
        }
    }
}
