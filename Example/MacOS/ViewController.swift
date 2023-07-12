//
//  ViewController.swift
//  macOS
//
//  Created by 赵新 on 2023/2/22.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Cocoa
import AxcBedrock

class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
                
//        view.layer?.backgroundColor = NSColor.red.cgColor
//        view.layer?.addSublayer(shapeLayer)
//        shapeLayer.frame = view.bounds
        
        view.layer = shapeLayer

        view.frame = .zero

        let center = 200.axc.cgPoint
        let radius: CGFloat = 100



        var linesHeight: [AxcUnifiedNumber] = []
        for i in 0...1000 {
            if (arc4random() % 2) == 0 {
                linesHeight.append(80)
            }else{
                linesHeight.append(-80)
            }
        }
        let bz = NSBezierPath.Axc.CreateRadiateCircle(center: center,
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
        layer.strokeColor = NSColor.systemBlue.cgColor
        layer.fillColor = NSColor.clear.cgColor
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

