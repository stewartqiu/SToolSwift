//
//  ViewController.swift
//  SToolSwift
//
//  Created by stewartqiu on 01/31/2018.
//  Copyright (c) 2018 stewartqiu. All rights reserved.
//

import UIKit
import SToolSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        testStool()
    }
    
    func testStool () {
        print(STool.getNow(format: "dd-MM-yyyy HH:mm:ss"))
        print(STool.randomString(length: 28))
        print(UIDevice().modelName)
    }
    
}

