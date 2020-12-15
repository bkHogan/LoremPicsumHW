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
    @IBOutlet weak var loremNameLabel: UILabel?
    
    var loremArray: [Lorem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.LoremTableView.register(UINib(nibName: "LoremTableViewCell", bundle: nil), forCellReuseIdentifier: "LoremTableViewCell")
        self.LoremTableView.dataSource = self
        self.LoremTableView.prefetchDataSource = self
        
//        self.LoremTableView.register(UINib(nibName: "loremTableViewCell", bundle: nil), forCellReuseIdentifier: "loremTableViewCell")
//            self.LoremTableView.dataSource = self
//            self.LoremTableView.prefetchDataSource = self
        // self.getSingularLorem()
        self.getTenLorem()
    }
            
    private func getTenLorem() {
       
        let group = DispatchGroup()
        for index in 1...30{
            group.enter()
            NetworkingManager.shared.getDecodedObject(from: self.createRandomLoremURL() + "\(index)") { (lorem:Lorem?, error) in
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
                guard let lorem = lorem else {
                    if let error = error {
                    let alert = self.generateAlert(from: error)
                    DispatchQueue.main.async {
                      self.present(alert, animated: true, completion: nil)
                    }
                  }
                  return
                }
                DispatchQueue.main.async {
                    self.loremNameLabel?.text = lorem.name
                }
//                DispatchQueue.main.async {
//                        self.loremNameLabel?.text = lorem.name
//                      }
                      NetworkingManager.shared.getImageData(from: lorem.frontImageURL) { data, error in
                        guard let data = data else { return }
                        DispatchQueue.main.async {
                          self.loremImageView?.image = UIImage(data: data)
                        }
                      }
          
        }

}
    private func createRandomLoremURL() -> String {
        // let randomNumber = Int.)
        let url = "https://pokeapi.co/api/v2/pokemon/"
        return url
    }



private func generateAlert(from error: Error) -> UIAlertController {
  let alert = UIAlertController(title: "Error", message: "An Error Has Occured! Error Description: \(error.localizedDescription)", preferredStyle: .alert)
  let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
  alert.addAction(okAction)
  return alert
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

extension ViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    let lastIndex = IndexPath(row: self.loremArray.count - 1, section: 0)
    guard indexPaths.contains(lastIndex) else { return }
    self.getTenLorem()
  }
}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editVC = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        
        // editVC.editText = textToEdit as? String
        editVC.delegate = self
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}
