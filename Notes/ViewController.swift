//
//  ViewController.swift
//  Notes
//
//  Created by Paul Vasilenko on 7/4/19.
//  Copyright © 2019 Paul Vasilenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure()
    }
    
    func configure() {
        title = "Notes"
        
        guard let suffix = Config.suffix, let color = Config.barTintColor else {
            return
        }
        title?.append(suffix)
        navigationController?.navigationBar.barTintColor = color
    }


}

