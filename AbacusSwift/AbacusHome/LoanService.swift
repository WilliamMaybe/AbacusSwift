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
    
    func request(success:@escaping ([LoanModel], _ total: Int) -> Void, failure:@escaping (String) -> Void)
}

public enum Loan {
    case residential(Int)
    case commercial(Int)
}

extension Loan: serviceConvertible {
    
    var baseURL: String { return "http://52.64.87.191:8011" }
    var path: String {
        let language = InternationalControl.checkIfIsEnglish() ? 0 : 1
        switch self {
        case .residential(let page):
            return "/api/abacus/loansNew/getlist?LoansType=1&indexPage=\(page)&pageSize=2&keyWord&Lang=\(language)"
        case .commercial(let page):
            return "/api/abacus/loansNew/getlist?LoansType=0&indexPage=\(page)&pageSize=10&keyWord&Lang=\(language)"
        }
    }
    
    func request(success:@escaping ([LoanModel], Int) -> Void, failure: @escaping (String) -> Void) {
        Alamofire.request(baseURL + path).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let dict = (value as? Dictionary<String, String>) else {
                    failure(LOADFAIL())
                    return
                }
                
                guard let _ = dict["Data"] else {
                    failure(LOADFAIL())
                    return
                }
                
                guard let _ = dict["Total"] else {
                    failure(LOADFAIL())
                    return
                }
                
                let list = JSON(dict)["Data"]
                var resultList = [LoanModel]()
                for (_, subJSON) in list {
                    let newsId = subJSON["NewId"].stringValue
                    let title  = subJSON["Title"].stringValue
                    let model  = LoanModel(newsId: newsId, title: title)
                    resultList.append(model)
                }
                
                let total = JSON(dict)["Total"].intValue
                success(resultList, total)
                
            case .failure(_):
                failure(LOADFAIL())
            }
        }
    }
}
