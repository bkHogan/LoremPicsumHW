//
//  DetailViewController.swift
//  LoremPicsumHW
//
//  Created by Field Employee on 12/15/20.
////
import UIKit
//import Foundation


protocol DetailViewControllerDelegate {
    func update()
}

class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Could not figure out how to connect the image and label from my details page to here
    
}
extension DetailViewController: UITableViewDelegate{
    
}
