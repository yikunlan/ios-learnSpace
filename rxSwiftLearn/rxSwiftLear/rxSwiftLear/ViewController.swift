//
//  ViewController.swift
//  rxSwiftLear
//
//  Created by Yk Huang on 2021/5/27.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func jump2Login(_ sender: Any) {
        present(LoginVC(), animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

