//
//  AxcDeviceMap.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/9.
//

import Foundation

extension AxcDevice {
    /*  Auto Maintain Code >>>>>> **/

    // 数据地址：
    // https://github.com/pbakondy/ios-device-list/blob/master/devices.json
    // iOS生成字典代码的代码
    /*
     let filePath =
         "/Users/zhaoyang/Desktop/ios-device-list-master/devices-min.json"

     guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
           let list = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [[String: Any]],
           let list = list
     else { return }

     // 打印成字典代码
     var deviceMap: [String: Any] = [:]
     for device in list {
         if let name = device["name"] as? String,
            let model = device["model"] as? String {
             deviceMap[model] = name
         }
     }
     let keys = deviceMap.keys.sorted { k1, k2 in
         return k1 < k2
     }
     for key in keys {
         let value = deviceMap[key]!
         print("\"\(key)\" : \"\(value)\",")
     }

     ChatGPT
     用Json格式帮我列举所有mac的设备Identifier以及对应的generationName
     
     */

    /// 所有苹果设备的对应表
    static var DeviceMap: [String: String] = {
        let iosDeviceMapJson: [String: String] = [
            "AirPods1,1": "AirPods (1st generation)",
            "AirPods1,3": "AirPods (3rd generation)",
            "AirPods2,1": "AirPods (2nd generation)",
            "AirPods2,2": "AirPods Pro",
            "AirPodsMax1,1": "AirPods Max",
            "AirPodsPro1,1": "AirPods Pro",
            "AirPodsPro1,2": "AirPods Pro (2nd generation)",
            "AirTag1,1": "AirTag",
            "AppleTV1,1": "Apple TV (1st generation)",
            "AppleTV11,1": "Apple TV 4K (2nd generation)",
            "AppleTV2,1": "Apple TV (2nd generation)",
            "AppleTV3,1": "Apple TV (3rd generation)",
            "AppleTV3,2": "Apple TV (3rd generation)",
            "AppleTV5,3": "Apple TV (4th generation)",
            "AppleTV6,2": "Apple TV 4K",
            "Audio2,1": "AirPods (3rd generation)",
            "AudioAccessory1,1": "HomePod",
            "AudioAccessory1,2": "HomePod",
            "AudioAccessory5,1": "HomePod mini",
            "Watch1,1": "Apple Watch (1st generation)",
            "Watch1,2": "Apple Watch (1st generation)",
            "Watch2,3": "Apple Watch Series 2",
            "Watch2,4": "Apple Watch Series 2",
            "Watch2,6": "Apple Watch Series 1",
            "Watch2,7": "Apple Watch Series 1",
            "Watch3,1": "Apple Watch Series 3",
            "Watch3,2": "Apple Watch Series 3",
            "Watch3,3": "Apple Watch Series 3",
            "Watch3,4": "Apple Watch Series 3",
            "Watch4,1": "Apple Watch Series 4",
            "Watch4,2": "Apple Watch Series 4",
            "Watch4,3": "Apple Watch Series 4",
            "Watch4,4": "Apple Watch Series 4",
            "Watch5,1": "Apple Watch Series 5",
            "Watch5,10": "Apple Watch SE",
            "Watch5,11": "Apple Watch SE",
            "Watch5,12": "Apple Watch SE",
            "Watch5,2": "Apple Watch Series 5",
            "Watch5,3": "Apple Watch Series 5",
            "Watch5,4": "Apple Watch Series 5",
            "Watch5,9": "Apple Watch SE",
            "Watch6,1": "Apple Watch Series 6",
            "Watch6,10": "Apple Watch SE (2nd generation)",
            "Watch6,11": "Apple Watch SE (2nd generation)",
            "Watch6,12": "Apple Watch SE (2nd generation)",
            "Watch6,13": "Apple Watch SE (2nd generation)",
            "Watch6,14": "Apple Watch Series 8",
            "Watch6,15": "Apple Watch Series 8",
            "Watch6,16": "Apple Watch Series 8",
            "Watch6,17": "Apple Watch Series 8",
            "Watch6,18": "Apple Watch Ultra",
            "Watch6,2": "Apple Watch Series 6",
            "Watch6,3": "Apple Watch Series 6",
            "Watch6,4": "Apple Watch Series 6",
            "Watch6,6": "Apple Watch Series 7",
            "Watch6,7": "Apple Watch Series 7",
            "Watch6,8": "Apple Watch Series 7",
            "Watch6,9": "Apple Watch Series 7",
            "iPad1,1": "iPad",
            "iPad11,1": "iPad mini (5th generation)",
            "iPad11,2": "iPad mini (5th generation)",
            "iPad11,3": "iPad Air (3rd generation)",
            "iPad11,4": "iPad Air (3rd generation)",
            "iPad11,6": "iPad (8th generation)",
            "iPad11,7": "iPad (8th generation)",
            "iPad12,1": "iPad (9th generation)",
            "iPad12,2": "iPad (9th generation)",
            "iPad13,1": "iPad Air (4th generation)",
            "iPad13,10": "iPad Pro (12.9-inch) (5th generation)",
            "iPad13,11": "iPad Pro (12.9-inch) (5th generation)",
            "iPad13,16": "iPad Air (5th generation)",
            "iPad13,17": "iPad Air (5th generation)",
            "iPad13,2": "iPad Air (4th generation)",
            "iPad13,4": "iPad Pro (11-inch) (3rd generation)",
            "iPad13,5": "iPad Pro (11-inch) (3rd generation)",
            "iPad13,6": "iPad Pro (11-inch) (3rd generation)",
            "iPad13,7": "iPad Pro (11-inch) (3rd generation)",
            "iPad13,8": "iPad Pro (12.9-inch) (5th generation)",
            "iPad13,9": "iPad Pro (12.9-inch) (5th generation)",
            "iPad14,1": "iPad mini (6th generation)",
            "iPad14,2": "iPad mini (6th generation)",
            "iPad2,1": "iPad 2",
            "iPad2,2": "iPad 2",
            "iPad2,3": "iPad 2",
            "iPad2,4": "iPad 2",
            "iPad2,5": "iPad mini",
            "iPad2,6": "iPad mini",
            "iPad2,7": "iPad mini",
            "iPad3,1": "iPad (3rd generation)",
            "iPad3,2": "iPad (3rd generation)",
            "iPad3,3": "iPad (3rd generation)",
            "iPad3,4": "iPad (4th generation)",
            "iPad3,5": "iPad (4th generation)",
            "iPad3,6": "iPad (4th generation)",
            "iPad4,1": "iPad Air",
            "iPad4,2": "iPad Air",
            "iPad4,3": "iPad Air",
            "iPad4,4": "iPad mini 2",
            "iPad4,5": "iPad mini 2",
            "iPad4,6": "iPad mini 2",
            "iPad4,7": "iPad mini 3",
            "iPad4,8": "iPad mini 3",
            "iPad4,9": "iPad mini 3",
            "iPad5,1": "iPad mini 4",
            "iPad5,2": "iPad mini 4",
            "iPad5,3": "iPad Air 2",
            "iPad5,4": "iPad Air 2",
            "iPad6,11": "iPad (5th generation)",
            "iPad6,12": "iPad (5th generation)",
            "iPad6,3": "iPad Pro (9.7-inch)",
            "iPad6,4": "iPad Pro (9.7-inch)",
            "iPad6,7": "iPad Pro (12.9-inch)",
            "iPad6,8": "iPad Pro (12.9-inch)",
            "iPad7,1": "iPad Pro (12.9-inch, 2nd generation)",
            "iPad7,11": "iPad (7th generation)",
            "iPad7,12": "iPad (7th generation)",
            "iPad7,2": "iPad Pro (12.9-inch, 2nd generation)",
            "iPad7,3": "iPad Pro (10.5-inch)",
            "iPad7,4": "iPad Pro (10.5-inch)",
            "iPad7,5": "iPad (6th generation)",
            "iPad7,6": "iPad (6th generation)",
            "iPad8,1": "iPad Pro (11-inch)",
            "iPad8,10": "iPad Pro (11-inch) (2nd generation)",
            "iPad8,11": "iPad Pro (12.9-inch) (4th generation)",
            "iPad8,12": "iPad Pro (12.9-inch) (4th generation)",
            "iPad8,2": "iPad Pro (11-inch)",
            "iPad8,3": "iPad Pro (11-inch)",
            "iPad8,4": "iPad Pro (11-inch)",
            "iPad8,5": "iPad Pro (12.9-inch) (3rd generation)",
            "iPad8,6": "iPad Pro (12.9-inch) (3rd generation)",
            "iPad8,7": "iPad Pro (12.9-inch) (3rd generation)",
            "iPad8,8": "iPad Pro (12.9-inch) (3rd generation)",
            "iPad8,9": "iPad Pro (11-inch) (2nd generation)",
            "iPhone1,1": "iPhone",
            "iPhone1,2": "iPhone 3G",
            "iPhone10,1": "iPhone 8",
            "iPhone10,2": "iPhone 8 Plus",
            "iPhone10,3": "iPhone X",
            "iPhone10,4": "iPhone 8",
            "iPhone10,5": "iPhone 8 Plus",
            "iPhone10,6": "iPhone X",
            "iPhone11,2": "iPhone XS",
            "iPhone11,4": "iPhone XS Max",
            "iPhone11,6": "iPhone XS Max",
            "iPhone11,8": "iPhone XR",
            "iPhone12,1": "iPhone 11",
            "iPhone12,3": "iPhone 11 Pro",
            "iPhone12,5": "iPhone 11 Pro Max",
            "iPhone12,8": "iPhone SE (2nd generation)",
            "iPhone13,1": "iPhone 12 mini",
            "iPhone13,2": "iPhone 12",
            "iPhone13,3": "iPhone 12 Pro",
            "iPhone13,4": "iPhone 12 Pro Max",
            "iPhone14,2": "iPhone 13 Pro",
            "iPhone14,3": "iPhone 13 Pro Max",
            "iPhone14,4": "iPhone 13 mini",
            "iPhone14,5": "iPhone 13",
            "iPhone14,6": "iPhone SE (3rd generation)",
            "iPhone14,7": "iPhone 14",
            "iPhone14,8": "iPhone 14 Plus",
            "iPhone15,2": "iPhone 14 Pro",
            "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone2,1": "iPhone 3GS",
            "iPhone3,1": "iPhone 4",
            "iPhone3,2": "iPhone 4",
            "iPhone3,3": "iPhone 4",
            "iPhone4,1": "iPhone 4S",
            "iPhone5,1": "iPhone 5",
            "iPhone5,2": "iPhone 5",
            "iPhone5,3": "iPhone 5c",
            "iPhone5,4": "iPhone 5c",
            "iPhone6,1": "iPhone 5s",
            "iPhone6,2": "iPhone 5s",
            "iPhone7,1": "iPhone 6 Plus",
            "iPhone7,2": "iPhone 6",
            "iPhone8,1": "iPhone 6s",
            "iPhone8,2": "iPhone 6s Plus",
            "iPhone8,4": "iPhone SE (1st generation)",
            "iPhone9,1": "iPhone 7",
            "iPhone9,2": "iPhone 7 Plus",
            "iPhone9,3": "iPhone 7",
            "iPhone9,4": "iPhone 7 Plus",
            "iPod1,1": "iPod touch",
            "iPod2,1": "iPod touch (2nd generation)",
            "iPod3,1": "iPod touch (3rd generation)",
            "iPod4,1": "iPod touch (4th generation)",
            "iPod5,1": "iPod touch (5th generation)",
            "iPod7,1": "iPod touch (6th generation)",
            "iPod9,1": "iPod touch (7th generation)",
            "iProd8,1": "AirPods Pro",
            "iProd8,6": "AirPods Max",
        ]
        // TODO: 待扩展
        let macos_deviceMapJson: [String: String] = [
            "iMac21,1": "iMac (24-inch, M1, 2021)",
            "iMac21,2": "iMac (24-inch, M1, 2021)",
            "Macmini9,1":"Mac mini (M1, 2020)"
        ]
        return iosDeviceMapJson.merging(macos_deviceMapJson) { s1, s2 in
            return s1
        }
    }()
}
