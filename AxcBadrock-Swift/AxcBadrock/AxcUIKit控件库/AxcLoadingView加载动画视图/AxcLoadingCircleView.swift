//
//  AxcLoadingCircleView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/22.
//

import UIKit

open class AxcLoadingCircleView: AxcBaseLoadingView {
    // MARK: - 父类重写
    open override func makeUI() {
        layer.addSublayer(animationLayer)
    }
    /// 开始布局
    open override func layoutSubviews() {
        super.layoutSubviews()
        animationLayer.frame = bounds
        gradientLayer_1.frame = CGRect(0,0,
                                       animationLayer.axc_width/2,animationLayer.axc_height)
        gradientLayer_0.frame = CGRect(animationLayer.axc_width/2,0,
                                       animationLayer.axc_width/2,animationLayer.axc_height)
        let arcCenter = CGPoint(axc_width/2,axc_height/2)
        let width = 3.axc_cgFloat
        let radius = axc_size.axc_smaller/2 - width/2
        let bezierPath = UIBezierPath(arcCenter: arcCenter, radius: radius,
                                      startAngle: 0, endAngle: 360.axc_angleToRadian, clockwise: true)
        bezierPath.lineWidth = width
        makeLayer.axc_path = bezierPath
        layer.mask = makeLayer
    }
    open override func axc_start() {
        let animation = AxcAnimationManager.axc_sustainRotating( axle: .upright, 2)
        animationLayer.axc_addAnimation(animation)
    }
    open override func axc_stop() {
        animationLayer.removeAllAnimations()
    }

    // MARK: - 懒加载
    lazy var makeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.white.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeStart = 0
        layer.strokeEnd = 1
        layer.lineCap = .round
        layer.lineDashPhase = 0.8
        return layer
    }()
    lazy var animationLayer: CALayer = {
        let layer = CALayer()
        return layer
    }()
    lazy var gradientLayer_0: CAGradientLayer = {
        let layer = CAGradientLayer(colors: [.clear,.lightGray],
                                    locations: [0.1],
                                    startDirection: .top,
                                    endDirection: .bottom)
        animationLayer.addSublayer(layer)
        return layer
    }()
    lazy var gradientLayer_1: CAGradientLayer = {
        let layer = CAGradientLayer(colors: [.black,.lightGray],
                                    locations: [0.3],
                                    startDirection: .top,
                                    endDirection: .bottom)
        animationLayer.addSublayer(layer)
        return layer
    }()
}
