//
//  CreateBlockVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/12.
//

import UIKit

class CreateBlockVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let orFuncStr = """
            /*
            @available(iOS 6.0, *)
            optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize

            @available(iOS 6.0, *)
            optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets

            @available(iOS 6.0, *)
            optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat

            @available(iOS 6.0, *)
            optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat

            @available(iOS 6.0, *)
            optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize

            @available(iOS 6.0, *)
            optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
            """
        // 当前类
        let classCode = "CAAnimation"
        // 最低支持版本
        let lowVersion = 10.0
        
        
        // 解释成需要的数据格式
        var roughFuncs = orFuncStr.axc_split(separator: "\n").axc_removeEmpty() // 回车分割
        roughFuncs = roughFuncs.filter { (str) -> Bool in // 过滤
            return str.hasPrefix("@available") || str.hasPrefix("optional") || str.hasPrefix("func")
        }
        var newFuncs = [[String:Any]]()
        for (idx,value) in roughFuncs.enumerated() {
            var funcInformation = [String:Any]()
            if value.hasPrefix("optional") || value.hasPrefix("func") {
                // 尝试获取上一个版本标注
                if let available = roughFuncs.axc_objAtIdx(idx-1),
                   available.hasPrefix("@available") { // 版本标注
                    let version = available.axc_split(start: " ", end: ",")?.first?.axc_double ?? 0.0
                    if version >= lowVersion {
                        funcInformation["available"] = available
                    }
                }
                
                // 隔离注释
                let zhushis = value.axc_split(separator: "//")
                if var fun = zhushis.first{
                    fun = fun.axc_removeSuffix(" ")
                    funcInformation += axc_funcParsing(fun)
                }
                if let zhushi = zhushis.last { // 保存注释
                    funcInformation["annotation"] = "/// \(zhushi)"
                }
            }
            if funcInformation.keys.count != 0 {
                newFuncs.append(funcInformation)
            }
        }
        // 统计所有参数
        var allParamType = [String]()
        var pppDic = [String:String]()
        newFuncs.forEach { (dic) in
            if let params = dic["params"] as? [String] {
                var pString = ""
                params.forEach { (typeStr) in
                    pString.append(typeStr + "|")
                }
                if pString.hasSuffix("|") {
                    pString.removeLast()
                }
                pppDic[pString] = pString
            }
        }
        pppDic.forEach { key,_ in
            allParamType.append(key)
        }
        
        // 创建声明Block
        var _blockCodeStr = ""
        allParamType.forEach { (type) in
            let onceBlockNameStr = creatBlockName(type)
            var onceBlockParmStr = ""
            let types = type.axc_split(separator: "|")
            types.forEach { (onceType) in
                onceBlockParmStr.append(onceType + ",")
            }
            if onceBlockParmStr.hasSuffix(",") {
                onceBlockParmStr.removeLast()
            }
            _blockCodeStr.append("/// 返回\(onceBlockParmStr)的Block声明\n")
            _blockCodeStr.append("typealias \(onceBlockNameStr)<T> = (\(onceBlockParmStr)) -> T\n")
        }
        
        func creatBlockName(_ type: String) -> String {
            var onceBlockNameStr = "Axc"
            let types = type.axc_split(separator: "|")
            types.forEach { (onceType) in
                let newType = onceType.axc_removeSuffix("?")
                onceBlockNameStr.append(newType)
            }
            onceBlockNameStr.append("Block")
            onceBlockNameStr = onceBlockNameStr - classCode
            onceBlockNameStr = onceBlockNameStr - "."
            onceBlockNameStr = onceBlockNameStr - "<"
            onceBlockNameStr = onceBlockNameStr - ">"
            onceBlockNameStr = onceBlockNameStr - "["
            onceBlockNameStr = onceBlockNameStr.axc_replacing("]", with: "s")
            onceBlockNameStr = onceBlockNameStr - ":"
            onceBlockNameStr = onceBlockNameStr - "!"
            onceBlockNameStr = onceBlockNameStr - "UI"
            onceBlockNameStr = onceBlockNameStr - "NS"
            onceBlockNameStr = onceBlockNameStr - "CG"
            onceBlockNameStr = onceBlockNameStr - "CA"
            onceBlockNameStr = onceBlockNameStr - "CI"
            onceBlockNameStr = onceBlockNameStr - "WK"
            onceBlockNameStr = onceBlockNameStr - "Unsafe"
            onceBlockNameStr = onceBlockNameStr - "Mutable"
            onceBlockNameStr = onceBlockNameStr - "@escaping"
            return onceBlockNameStr
        }
        print(_blockCodeStr)
        
        // 创建Block实现代码
        var _blockImplementationCodeStr = ""
        newFuncs.forEach { funcDic in
            if let params = funcDic["params"] as? [String] {
                var pString = ""
                params.forEach { (typeStr) in
                    pString.append(typeStr + "|")
                }
                if pString.hasSuffix("|") {
                    pString.removeLast()
                }
                let onceBlockNameStr = creatBlockName(pString)
                
                let blockName = funcDic["blockName"]!
                
                let returnType = funcDic["return"]! as! String
                
                let blockType = "\(classCode).\(onceBlockNameStr)<\(returnType)>"
                
                if let zhushi = funcDic["annotation"] as? String{
                    _blockImplementationCodeStr.append(zhushi)
                }
                _blockImplementationCodeStr.append("\n")
                
                
                let blockFuncName = funcDic["blockFuncName"]!
                
                var availableCode = ""
                if let available = funcDic["available"] as? String {
                    availableCode = available + "\n"
                }
                
                _blockImplementationCodeStr.append("""
            \(availableCode)@discardableResult
            open func \(blockFuncName)(_ block: @escaping \(blockType)) -> Self {
            \(blockName) = block
            return self
            }

            """)
                let paramNames: String = funcDic["paramNames"]! as! String
                
                var bloImPar = ""
                paramNames.axc_split(separator: ",").forEach{_ in
                    bloImPar.append("_,")
                }
                bloImPar = bloImPar.axc_removeSuffix(",")
                
                var returnValue = "return "
                if returnType |= "?" {
                    returnValue.append("nil")
                }else{
                    switch returnType {
                    case "Int":     returnValue.append("0")
                    case "Bool":    returnValue.append("false")
                    case "String":     returnValue.append("\"\"")
                    case "CGFloat":     returnValue.append("0")
                    case "IndexPath":     returnValue.append("0.axc_row")
                    case "Void":     returnValue = ""
                    default:        returnValue.append("\(returnType)()")
                    }
                }
                
                _blockImplementationCodeStr.append("\(availableCode)open lazy var \(blockName): \(blockType) \n = { \(bloImPar) in \(returnValue) }\n")
                
                let funcName = funcDic["func"]!
                let paramStr = funcDic["paramStr"]!
                
                
                _blockImplementationCodeStr.append("""
            \(availableCode)public func \(funcName)(\(paramStr)) -> \(returnType) {
            return \(blockName)(\(paramNames))
            }



            """)
            }
        }
        print(_blockImplementationCodeStr)
        
        
        
        
        print(_blockCodeStr)
        print(newFuncs.axc_parsingJsonStr)
        
    }
    /// 方法解析
    func axc_funcParsing(_ str: String) -> [String:Any] {
        var funcInformation = [String:Any]()
        // 获取方法的返回值
        if !str.hasSuffix(")"), // 不以括号结尾，则有返回值
           let ret = str.axc_split(separator: "->").last {
            let newret = ret.axc_replacing(" ")
            funcInformation["return"] = newret
        }else{ // 无返回
            funcInformation["return"] = "Void"
        }
        
        
        
        // 解析方法所有参数
        var subFuncName = ""
        if let paramStr = str.axc_split(start: "(", end: ")")?.first,
           paramStr.count > 0 { // 带参数
            var paramNames = ""
            var newParams = [String]()
            let params = paramStr.axc_split(separator: ",") // 解析所有参数
            params.forEach { (str) in
                let pp = str.axc_split(separator: ":") // 参数名和类型
                if let type = pp.last,
                   let name = pp.first{
                    let newType = type.axc_replacing(" ")
                    newParams.append(newType)
                    
                    let subNames = name.axc_split(separator: " ")
                    let namestr = subNames.last
                    paramNames.append(namestr ?? "")
                    paramNames.append(",")
                    
                    let sfn = (subNames.first ?? "") - "_"
                    subFuncName.append(sfn.axc_firstUppercased)
                }
            }
            if paramNames.hasSuffix(",") {
                paramNames.removeLast()
            }
            
            funcInformation["paramStr"] = paramStr
            funcInformation["params"] = newParams
            funcInformation["paramNames"] = paramNames
        }else{ // 无参数
            
        }
        
        // 解析方法名
        let arrrrr = str.axc_split(start: "func ", end: "(")
        if let funcNameStr = arrrrr?.first,
           funcNameStr.count > 0 {
            let newBlockName = funcNameStr + subFuncName
            
            funcInformation["func"] = funcNameStr
            
            let newFunc = "axc_set" + newBlockName.axc_firstUppercased + "Block"
            funcInformation["blockFuncName"] = newFunc
            
            let blockName = "axc_" + newBlockName + "Block"
            funcInformation["blockName"] = blockName
        }
        
        return funcInformation
    }
    
}
