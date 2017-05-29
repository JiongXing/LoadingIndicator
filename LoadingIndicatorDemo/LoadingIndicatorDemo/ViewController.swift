//
//  ViewController.swift
//  LoadingIndicatorDemo
//
//  Created by JiongXing on 2017/5/29.
//  Copyright © 2017年 JiongXing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showLoading(_ sender: UIButton) {
        LoadingIndicator.share.show(inView: view)
    }

}

