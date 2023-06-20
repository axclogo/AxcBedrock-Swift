//
//  AxcBaseFilterType.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/13.
//

import UIKit

// MARK: - 滤镜组对象
public class AxcBaseStyleFilter {
    // 内部转移图片对象
    public var image: UIImage?
    public init(image: UIImage? ) { self.image = image }
    
    
    // MARK: 默认参数
    public var _default3x3Vector: CIVector {
        return CIVector(values: [0.0, 0.0, 0.0,
                                 0.0, 1.0, 0.0,
                                 0.0, 0.0, 0.0], count: 9)
    }
    
    public var _defaultColor_0: CIColor {
        return CIColor(cgColor: UIColor.clear.cgColor )
    }
    
    public var _defaultColor_1: CIColor {
        return CIColor(cgColor: UIColor.gray.cgColor )
    }
    
    public var _imageVector: CIVector {
        guard let img = image else { return CIVector(cgRect: CGRect.zero) }
        return CIVector(values: [0.0, 0.0, img.axc_width, img.axc_height], count: 4)
    }
    
    public var _imageRect: CGRect {
        guard let img = image else { return CGRect.zero }
        return CGRect((0.0, 0.0, img.axc_width, img.axc_height))
    }
    
    public var _imageCenter: CGPoint {
        guard let img = image else { return CGPoint.zero }
        return img.axc_center
    }
    
    public var _imageWidth: CGFloat {
        guard let img = image else { return 0 }
        return img.size.axc_smaller / 4
    }
    
    public var _defaultTransform: CGAffineTransform{
        return CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: 1.0, tx: 0.0, ty: 0.0)
    }
    
    public var _defaultScaleTransform: CGAffineTransform{
        return CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    private var _frameSize: CGFloat {
        guard let img = image else { return 1 }
        return img.size.axc_smaller / 4
    }
    
    public var _defaultTopLeft: CIVector{
        return CIVector(values: [_frameSize * 1.5 , _imageRect.height - _frameSize * 1.5], count: 2)
    }
    
    public var _defaultTopRight: CIVector{
        return CIVector(values: [_imageRect.width - _frameSize * 1.5, _imageRect.height - _frameSize * 1.5], count: 2)
    }
    
    public var _defaultBottomLeft: CIVector{
        return CIVector(values: [_frameSize, _frameSize], count: 2)
    }
    
    public var _defaultBottomRight: CIVector{
        return CIVector(values: [_imageRect.width - _frameSize, _frameSize], count: 2)
    }
    
    public var _defaultStr: String{
        return "<null>"
    }
    
    public var _defaultData: Data{
        guard let data = _defaultStr.axc_data else { return Data() }
        return data
    }
}
