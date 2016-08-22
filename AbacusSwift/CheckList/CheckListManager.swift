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
    case Require = 0
    case Moving
    
    /**
     添加删除存储的信息
     
     - parameter identifier: 待存储的信息
     */
    func addOrDeleteIdentifier(identifier: Int) {
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
    
    private var data: [Int : [Int]] = [:]
    let x = CheckListType.Require
    override init() {
        super.init()
        createFileIfNotExsit()
        let dataTmp = NSData(contentsOfFile: checkListFilePath())
        data = NSKeyedUnarchiver.unarchiveObjectWithData(dataTmp!) as! [Int : [Int]]
    }
    
    private func defaultData() -> NSData {
        
        let defaultDict = [CheckListType.Require.rawValue : [Int](), CheckListType.Moving.rawValue : [Int]()]
        return NSKeyedArchiver.archivedDataWithRootObject(defaultDict)
    }
    
    /**
     添加删除存储信息
     
     - parameter identifier: 要存储的信息
     - parameter type:       存储类型
     */
    func addOrDeleteIdentifier(identifier: Int, type: CheckListType) {
        
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
        writeData(data, toFile: checkListFilePath())
    }
    
    func dataWithType(type: CheckListType) -> [Int]? {
        
        return data[type.rawValue]
    }
    
    func resetData(type type:CheckListType) {
        data[type.rawValue] = [Int]()
        writeData(data, toFile: checkListFilePath())
    }
}

// MARK: - File Manager
extension CheckListManager {
    
    func checkListFilePath() -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let urlPath = NSURL(fileURLWithPath:documentPath.first!).URLByAppendingPathComponent(checkListName)
        return urlPath.path!
    }
    
    func createFileIfNotExsit() {
        let fileManager = NSFileManager.defaultManager()
        let filePath    = checkListFilePath()

        if !fileManager.fileExistsAtPath(filePath) {
            defaultData().writeToFile(filePath, atomically: true)
        }
    }
    
    func writeData(data: AnyObject ,toFile fileName: String) {
        let finalData = NSKeyedArchiver.archivedDataWithRootObject(data)
        finalData.writeToFile(fileName, atomically: true)
    }
}