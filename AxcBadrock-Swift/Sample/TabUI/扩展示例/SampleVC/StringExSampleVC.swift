//
//  StringExSampleVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/20.
//

import UIKit
import RxSwift
import RxCocoa
import Photos

import CommonCrypto

class StringExSampleVC: AxcBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let keyiv = "123456789012345678901234"
        
        let eee = "19981023zjf".axc_3desEncryptHexStr(.cbc(keyiv, iv: "12345678"))
        
        let ddd = eee?.axc_3desDecryptHexStr(.cbc(keyiv, iv: "12345678"))
        
        print(eee)
        
        let cg = 0x123456.axc_cgColor
        
        view.backgroundColor = cg.axc_color
        
        
//        axc_navBar
        
        
//        let group = DispatchGroup()
//        let queue = DispatchQueue.init(label: "123")
        
//        queue.async(group: group, qos: .default, flags: []) {
//            for _ in 0 ..< 100000{
//
//            }
//            print("任务1完成")
//        }
//        queue.async(group: group, qos: .default, flags: []) {
//            for _ in 0 ..< 200000{
//
//            }
//            print("任务2完成")
//        }
//        queue.async(group: group, qos: .default, flags: []) {
//            print("任务3完成")
//        }
//
//        group.notify(queue: queue) {
//            print("最终任务")
//        }
        
        
        
//        group.enter()//把该任务添加到组队列中执行
//        queue.async(group: group, qos: .default, flags: [], execute: {
//
//            print("耗时任务3")
//            group.leave()//执行完之后从组队列中移除
//        })
//        group.enter()//把该任务添加到组队列中执行
//        queue.async(group: group, qos: .default, flags: [], execute: {
//            for _ in 0...3 {
//
//                print("耗时任务一")
//            }
//            group.leave()//执行完之后从组队列中移除
//        })
//        group.enter()//把该任务添加到组队列中执行
//        queue.async(group: group, qos: .default, flags: [], execute: {
//            for _ in 0...5 {
//
//                print("耗时任务二")
//            }
//            group.leave()//执行完之后从组队列中移除
//        })
//
//        //当上面所有的任务执行完之后通知
//        group.notify(queue: .main) {
//            print("所有的任务执行完了")
//        }
       
        
        
//        let say = "You are a good man !"
//        let operation = BlockOperation()
//        for word in say.split(separator: " ") {
//          operation.addExecutionBlock {
//            print(word)
//          }
//        }
//        operation.
        
        
        
//        let ggg = DispatchQueue.global()
//        ggg.async {
//            let sema = DispatchSemaphore.init(value: 0)
//            for i in 0..<1000 {
//                AxcGCD.async {
//                    sleep(arc4random()%10)
//                    print("\(i)")
//                    sema.signal()
//                }
//            }
//            for _ in 0..<1000 {
//                sema.wait()
//            }
//            //刷新 UI 等操作可以放在这里（注：如果是对 UI 操作要放在主线程哦）
//            print("任务完成")
//        }
        
//        let qqq = OperationQueue()
//        qqq.maxConcurrentOperationCount = 100;
//
//
//        for idx in 0 ..< qqq.maxConcurrentOperationCount {
//            qqq.addOperation {
//                sleep(arc4random()%10)
//                print("\(idx)")
//            }
//        }

//        let queue1 = DispatchQueue(label: "asdasd")
//        group.enter()
//        queue1.async(group: group, qos: .default, flags: []) {
//            sleep(3)
//            group.leave()
//            print("任务1完成")
//        }
//
//        let queue2 = DispatchQueue(label: "123")
//        group.enter()
//        queue1.async(group: group, qos: .default, flags: []) {
//            sleep(1)
//            group.leave()
//            print("任务2完成")
//        }
//
//        let queue3 = DispatchQueue(label: "zxc")
//        group.enter()
//        queue1.async(group: group, qos: .default, flags: []) {
//            sleep(2)
//            group.leave()
//            print("任务3完成")
//        }
//
//        group.notify(queue: .main) {
//            print("任务完成")
//        }
//        let group = DispatchGroup()
//        let queue = DispatchQueue(label: "queue", attributes: DispatchQueue.Attributes.concurrent)
//        print("------ 开始 -------")
//        for i in 0 ..< 100 {
//            group.enter()
//            queue.async(group: group, qos: .default, flags: []) {
//                Thread.sleep(forTimeInterval: TimeInterval(arc4random()%10))
//                print("------ async \(i) -------")
//                group.leave()
//            }
//        }
//        group.notify(queue: .main) {
//            print("任务完成")
//        }
        
//        queue.async {
//            Thread.sleep(forTimeInterval: 5)
//            print("------ async 2 -------")
//        }
//        queue.async {
//            Thread.sleep(forTimeInterval: 4)
//            print("------ async 3 -------")
//        }
//        queue.async {
//            Thread.sleep(forTimeInterval: 1)
//            print("------ async 4 -------")
//        }
        
        label.frame = 100.axc_cgRect
//        label.text = "123"
//        label.axc_observerCycle = axc_observerCycle
        axc_addSubView(label)
        
        label.numberOfLines = 0
        
//        let attributedText = NSMutableAttributedString()
//        attributedText.append("请允许我们发送推送通知\n"
//                                .axc_attributedStr(color: "#333333".axc_color,
//                                                   font: 15.axc_font.axc_setWeight(.bold)))
//        attributedText.append("开启招工订阅，第一时间接收工作机会"
//                                .axc_attributedStr(color: "#666666".axc_color,
//                                                   font: 14.axc_font))
        
//        let ps = NSParagraphStyle.axc_mutable
//                ps.alignment = .center
        //        ps.lineSpacing = 6
//        ps.axc_setAlignment(.center)
//        ps.axc_setLineSpacing(6)
//        attributedText.axc_setParagraphStyle(ps)
        
        
//        attributedText.axc_setParagraphStyle(ps, range: NSRange(location: 0, length: attributedText.string.count))
        
//        label.attributedText = attributedText
        
        
//        textView.text = "123"
//        textView.frame = 100.axc_cgRect
//        view.addSubview(textView)
//        textView.axc_setTextChangeBlock { (textView) in
//            print(textView.text ?? "")
        //        }
        
//        let coll = UICollectionView()
        
        let btn = UIButton(title: "测试", image: "dingwei".axc_image, state: .normal)
        btn.frame = CGSize(200,50).axc_cgRect
        view.addSubview(btn)
        
        btn.axc_style = .textLeft_imgRight
        
        
        //        label.axc_setGradient(colors: [.purple,.orange],
        //                              startDirection: .left,
        //                              endDirection: .right)
        
//        label.axc_setGradient(colors: [.purple,.orange],
//                              startDirection: .left,
//                              endDirection: .right,
//                              autoAdapt: .auto(cycle: axc_observerCycle))
        
//        CGPoint(50,50).axc_show(view)
//        100.axc_cgRect.axc_show(view)
        
//        let bz = UIBezierPath(reticle: CGPoint(50,50))
//        let layer = CAShapeLayer(path: bz)
//        layer.frame = view.frame
//        view.layer.addSublayer(layer)
        
//        label.axc_observer.axc_setObserver("text") { [weak self] (_, _, _, _) in
//            guard let weakSelf = self else { return }
//            print(weakSelf.label.text)
//        }
//        label.axc_observer.axc_setObserver("frame") { [weak self] (_, _, _, _) in
//            guard let weakSelf = self else { return }
//            print(weakSelf.label.frame)
//        }
         
//        let arrStr =
//        "富文本".axc_attributedStr
//            .axc_setFont(13.axc_font.axc_setWeight(.medium))// 字体+字重
//            .axc_setTextColor( "FFFFFF".axc_color )         // 字色
//            .axc_setShadow( NSShadow()                      // 阴影
//                                .axc_offset( 1.axc_cgSize )
//                                .axc_color( .black ))
//        + // 添加另一端富文本
//            "测试AxcLogo".axc_mark("Axc", color: "FFFFFF".axc_color(0.5) ) // 标记Axc字段为黑色，透明度0.5
//
//        label.axc_makeCAAnimation { (make) in
//            // 先执行渐变动画
//            make.basicAnimation(.opacity)
//                .axc_setFromValue(1).axc_setToValue(1)
//                .axc_setDuration(0.3)
//                .axc_setStartBlock { (animation) in
//                    print("动画开始")
//                }
//                .axc_setEndBlock { (anima, flag) in
//                    print("动画结束")
//                }
//            // 在执行弹性动画
//            make.springAnimation(.bounds)
//                .axc_setFromValue(1).axc_setToValue(1)
//                .axc_setDuration(0.3)
//                .axc_setStartBlock { (animation) in
//                    print("动画开始")
//                }
//                .axc_setEndBlock { (anima, flag) in
//                    print("动画结束")
//                }
//        } complete: {
//            print("所有动画结束")
//        }
//
//        let tableView = UITableView()
//        tableView.axc_makeDelegate { (delegate) in
//            delegate.axc_setDidSelectRowBlock { (tableView, indexPath) in
//                print("点击了\(indexPath)")
//            }
//        }
//        tableView.axc_makeDataSource { (dataSource) in
//            dataSource.axc_setCellForRowBlock { (tableView, indexPath) -> UITableViewCell in
//                return UITableViewCell()
//            }
//            .axc_setNumberOfRowsInSectionBlock { (_, _) -> Int in
//                return 10
//            }
//            .axc_setNumberOfSectionsBlock { (_) -> Int in
//                return 2
//            }
//        }
//
//
//
//        label.axc_observer.axc_setKeyPath("text") { (_, obj, _, _) in
//            guard let label = obj as? UILabel else { return }
//
//            print(label.text!) // 监听
//
//        }.axc_setCycle(axc_observerCycle) // 与vc的周期绑定
//
//        label.axc_observer.axc_setKeyPath("textColor") { (_, obj, _, _) in
//            guard let label = obj as? UILabel else { return }
//
//            print(label.textColor!) // 监听
//
//        }.axc_setCycle(axc_observerCycle) // 与vc的周期绑定
//
//        label.axc_observer.axc_setKeyPath("frame") { (_, obj, _, _) in
//            guard let label = obj as? UILabel else { return }
//
//            print(label.frame) // 监听
//
//        }.axc_setCycle(axc_observerCycle) // 与vc的周期绑定
//
//        label.axc_observer.axc_setKeyPath("frame") { (_, obj, _, _) in
//            guard let label = obj as? UILabel else { return }
//
//            print(label.frame) // 监听
//
//        }.axc_setCycle(axc_observerCycle) // 与vc的周期绑定

//        label.backgroundColor = .purple
//
//        label.axc_setCornerRadius([.topLeft, .bottomRight,.bottomLeft], radius: 10, autoAdapt: .auto(cycle: axc_observerCycle))
//        label.axc_setCornerRadiusSmaller()
//        label.axc_observerCycle = axc_observerCycle
        
        
//        let edge = UIEdgeInsets("1", 10.axc_number, true, 50.axc_double)
        
//        let nss = NSString(format: "%@", "fasle")
//        let bol = nss.axc_bool
//        print(bol)
        
//        let vvv = AxcLoadingCircleView()
////        vvv.backgroundColor = .blue
//        vvv.frame = "50".axc_cgRect
//        vvv.axc_start()
//        axc_addSubView(vvv)
        
//        let vvv = AxcBaseView()
//        vvv.frame = "50".axc_cgRect
//        axc_addSubView(vvv)
        label.axc_borderColor = .blue
        label.axc_borderWidth = 0.5
        label.textAlignment = .center
        label.backgroundColor = .purple
        label.textColor = .white
        
        testView1.tag = 100
        label.addSubview(testView1)
        testView1.axc_remakeConstraintsFill()
        
        testView2.tag = 200
        label.addSubview(testView2)
        testView2.axc_remakeConstraintsFill()
        
        
        imageView.frame = CGRect(10,200,100,200)
        axc_addSubView(imageView)
        
        let btn2 = abtn()
        btn2.axc_addEvent { (_) in
//            btn2.setTitle("123", for: .normal)
        }
        axc_addSubView(btn2)
        
        class abtn: UIButton {
            deinit {
                print("")
            }
        }
    }
    
    let label = UILabel()
    let textView = UITextView()

    let testView1 = UIImageView(image: "test".axc_image)
    let testView2 = UIImageView(image: "demo".axc_image)
    let imageView = UIImageView(image: "demo".axc_image)

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let view = UIView(backgroundColor: UIColor.systemBlue)
        let alertVC = AxcAlentVC(view: view, size: 100.axc_cgSize, showDirection: [.left,.top])
        alertVC.axc_show()
    }
    
    func axc_readData(_ data: Data) -> [String:Any]? {
        let options = [kCGImageSourceShouldCache : kCFBooleanTrue]
        guard let imgSrc = CGImageSourceCreateWithData(data.axc_cfData, options.axc_cfDic)
        else { return nil }
        let source1 = CGImageSourceCopyPropertiesAtIndex(imgSrc, 0, options.axc_cfDic)
        let metadata = CFDictionaryCreateMutableCopy(nil, 0, source1).axc_nsMutableDic
        
        guard let exifdata = metadata.value(forKey: kCGImagePropertyExifDictionary.axc_string)
                as? NSMutableDictionary
        else { return nil }
        var newDic = [String:Any]()
        exifdata.enumerateKeysAndObjects { (k, value, _) in
            if let key = k as? String {
                newDic[key] = value
            }
        }
        return newDic
    }
    
    func axc_saveImgData(_ imgData: Data) -> Data? {
        let options = [kCGImageSourceShouldCache : kCFBooleanTrue]
        let cfData = imgData.axc_cfData
        guard let imgSrc = CGImageSourceCreateWithData(cfData, options.axc_cfDic)
        else { return nil }
        let source1 = CGImageSourceCopyPropertiesAtIndex(imgSrc, 0, options.axc_cfDic)
        let metadata = CFDictionaryCreateMutableCopy(nil, 0, source1).axc_nsMutableDic
        
        guard let exifdata = metadata.value(forKey: kCGImagePropertyExifDictionary.axc_string)
                as? NSMutableDictionary
        else { return nil }
        // 设置key的时候只能设置kCGImagePropertyExif-list里的，不能自定义
        exifdata.setValue("yaw:axc, pitch:123, roll:asd",
                          forKey: kCGImagePropertyExifUserComment.axc_string)
        metadata.setValue(exifdata, forKey: kCGImagePropertyExifDictionary.axc_string)
        
        
        let mData = NSMutableData()
        guard let source = CGImageSourceCreateWithData(imgData.axc_cfData, nil),
              let uti = CGImageSourceGetType(source),
              let destination = CGImageDestinationCreateWithData(mData, uti, 1, nil)
        else { return nil }
        CGImageDestinationAddImageFromSource(destination, source, 0, metadata as CFDictionary)
        let success = CGImageDestinationFinalize(destination)
        if success {
            return mData.axc_data
        }
        return nil
    }
    
    var flag = false
    
    deinit {
        print("VC销毁")
    }
    
}

class aaaLabel: UILabel {
    deinit {
        print("Label销毁了！")
    }
}
