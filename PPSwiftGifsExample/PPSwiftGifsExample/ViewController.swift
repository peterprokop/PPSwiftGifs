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
        
        imageView1.image = PPSwiftGifs.animatedImageWithGIF(named: "Loading")
        imageView2.image = PPSwiftGifs.animatedImageWithGIF(named: "VariableDuration")
        
        if let url = Bundle.main.url(forResource: "Loading", withExtension: "gif") {
            if let data = try? Data(contentsOf: url) {
                imageView3.image = PPSwiftGifs.animatedImageWithGIF(data: data)
            }
        }
    }

}
