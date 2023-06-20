//
//  ProjectVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

@objc class ProjectVC: AxcBaseVC {
    
    let cameraView = AxcCameraView()
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var str_M = ""
        "asd找as萨达dasdasd啊是颠倒是非".forEach{
            let strC = $0.axc_string
            if strC.axc_isChinese {
                str_M.append(strC)
            }
        }
        print(str_M)
        
//        let sss = "19981023zjf".axc_rijndaelEncryptStr(.DES3, key: "123456789012345678901234")
        
        let ssss = 123456789[3]
        
        print( ssss )
        
        //        cameraView.backgroundColor = .lightGray
//        axc_addSubView(cameraView)
//        cameraView.axc.makeConstraints { (make) in
//            make.top.left.equalTo(10)
//            make.right.equalTo(-10)
//            make.height.equalTo(200)
//        }
//        cameraView.axc_start()
//
//        imageView.backgroundColor = .lightGray
//        axc_addSubView(imageView)
//        imageView.axc.makeConstraints { (make) in
//            make.top.equalTo(cameraView.axc.bottom).offset(-10)
//            make.left.equalTo(10)
//            make.right.equalTo(-10)
//            make.height.equalTo(200)
//        }
//        vieww.frame = .init((10,50,345,44))
//        vieww.layer.borderWidth = 0.5
//        vieww.axc_borderColor = .purple
//        vieww.layer.cornerRadius = 5
//        vieww.font = 14.axc_font
//        vieww.attributedPlaceholder = "如：木工、钢筋工、水泥工".axc_attributedStr.axc_setTextColor("#999999".axc_color)
//        vieww.axc_setMaxLength(3) { (text) in
            
//        viewwwww.backgroundColor = .white
//        viewwwww.axc_scrollDirection = .vertical
//        viewwwww.axc_textBannerNumberBlock = { _ in
//            return 5
//        }
//        viewwwww.axc_textBannerTextBlock = {_,_ in
//            return "asdasdasdasd"
//        }
//        viewwwww.axc_start()
//
//        axc_addSubView(viewwwww)
        axc_addSubView(btn)
        btn.axc.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(200)
        }
        
        
//        let btn = AxcButton()
//                btn.setImage(themeBackArrowImage, for: .normal)
        
//        let btn = AxcButton(title: title, image: themeBackArrowImage)
//        btn.axc_contentInset = UIEdgeInsets.zero
//        btn.axc_style = .img
//
//        let customView = AxcBaseView(CGRect(x: 0, y: 0, width: 30, height: 30))
//        customView.backgroundColor = UIColor.lightGray
//        btn.axc_size = customView.axc_size
//        btn.axc_origin = 0.axc_cgPoint
//        customView.addSubview(btn)
//        //        btn.frame = customView.bounds
//
//        let item = UIBarButtonItem(customView: customView)
//        item.width = customView.axc_width
//        self.navigationItem.setLeftBarButtonItems([item], animated: true)
//        customView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

//        axc_addNavBarItem(image: themeBackArrowImage, size: 30.axc_cgSize) { (_) in
//            print("123123123")
//        }
        
    }
    let btn = UIButton(title: "123", image: UIImage.axc_appIcon)

    private var themeBackArrowImage: UIImage {
        guard let _themeBackArrowImage = backArrowImage.axc_setTintColor(AxcBadrock.shared.backImageColor) else { return backArrowImage }
        return _themeBackArrowImage
    }
    
    private var backArrowImage: UIImage = AxcBadrockBundle.arrowLeftImage

let viewwwww = AxcTextBannerView()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewwwww.axc_stop()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        axc_pushViewController(ProjectVC())
        
        btn.axc_style = .imgLeft_textRight
    }
    
}
