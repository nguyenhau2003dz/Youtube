//
//  ViewController.swift
//  Youtube
//
//  Created by Hậu Nguyễn on 26/4/25.
//

import UIKit

class ViewController: UIViewController {
    var model = Model()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getVideos()
    }


}

