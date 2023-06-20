//
//  AxcUnifiedImageTarget.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/5/15.
//

import UIKit

// MARK: 图片统一互转协议
public protocol AxcUnifiedImageTarget {}
extension String:   AxcUnifiedImageTarget {}
extension NSString: AxcUnifiedImageTarget {}
extension UIImage:  AxcUnifiedImageTarget {}
extension CGImage:  AxcUnifiedImageTarget {}
extension CIImage:  AxcUnifiedImageTarget {}

public extension AxcUnifiedImageTarget {
    /// 转换成图片CIImage
    var axc_ciImage: CIImage? {
        if let string   = self as? String                   { return string.axc_image.axc_ciImage }
        if let nsString = self as? NSString                 { return nsString.axc_string.axc_image.axc_ciImage }
        if let uiImage  = self as? UIImage                  { return uiImage.ciImage ?? uiImage.cgImage?.axc_ciImage }
        if let cgImage  = AxcCFType(self, as: CGImage.self) { return CIImage(cgImage: cgImage) }
        if let ciImage  = self as? CIImage                  { return ciImage }
        return UIImage().ciImage
    }
    
    /// 转换成图片CGImage
    var axc_cgImage: CGImage? {
        if let string   = self as? String                   { return string.axc_image.axc_cgImage }
        if let nsString = self as? NSString                 { return nsString.axc_string.axc_image.axc_cgImage }
        if let uiImage  = self as? UIImage                  { return uiImage.cgImage ?? uiImage.ciImage?.axc_cgImage }
        if let cgImage  = AxcCFType(self, as: CGImage.self) { return cgImage }
        if let ciImage  = self as? CIImage                  { return CIContext().createCGImage(ciImage, from: ciImage.extent) }
        return UIImage().cgImage
    }
    
    /// 转换成图片UIImage
    var axc_image: UIImage {
        var _image = UIImage()
        if let string   = self as? String   { _image = UIImage(string) ?? _image }
        if let nsString = self as? NSString { _image = UIImage(nsString.axc_string) ?? _image }
        if let uiImage  = self as? UIImage  { _image = uiImage }
        if let ciImage  = self as? CIImage  { _image = UIImage(ciImage: ciImage) }
        if let cgImage  = AxcCFType(self, as: CGImage.self) { _image = UIImage(cgImage: cgImage) }
        return _image
    }
}
