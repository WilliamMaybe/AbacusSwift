//
//  CheckListManager.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/7/4.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit

/**
 存储类型
 
 - Require: Require description
 - Moving:  Moving description
 */
enum CheckListType: Int {
    case require = 0
    case moving
    
    /**
     添加删除存储的信息
     
     - parameter identifier: 待存储的信息
     */
    func addOrDeleteIdentifier(_ identifier: Int) {
       CheckListManager.sharedInstance.addOrDeleteIdentifier(identifier, type: self)
    }
    
    /**
     获取信息
     
     - returns: 信息
     */
    func getData() -> [Int]? {
        
        return CheckListManager.sharedInstance.dataWithType(self)
    }
    
    /**
     重置数据
     */
    func resetData() {
        CheckListManager.sharedInstance.resetData(type: self)
    }
}

private let checkListName = "checkList.plist"

private class CheckListManager: NSObject {
    static let sharedInstance = CheckListManager()
    
    fileprivate var data: [Int : [Int]] = [:]
    let x = CheckListType.require
    override init() {
        super.init()
        createFileIfNotExsit()
        let dataTmp = try? Data(contentsOf: URL(fileURLWithPath: checkListFilePath()))
        data = NSKeyedUnarchiver.unarchiveObject(with: dataTmp!) as! [Int : [Int]]
    }
    
    fileprivate func defaultData() -> Data {
        
        let defaultDict = [CheckListType.require.rawValue : [Int](), CheckListType.moving.rawValue : [Int]()]
        return NSKeyedArchiver.archivedData(withRootObject: defaultDict)
    }
    
    /**
     添加删除存储信息
     
     - parameter identifier: 要存储的信息
     - parameter type:       存储类型
     */
    func addOrDeleteIdentifier(_ identifier: Int, type: CheckListType) {
        
        var identifierArray = data[type.rawValue]
        if identifierArray == nil {
            identifierArray = [Int]()
        }
        
        if identifierArray!.contains(identifier) {
            identifierArray = identifierArray!.filter({ $0 != identifier })
        } else {
            identifierArray!.append(identifier)
        }
        
        data[type.rawValue] = identifierArray
        writeData(data as AnyObject, toFile: checkListFilePath())
    }
    
    func dataWithType(_ type: CheckListType) -> [Int]? {
        
        return data[type.rawValue]
    }
    
    func resetData(type:CheckListType) {
        data[type.rawValue] = [Int]()
        writeData(data as AnyObject, toFile: checkListFilePath())
    }
}

// MARK: - File Manager
extension CheckListManager {
    
    func checkListFilePath() -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let urlPath = URL(fileURLWithPath:documentPath.first!).appendingPathComponent(checkListName)
        return urlPath.path
    }
    
    func createFileIfNotExsit() {
        let fileManager = FileManager.default
        let filePath    = checkListFilePath()

        if !fileManager.fileExists(atPath: filePath) {
            try? defaultData().write(to: URL(fileURLWithPath: filePath), options: [.atomic])
        }
    }
    
    func writeData(_ data: AnyObject ,toFile fileName: String) {
        let finalData = NSKeyedArchiver.archivedData(withRootObject: data)
        try? finalData.write(to: URL(fileURLWithPath: fileName), options: [.atomic])
    }
}
