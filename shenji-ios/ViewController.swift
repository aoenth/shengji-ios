//
//  ViewController.swift
//  shenji-ios
//
//  Created by Kevin Peng on 2020-08-02.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let testView = UIView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        testView.backgroundColor = .blue
        view.addSubview(testView)
    }
}
