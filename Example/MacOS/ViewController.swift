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
                
        view.addSubview(label)
        label.frame = CGRect(x: 20, y: 100, width: 300, height: 300)
        
        
        let attText = "这是一段富文本".axc.makeAttributed { make in
            make.set(font: 15, range: 0...1)
                .set(foregroundColor: "FFBBAA", range: NSRange(location: 0, length: 4))
        }

        label.attributedStringValue = attText
        
    }
    
    lazy var label: NSTextField = {
        let label = NSTextField.Axc.CreateLabel()
        label.textColor = .black
        return label
    }()
//        view.layer?.backgroundColor = NSColor.red.cgColor
//        view.layer?.addSublayer(shapeLayer)
//        shapeLayer.frame = view.bounds
        
//        view.layer = shapeLayer
//
//        view.frame = .zero
//
//        let center = 200.yp.cgPoint
//        let radius: CGFloat = 100
//
//
//
//        var linesHeight: [YPUnifiedNumber] = []
//        for i in 0...1000 {
//            if (arc4random() % 2) == 0 {
//                linesHeight.append(80)
//            }else{
//                linesHeight.append(-80)
//            }
//        }
//        let bz = NSBezierPath.YP.CreateRadiateCircle(center: center,
//                                                     radius: radius,
//                                                     linesHeight: linesHeight,
//                                                     clockwise: .clockwise,
//                                                     startAngle: .direction(.left),
//                                                     openingAngle: 0,
//                                                     isReversing: false)
//        shapeLayer.path = bz.yp.cgPath
//
//    }
//
//    lazy var shapeLayer: CAShapeLayer = {
//        let layer = CAShapeLayer()
//        layer.lineWidth = 1
//        layer.strokeColor = NSColor.systemBlue.cgColor
//        layer.fillColor = NSColor.clear.cgColor
//        return layer
//    }()
//
//
//    @IBAction func clickAction(_ sender: Any) {
//        let animation = CABasicAnimation.YP.CreateAnimation { make in
//            make.set(key: .strokeEnd)
//            make.set(fromValue: 0)
//                .set(toValue: 1)
//                .set(duration: 3)
//        }
//        shapeLayer.add(animation, forKey: "")
//    }
    
        
    
    
}

