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
        
        view.backgroundColor = .groupTableViewBackground
        
        view.layer.addSublayer(shapeLayer)
        shapeLayer.frame = view.bounds
        shapeLayer.frame.origin.y = 50

        let center = 200.axc.cgPoint
        let radius: CGFloat = 100

        let a = 3.axc.edge
        
//        "".axc.data
//        "".axc.data(using: .utf8)
//        "".axc.jsonData

        var linesHeight: [AxcUnifiedNumber] = []
        for _ in 0...1000 {
            if (arc4random() % 2) == 0 {
                linesHeight.append(80)
            }else{
                linesHeight.append(-80)
            }
        }
        let bz = UIBezierPath.Axc.CreateRadiateCircle(center: center,
                                                     radius: radius,
                                                     linesHeight: linesHeight,
                                                     clockwise: .clockwise,
                                                     startAngle: .direction(.left),
                                                     openingAngle: 0,
                                                     isReversing: false)
        shapeLayer.path = bz.axc.cgPath

    }

    lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 1
        layer.strokeColor = UIColor.systemBlue.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()


    @IBAction func clickAction(_ sender: Any) {
        let animation = CABasicAnimation.Axc.CreateAnimation { make in
            make.set(key: .strokeEnd)
            make.set(fromValue: 0)
                .set(toValue: 1)
                .set(duration: 3)
        }
        shapeLayer.add(animation, forKey: "")
    }
    
}
