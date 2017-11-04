//
//  ViewController.swift
//  Demo
//
//  Created by Mack Boudreau on 2017-11-04.
//  Copyright © 2017 Mack Boudreau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedController: CustomSegmentedController!

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedController.items = ["HOME", "STATS", "PROFILE"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

