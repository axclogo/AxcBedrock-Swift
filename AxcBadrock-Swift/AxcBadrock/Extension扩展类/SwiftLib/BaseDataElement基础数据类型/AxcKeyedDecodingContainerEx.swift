//
//  AxcKeyedDecodingContainerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/6/25.
//

import Foundation

public extension KeyedDecodingContainer{
    /// 转换成任意类型
    func axc_decode<T: Codable>(for key: Key) -> T? {
        return try? decode(T.self, forKey: key)
    }
    
    /// 转换成String类型
    func axc_decode(for key: Key) -> String     { return axc_decode(for: key) ?? "" }
    /// 转换成String类型
    func axc_decode(for key: Key) -> String?    { return axc_decodeUnified(for: key)?.axc_string }
    
    /// 转换成Int类型
    func axc_decode(for key: Key) -> Int        { return axc_decode(for: key) ?? 0 }
    /// 转换成Int类型
    func axc_decode(for key: Key) -> Int?       { return axc_decodeUnified(for: key)?.axc_int }
    
    /// 转换成Int8类型
    func axc_decode(for key: Key) -> Int8       { return axc_decode(for: key) ?? 0 }
    /// 转换成Int8类型
    func axc_decode(for key: Key) -> Int8?      { return axc_decodeUnified(for: key)?.axc_int8 }
    
    /// 转换成Int16类型
    func axc_decode(for key: Key) -> Int16      { return axc_decode(for: key) ?? 0 }
    /// 转换成Int16类型
    func axc_decode(for key: Key) -> Int16?     { return axc_decodeUnified(for: key)?.axc_int16 }
    
    /// 转换成Int32类型
    func axc_decode(for key: Key) -> Int32      { return axc_decode(for: key) ?? 0 }
    /// 转换成Int32类型
    func axc_decode(for key: Key) -> Int32?     { return axc_decodeUnified(for: key)?.axc_int32 }
    
    /// 转换成Int64类型
    func axc_decode(for key: Key) -> Int64      { return axc_decode(for: key) ?? 0 }
    /// 转换成Int64类型
    func axc_decode(for key: Key) -> Int64?     { return axc_decodeUnified(for: key)?.axc_int64 }
    
    /// 转换成UInt类型
    func axc_decode(for key: Key) -> UInt       { return axc_decode(for: key) ?? 0 }
    /// 转换成UInt类型
    func axc_decode(for key: Key) -> UInt?      { return axc_decodeUnified(for: key)?.axc_uint }
    
    /// 转换成UInt8类型
    func axc_decode(for key: Key) -> UInt8      { return axc_decode(for: key) ?? 0 }
    /// 转换成UInt8类型
    func axc_decode(for key: Key) -> UInt8?     { return axc_decodeUnified(for: key)?.axc_uint8 }
    
    /// 转换成UInt16类型
    func axc_decode(for key: Key) -> UInt16     { return axc_decode(for: key) ?? 0 }
    /// 转换成UInt16类型
    func axc_decode(for key: Key) -> UInt16?    { return axc_decodeUnified(for: key)?.axc_uint16 }
    
    /// 转换成UInt32类型
    func axc_decode(for key: Key) -> UInt32     { return axc_decode(for: key) ?? 0 }
    /// 转换成UInt32类型
    func axc_decode(for key: Key) -> UInt32?    { return axc_decodeUnified(for: key)?.axc_uint32 }
    
    /// 转换成UInt64类型
    func axc_decode(for key: Key) -> UInt64     { return axc_decode(for: key) ?? 0 }
    /// 转换成UInt64类型
    func axc_decode(for key: Key) -> UInt64?    { return axc_decodeUnified(for: key)?.axc_uint64 }
    
    /// 转换成Float类型
    func axc_decode(for key: Key) -> Float      { return axc_decode(for: key) ?? 0 }
    /// 转换成Float类型
    func axc_decode(for key: Key) -> Float?     { return axc_decodeUnified(for: key)?.axc_float }
    
    /// 转换成Double类型
    func axc_decode(for key: Key) -> Double     { return axc_decode(for: key) ?? 0 }
    /// 转换成Double类型
    func axc_decode(for key: Key) -> Double?    { return axc_decodeUnified(for: key)?.axc_double }
    
    /// 转换成CGFloat类型
    func axc_decode(for key: Key) -> CGFloat    { return axc_decode(for: key) ?? 0 }
    /// 转换成CGFloat类型
    func axc_decode(for key: Key) -> CGFloat?   { return axc_decodeUnified(for: key)?.axc_cgFloat }
    
    /// 转换成Bool类型
    func axc_decode(for key: Key) -> Bool       { return axc_decode(for: key) ?? false }
    /// 转换成Bool类型
    func axc_decode(for key: Key) -> Bool?      { return axc_decodeUnified(for: key)?.axc_bool }
    
    /// 所有类型转换成AxcUnifiedNumberTarget
    /// - Parameters:
    ///   - key: 键值
    /// - Returns: AxcUnifiedNumberTarget
    func axc_decodeUnified(for key: Key) -> AxcUnifiedNumberTarget? {
        var target: AxcUnifiedNumberTarget?
        if       let value = try? self.decode(String.self, forKey: key){
            target = value
        }else if let value = try? self.decode(Int.self, forKey: key){
            target = value
        }else if let value = try? self.decode(Int8.self, forKey: key){
            target = value
        }else if let value = try? self.decode(Int16.self, forKey: key){
            target = value
        }else if let value = try? self.decode(Int32.self, forKey: key){
            target = value
        }else if let value = try? self.decode(Int64.self, forKey: key){
            target = value
        }else if let value = try? self.decode(UInt.self, forKey: key){
            target = value
        }else if let value = try? self.decode(UInt8.self, forKey: key){
            target = value
        }else if let value = try? self.decode(UInt16.self, forKey: key){
            target = value
        }else if let value = try? self.decode(UInt32.self, forKey: key){
            target = value
        }else if let value = try? self.decode(UInt64.self, forKey: key){
            target = value
        }else if let value = try? self.decode(Float.self, forKey: key){
            target = value
        }else if let value = try? self.decode(Double.self, forKey: key){
            target = value
        }else if let value = try? self.decode(CGFloat.self, forKey: key){
            target = value
        }else if let value = try? self.decode(Bool.self, forKey: key){
            target = value
        }
        return target
    }
    
    
    /// 转换成[String]类型
    func axc_decode(for key: Key) -> [String]     { return axc_decode(for: key) ?? [] }
    /// 转换成[String]类型
    func axc_decode(for key: Key) -> [String]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_string } }

    /// 转换成[Int]类型
    func axc_decode(for key: Key) -> [Int]        { return axc_decode(for: key) ?? [] }
    /// 转换成[Int]类型
    func axc_decode(for key: Key) -> [Int]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_int } }

    /// 转换成[Int8]类型
    func axc_decode(for key: Key) -> [Int8]       { return axc_decode(for: key) ?? [] }
    /// 转换成[Int8]类型
    func axc_decode(for key: Key) -> [Int8]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_int8 } }

    /// 转换成[Int16]类型
    func axc_decode(for key: Key) -> [Int16]      { return axc_decode(for: key) ?? [] }
    /// 转换成[Int16]类型
    func axc_decode(for key: Key) -> [Int16]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_int16 } }

    /// 转换成[Int32]类型
    func axc_decode(for key: Key) -> [Int32]      { return axc_decode(for: key) ?? [] }
    /// 转换成[Int32]类型
    func axc_decode(for key: Key) -> [Int32]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_int32 } }

    /// 转换成[Int64]类型
    func axc_decode(for key: Key) -> [Int64]      { return axc_decode(for: key) ?? [] }
    /// 转换成[Int64]类型
    func axc_decode(for key: Key) -> [Int64]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_int64 } }

    /// 转换成[UInt]类型
    func axc_decode(for key: Key) -> [UInt]       { return axc_decode(for: key) ?? [] }
    /// 转换成[UInt]类型
    func axc_decode(for key: Key) -> [UInt]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_uint } }

    /// 转换成[UInt8]类型
    func axc_decode(for key: Key) -> [UInt8]      { return axc_decode(for: key) ?? [] }
    /// 转换成[UInt8]类型
    func axc_decode(for key: Key) -> [UInt8]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_uint8 } }

    /// 转换成[UInt16]类型
    func axc_decode(for key: Key) -> [UInt16]     { return axc_decode(for: key) ?? [] }
    /// 转换成[UInt16]类型
    func axc_decode(for key: Key) -> [UInt16]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_uint16 } }

    /// 转换成[UInt32]类型
    func axc_decode(for key: Key) -> [UInt32]     { return axc_decode(for: key) ?? [] }
    /// 转换成[UInt32]类型
    func axc_decode(for key: Key) -> [UInt32]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_uint32 } }

    /// 转换成[UInt64]类型
    func axc_decode(for key: Key) -> [UInt64]     { return axc_decode(for: key) ?? [] }
    /// 转换成[UInt64]类型
    func axc_decode(for key: Key) -> [UInt64]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_uint64 } }

    /// 转换成[Float]类型
    func axc_decode(for key: Key) -> [Float]      { return axc_decode(for: key) ?? [] }
    /// 转换成[Float]类型
    func axc_decode(for key: Key) -> [Float]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_float } }

    /// 转换成[Double]类型
    func axc_decode(for key: Key) -> [Double]     { return axc_decode(for: key) ?? [] }
    /// 转换成[Double]类型
    func axc_decode(for key: Key) -> [Double]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_double } }

    /// 转换成[CGFloat]类型
    func axc_decode(for key: Key) -> [CGFloat]    { return axc_decode(for: key) ?? [] }
    /// 转换成[CGFloat]类型
    func axc_decode(for key: Key) -> [CGFloat]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_cgFloat } }

    /// 转换成[Bool]类型
    func axc_decode(for key: Key) -> [Bool]       { return axc_decode(for: key) ?? [] }
    /// 转换成[Bool]类型
    func axc_decode(for key: Key) -> [Bool]?
    { return axc_decodeArrayUnified(for: key)?.map{ $0.axc_bool } }

    /// 转换成任意数组类型
    func axc_decodeArrayUnified(for key: Key) -> [AxcUnifiedNumberTarget]? {
        var target: [AxcUnifiedNumberTarget]?
        if       let value = try? self.decode([String].self, forKey: key){
            target = value
        }else if let value = try? self.decode([Int].self, forKey: key){
            target = value
        }else if let value = try? self.decode([Int8].self, forKey: key){
            target = value
        }else if let value = try? self.decode([Int16].self, forKey: key){
            target = value
        }else if let value = try? self.decode([Int32].self, forKey: key){
            target = value
        }else if let value = try? self.decode([Int64].self, forKey: key){
            target = value
        }else if let value = try? self.decode([UInt].self, forKey: key){
            target = value
        }else if let value = try? self.decode([UInt8].self, forKey: key){
            target = value
        }else if let value = try? self.decode([UInt16].self, forKey: key){
            target = value
        }else if let value = try? self.decode([UInt32].self, forKey: key){
            target = value
        }else if let value = try? self.decode([UInt64].self, forKey: key){
            target = value
        }else if let value = try? self.decode([Float].self, forKey: key){
            target = value
        }else if let value = try? self.decode([Double].self, forKey: key){
            target = value
        }else if let value = try? self.decode([CGFloat].self, forKey: key){
            target = value
        }else if let value = try? self.decode([Bool].self, forKey: key){
            target = value
        }
        return target
    }
}
