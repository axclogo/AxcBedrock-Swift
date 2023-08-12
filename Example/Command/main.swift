//
//  main.swift
//  Command
//
//  Created by 赵新 on 2023/8/11.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import AxcBedrock

let jsonStr = "{\"img\":\"http:\\/\\/cdn.cdypkj.cn\\/wmc\\/template\\/13791648460088.png\",\"wm_id\":0,\"classifyId\":2,\"location\":{\"address\":\"\",\"longitude\":\"\",\"district\":\"\",\"cityName\":\"\",\"latitude\":\"\"},\"size\":50,\"supportAlbum\":false,\"name\":\"施工后\",\"wmId\":11,\"icon\":\"\",\"position\":{\"cityName\":\"\",\"longitude\":\"\",\"address\":\"\",\"district\":\"\",\"latitude\":\"\"},\"fields\":[{\"title\":\"时间\",\"bgColor\":\"\",\"editContent\":false,\"content\":\"\",\"fieldId\":99,\"textColor\":\"\",\"isOpen\":true,\"options\":[],\"isAction\":false,\"label\":\"\",\"type\":\"time\",\"editTitle\":false},{\"editTitle\":false,\"fieldId\":100,\"label\":\"\",\"textColor\":\"\",\"title\":\"地点\",\"content\":\"\",\"isAction\":true,\"type\":\"addr\",\"bgColor\":\"\",\"editContent\":false,\"isOpen\":true,\"options\":[]},{\"options\":[],\"bgColor\":\"#009853\",\"type\":\"title\",\"isAction\":true,\"label\":\"\",\"content\":\"施工后\",\"isOpen\":true,\"title\":\"标题\",\"editContent\":false,\"textColor\":\"\",\"fieldId\":101,\"editTitle\":false},{\"editContent\":true,\"content\":\"\",\"brandAttribute\":{\"location\":0,\"opacity\":0,\"size\":20,\"style\":0},\"label\":\"\",\"options\":[],\"title\":\"品牌图(logo)\",\"bgColor\":\"\",\"editTitle\":false,\"type\":\"brand\",\"isOpen\":false,\"textColor\":\"\",\"isAction\":true,\"fieldId\":608},{\"content\":\"\",\"textColor\":\"\",\"isAction\":true,\"label\":\"\",\"editContent\":false,\"fieldId\":107,\"title\":\"经纬度\",\"editTitle\":false,\"isOpen\":false,\"options\":[],\"type\":\"lat\",\"bgColor\":\"\"},{\"isOpen\":true,\"options\":[],\"fieldId\":102,\"editContent\":false,\"type\":\"weather\",\"bgColor\":\"\",\"isAction\":true,\"textColor\":\"\",\"content\":\"\",\"label\":\"\",\"title\":\"天气\",\"editTitle\":false},{\"title\":\"施工内容\",\"editTitle\":true,\"content\":\"\",\"textColor\":\"\",\"isOpen\":false,\"isAction\":true,\"type\":\"text\",\"bgColor\":\"\",\"fieldId\":104,\"label\":\"\",\"editContent\":true,\"options\":[]},{\"options\":[],\"isOpen\":false,\"fieldId\":103,\"title\":\"施工区域\",\"textColor\":\"\",\"label\":\"\",\"content\":\"\",\"editContent\":true,\"bgColor\":\"\",\"editTitle\":true,\"type\":\"text\",\"isAction\":true},{\"content\":\"\",\"editContent\":true,\"label\":\"\",\"type\":\"text\",\"title\":\"施工责任人\",\"editTitle\":true,\"textColor\":\"\",\"fieldId\":105,\"isOpen\":false,\"bgColor\":\"\",\"isAction\":true,\"options\":[]},{\"content\":\"\",\"isAction\":true,\"fieldId\":106,\"bgColor\":\"\",\"textColor\":\"\",\"label\":\"\",\"type\":\"text\",\"editTitle\":true,\"isOpen\":false,\"title\":\"监理责任人\",\"options\":[],\"editContent\":true},{\"editContent\":true,\"editTitle\":false,\"isAction\":true,\"type\":\"remark\",\"fieldId\":110,\"title\":\"备注\",\"bgColor\":\"\",\"content\":\"\",\"label\":\"\",\"isOpen\":false,\"options\":[],\"textColor\":\"\"},{\"textColor\":\"\",\"label\":\"\",\"editTitle\":true,\"type\":\"text\",\"content\":\"\",\"options\":[],\"title\":\"施工单位\",\"bgColor\":\"#009853\",\"fieldId\":108,\"isAction\":true,\"isOpen\":true,\"editContent\":true},{\"fieldId\":109,\"content\":\"\",\"options\":[],\"title\":\"监理单位\",\"isAction\":true,\"bgColor\":\"#009853\",\"editTitle\":true,\"isOpen\":false,\"type\":\"text\",\"textColor\":\"\",\"editContent\":true,\"label\":\"\"}],\"opacity\":30,\"styleCode\":1}"



let deData = jsonStr.axc.jsonData
let obj = deData?.axc.jsonObj
print(obj)

//let data = jsonStr.axc.jsonEncodeData
//print(data)
//let data2 = jsonStr.axc.data(encoding: .utf8)
//print(data2)
//
//let objss = data?.axc.jsonSerializationObj
//print(objss)
//
//let objss2 = data2?.axc.jsonSerializationObj
//print(objss2)


//print(objss)


//let obj2 = data?.axc.jsonSerializationObj


//let ssss = "123456789"
//let data2 = ssss.axc.data(encoding: .utf8)
//print(data2?.axc.string(encoding: .utf8))
