//
//  ViewController.swift
//  iOS
//
//  Created by 赵新 on 2023/2/22.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import WebKit
import AxcBedrock
import LocalAuthentication

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        testView.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            testView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        testView.backgroundColor = .red
        view.addSubview(testView)

        view.addSubview(imageView)
    }

    let testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    let imageView = UIImageView(frame: CGRect(x: 100, y: 220, width: 200, height: 200))

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        let image = testView.axc.screenshotUsingMetal()
        imageView.image = image
    }
}
