//
//  FilterDirVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

class FilterDirVC: UIViewController {

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        createUI()
    }
    
    func createUI() {
        tableView.frame = view.frame
        view.addSubview(tableView)
    }
    
    // MARK: 懒加载
    lazy var dataListArray: [String] = {
        return ["Blur","Sharpen","Stylize","Gradient","Reduction","Generator","TileEffect"]
    }()
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
}

extension FilterDirVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FilterDetailsVC()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataListArray[indexPath.row]
        return cell
    }
}
