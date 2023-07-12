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
        
        view.backgroundColor = .white
        
        view.addSubview(label)
        label.frame = CGRect(x: 20, y: 100, width: 300, height: 30)
        
        
        let attText = "这是一段富文本".axc.makeAttributed { make in
            make.set(font: 15, range: 0...1)
                .set(foregroundColor: "FFBBAA", range: NSRange(location: 0, length: 4))
        }

        label.attributedText = attText
        
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

}


class AA: Decodable {
    
}
