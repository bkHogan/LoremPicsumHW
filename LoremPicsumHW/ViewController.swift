//
//  ViewController.swift
//  LoremPicsumHW
//
//  Created by Field Employee on 12/8/20.
//

import UIKit

class ViewController: UIViewController {
    
    // let loremURL = "https://picsum.photos/id/0/info"

    @IBOutlet weak var LoremTableView: UITableView!
    @IBOutlet weak var loremImageView: UIImageView?
    @IBOutlet weak var loremIDLabel: UILabel?
    
    var loremArray: [Lorem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.getSingularLorem()
        self.getTenLorem()
    }
            
    private func getTenLorem() {
        self.LoremTableView.register(UINib(nibName: "LoremTableViewCell", bundle: nil), forCellReuseIdentifier: "LoremTableViewCell")
        self.LoremTableView.dataSource = self
        let group = DispatchGroup()
        for _ in 1...10{
            group.enter()
            NetworkingManager.shared.getDecodedObject(from: self.createRandomLoremURL()) { (lorem:Lorem?, error) in
                guard let lorem = lorem else { return }
                self.loremArray.append(lorem)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.LoremTableView.reloadData()
        }
    }
        
        private func getSingularLorem() {
            NetworkingManager.shared.getDecodedObject(from: self.createRandomLoremURL()) {  (lorem: Lorem?, error ) in
                guard let lorem = lorem else { return }
                DispatchQueue.main.async {
                    self.loremIDLabel?.text = lorem.id
                }
                NetworkingManager.shared.getImageData(from: lorem.loremImageURL) {data, error in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self.loremImageView?.image = UIImage(data: data)
                    }
                }
        }
//        guard let url = URL(string: self.createRandomLoremURL()) else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//            guard let lorem = try?
//                    JSONDecoder().decode(Lorem.self, from: data)
//                    else {return }
//            DispatchQueue.main.sync {
//                self.loremIDLabel.text = lorem.id
//            }
//            URLSession.shared.dataTask(with: lorem.loremImageURL) { (data, response, errror ) in
//                guard let data = data else { return }
//                let image = UIImage(data: data)
//                DispatchQueue.main.async {
//                    self.loremImageView.image = image
//                }
//        }.resume()
//    }.resume()
}
    private func createRandomLoremURL() -> String {
        let randomNumber = Int.random(in: 1...10)
        let url = "https://picsum.photos/id/\(randomNumber)/info"
        return url
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loremArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoremTableViewCell", for: indexPath) as! LoremTableViewCell
        cell.configure(with: self.loremArray[indexPath.row])
        
        return cell
    }
}
