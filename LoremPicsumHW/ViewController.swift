//
//  ViewController.swift
//  LoremPicsumHW
//
//  Created by Field Employee on 12/8/20.
//

import UIKit

class ViewController: UIViewController {
    
    // let loremURL = "https://picsum.photos/id/0/info"

    @IBOutlet weak var loremImageView: UIImageView!
    @IBOutlet weak var loremIDLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: self.createRandomLoremURL()) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard let lorem = try?
                    JSONDecoder().decode(Lorem.self, from: data)
                    else {return }
            DispatchQueue.main.sync {
                self.loremIDLabel.text = lorem.id
            }
            URLSession.shared.dataTask(with: lorem.loremImageURL) { (data, response, errror ) in
                guard let data = data else { return }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.loremImageView.image = image
                }
        }.resume()
    }.resume()
}
    private func createRandomLoremURL() -> String {
        let randomNumber = Int.random(in: 1...10)
        return "https://picsum.photos/id/\(randomNumber)/info"
    }

}
