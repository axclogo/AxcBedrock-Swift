//
//  ScrollTestVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/25.
//

import UIKit

class ScrollTestVC: AxcBaseVC {

    var vcs: [AxcPageItemVC] = [ScrollChildTestVC(), ScrollChildTestVC(), ScrollChildTestVC()]

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(pageScrollController)
        view.addSubview(pageScrollController.view)
        pageScrollController.view.axc.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        pageScrollController.axc_setHeader(headerView, height: 200)
        pageScrollController.axc_setSegmentedControlTitle([("1",nil),("2",nil),("3",nil)], height: 40)
        pageScrollController.axc_setPages(vcs)
    }
    
    
    // MARK: - 懒加载
    lazy var titleView: AxcBaseView = {
        let view = AxcBaseView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    lazy var headerView: AxcBaseView = {
        let view = AxcBaseView()
        view.axc_setGradient()
        return view
    }()
    lazy var pageScrollController: AxcPageScrollController = {
        let pageScrollController = AxcPageScrollController()
        return pageScrollController
    }()
}



