//
//  ViewController.swift
//  NKScrollView
//
//  Created by 聂康  on 2017/9/15.
//  Copyright © 2017年 com.nk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let v = NKScrollView(frame: CGRect(x: 60, y: 200, width: view.bounds.width-120, height: 150), viewMargin: 10)
        v.isLoopScroll = true
        v.images = ["0","1","2","3"]
        view.addSubview(v)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

