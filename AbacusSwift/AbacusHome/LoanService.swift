//
//  LoanService.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/2/7.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import Alamofire
import SwiftyJSON

// MARK: - Model
struct LoanModel {
    let newsId: String
    let title: String
}

// MARK: - Service
protocol serviceConvertible {
    var baseURL: String { get }
    var path: String { get }
    
    func request(success success: ([LoanModel], total: Int) -> Void, failure:(String) -> Void)
}

public enum Loan {
    case Residential(Int)
    case Commercial(Int)
}

extension Loan: serviceConvertible {
    var baseURL: String { return "http://52.64.87.191:8011" }
    var path: String {
        let language = InternationalControl.checkIfIsEnglish() ? 0 : 1
        switch self {
        case .Residential(let page):
            return "/api/abacus/loansNew/getlist?LoansType=1&indexPage=\(page)&pageSize=2&keyWord&Lang=\(language)"
        case .Commercial(let page):
            return "/api/abacus/loansNew/getlist?LoansType=0&indexPage=\(page)&pageSize=10&keyWord&Lang=\(language)"
        }
    }
    
    func request(success success: ([LoanModel], total: Int) -> Void, failure:(String) -> Void) {
        Alamofire.request(.GET, (baseURL + path))
        .responseJSON { response -> Void in
            switch response.result {
            case .Success(let value):
                
                guard let _ = value["Data"] else {
                    failure(localStringFromKey(LOADFAIL))
                    return
                }
                
                guard let _ = value["Total"] else {
                    failure(localStringFromKey(LOADFAIL))
                    return
                }
                
                let list = JSON(value)["Data"]
                var resultList = [LoanModel]()

                for (_, subJson):(String, JSON) in list {
                    let newsId = subJson["NewId"].stringValue
                    let title = subJson["Title"].stringValue
                    let model = LoanModel(newsId: newsId, title: title)
                    resultList.append(model)
                }
                
                let total = JSON(value)["Total"].intValue
                
                success(resultList, total: total)
                
            case .Failure(_):
                failure(localStringFromKey(LOADFAIL))
            }
        }
    }
}
