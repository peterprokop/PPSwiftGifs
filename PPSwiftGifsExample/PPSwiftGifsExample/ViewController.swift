//
//  ViewController.swift
//  PPSwiftGifsExample
//
//  Created by Peter Prokop on 08/11/14.
//  Copyright (c) 2014 Peter Prokop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView1.image = PPSwiftGifs.animatedImageWithGIFNamed("Loading")
        imageView2.image = PPSwiftGifs.animatedImageWithGIFNamed("VariableDuration")
        
        if let url = NSBundle.mainBundle().URLForResource("Loading", withExtension: "gif") {
            if let data = NSData(contentsOfURL: url) {
                imageView3.image = PPSwiftGifs.animatedImageWithGIFData(data)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

