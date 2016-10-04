//
//  MyLocalDefine.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

import Foundation

private let userDefault = UserDefaults.standard
private let languageKey = "userLanguageKey"

private var bundle: Bundle?

class InternationalControl {
    
    /**
     改变当前语言
     */
    class func changeLanguage() {
        initLanguage()
        var languageWillChange = "en"
        if checkIfIsEnglish() {
            languageWillChange = "zh-Hant"
        }
        
        configureBundle(languageWillChange)
        
        userDefault.set(languageWillChange, forKey: languageKey)
        userDefault.synchronize()
    }
    
    /**
     检验当前语言是否是英语
     
     - returns: true or false
     */
    class func checkIfIsEnglish() -> Bool {
        initLanguage()
        return "en" == userDefault.object(forKey: languageKey) as! String
    }
}

// MARK: - Private Method
private extension InternationalControl {
    
    class func currentBundle() -> Bundle {
        initLanguage()
        return bundle!
    }
    
    /**
     初始化语言
     */
    class func initLanguage() {
        var language = userDefault.value(forKey: languageKey) as? String
        if language != nil {
            if bundle == nil {
                configureBundle(language!)
            }
            
            return
        }
        
        let languages = userDefault.object(forKey: "AppleLanguages") as? Array <String>
        language = languages![0]
        
        var current = "en"
        if language!.contains("zh") {
            current = "zh-Hant"
        }
        
        configureBundle(current)
        
        userDefault.set(current, forKey: languageKey)
        userDefault.synchronize()
    }
    
    class func configureBundle(_ name: String) {
        let path = Bundle.main.path(forResource: name, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
}

private func localStringFromKey(_ key: String) -> String {
    return InternationalControl.currentBundle().localizedString(forKey: key, value: "", table: nil)
}

/// 返回一个方法
private func magicString(_ key: String) -> () -> String {
    return { return localStringFromKey(key) }
}

let HOMELOGO = magicString("homeLogo")

let SETMAIL    = magicString("setMail")
let CANTPHONE  = magicString("cantPhone")

// 时间
let MONTHS   = magicString("Months")
let YEARS    = magicString("Years")
let MONTH    = magicString("Month")
let YEAR     = magicString("Year")


// 加载
let LOADFAIL     = magicString("LoadFail")
let RESET        = magicString("reset")
let BACK         = magicString("back")
let DONE         = magicString("Done")

// 底部栏标题
let ABACUS       = magicString("Abacus")
let REPAYMENT    = magicString("Repayment")
let STAMPDUTY    = magicString("Stamp_Duty")
let CHECKLIST    = magicString("Checklist")
let CONTACTUS    = magicString("Contact_Us")

// 中英文转换
let REMIND       = magicString("Remind")
let CONTENT      = magicString("Content")
let CANCEL       = magicString("Cancel")

let ABACUS_HOME_LOANS  = magicString("Abacus_Home_Loans")

// Abacus 列表大标题
let ABACUS_TITLE  = magicString("Abacus_Title")

// Abacus Loan 标题
let ABACUS_LOAN_TITLE_1  = magicString("Abacus_Loan_Title_1")
let ABACUS_LOAN_TITLE_2  = magicString("Abacus_Loan_Title_2")

// Abacus 语言切换按钮
let ABACUS_BUTTON_TEXT   = magicString("Abacus_Button_Text")

// Repayment 标题
let REPAYMENT_TITLE_1  = magicString("Repayment_Title_1")
let REPAYMENT_TITLE_2  = magicString("Repayment_Title_2")
let REPAYMENT_TITLE_3  = magicString("Repayment_Title_3")
let REPAYMENT_TITLE_4  = magicString("Repayment_Title_4")
let REPAYMENT_TITLE_5  = magicString("Repayment_Title_5")

// Repayment Frequency 选项
let REPAYMENT_FREQUENCY_1  = magicString("Repayment_Frequency_1")
let REPAYMENT_FREQUENCY_2  = magicString("Repayment_Frequency_2")
let REPAYMENT_FREQUENCY_3  = magicString("Repayment_Frequency_3")

// Repayment Type 选项
let REPAYMENT_TYPE_1  = magicString("Repayment_Type_1")
let REPAYMENT_TYPE_2  = magicString("Repayment_Type_2")

// Repayment Graph frequency 标题
let REPAYMENT_GRAPH_1_FREQUENCY_1  = magicString("Repayment_Graph_1_Frequency_1")
let REPAYMENT_GRAPH_1_FREQUENCY_2  = magicString("Repayment_Graph_1_Frequency_2")
let REPAYMENT_GRAPH_1_FREQUENCY_3  = magicString("Repayment_Graph_1_Frequency_3")

// Repayment Graph 1 title
let REPAYMENT_GRAPH_1_TITLE        = magicString("Repayment_Graph_1_Title")
let REPAYMENT_GRAPH_1_SUBTITLE_1   = magicString("Repayment_Graph_1_SubTitle_1")
let REPAYMENT_GRAPH_1_SUBTITLE_2   = magicString("Repayment_Graph_1_SubTitle_2")

// Repayment Graph 2 title
let REPAYMENT_GRAPH_2_TITLE        = magicString("Repayment_Graph_2_Title")
let REPAYMENT_GRAPH_2_SUBTITLE     = magicString("Repayment_Graph_2_SubTitle")
let REPAYMENT_GRAPH_2_INTEREST     = magicString("Repayment_Graph_2_Interest")
// Repayment Graph 3 extra title
let REPAYMENT_GRAPH_3_EXTRA        = magicString("Repayment_Graph_3_Extra")
let REPAYMENT_GRAPH_3_ORIGINAL     = magicString("Repayment_Graph_3_Original")
let REPAYMENT_GRAPH_3_AFTEREXTRA   = magicString("Repayment_Graph_3_AfterExtra")

// Repayment Graph 3 ExtraView title
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_1  = "Repayment_Graph_3_ExtraView_Title_1"
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_2  = "Repayment_Graph_3_ExtraView_Title_2"

let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_MIN_MONTH      = magicString("Repayment_Graph_3_ExtraView_Title_Min_Month")
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_INC_MONTH      = magicString("Repayment_Graph_3_ExtraView_Title_Inc_Month")
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_MIN_FORTNIGHT  = magicString("Repayment_Graph_3_ExtraView_Title_Min_Fortnight")
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_INC_FORTNIGHT  = magicString("Repayment_Graph_3_ExtraView_Title_Inc_Fortnight")
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_MIN_WEEK       = magicString("Repayment_Graph_3_ExtraView_Title_Min_Week")
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_INC_WEEK       = magicString("Repayment_Graph_3_ExtraView_Title_Inc_Week")

let REPAYMENT_EMAIL                = magicString("Repayment_email")
let REPAYMENT_EMAIL_TITLE          = magicString("Repayment_email_title")
let REPAYMENT_EMAIL_RESULT         = magicString("Repayment_email_result")
let REPAYMENT_EMAIL_TOTALCOST      = magicString("Repayment_email_totalcost")
let REPAYMENT_EMAIL_TOTALINTEREST  = magicString("Repayment_email_totalinterest")
// StampDuty 标题
let STAMPDUTY_TITLE_1  = magicString("StampDuty_Title_1")
let STAMPDUTY_TITLE_2  = magicString("StampDuty_Title_2")
let STAMPDUTY_TITLE_3  = magicString("StampDuty_Title_3")
let STAMPDUTY_TITLE_4  = magicString("StampDuty_Title_4")

// Stamp Duty pickerstate选项缩写
let STAMPDUTY_PICKER_1  = magicString("StampDuty_Picker_1")
let STAMPDUTY_PICKER_2  = magicString("StampDuty_Picker_2")
let STAMPDUTY_PICKER_3  = magicString("StampDuty_Picker_3")
let STAMPDUTY_PICKER_4  = magicString("StampDuty_Picker_4")
let STAMPDUTY_PICKER_5  = magicString("StampDuty_Picker_5")
let STAMPDUTY_PICKER_6  = magicString("StampDuty_Picker_6")
let STAMPDUTY_PICKER_7  = magicString("StampDuty_Picker_7")
let STAMPDUTY_PICKER_8  = magicString("StampDuty_Picker_8")

// Stamp Duty pickerstate选项全称
let STAMPDUTY_PICKER_FULL_1  = magicString("StampDuty_Picker_Full_1")
let STAMPDUTY_PICKER_FULL_2  = magicString("StampDuty_Picker_Full_2")
let STAMPDUTY_PICKER_FULL_3  = magicString("StampDuty_Picker_Full_3")
let STAMPDUTY_PICKER_FULL_4  = magicString("StampDuty_Picker_Full_4")
let STAMPDUTY_PICKER_FULL_5  = magicString("StampDuty_Picker_Full_5")
let STAMPDUTY_PICKER_FULL_6  = magicString("StampDuty_Picker_Full_6")
let STAMPDUTY_PICKER_FULL_7  = magicString("StampDuty_Picker_Full_7")
let STAMPDUTY_PICKER_FULL_8  = magicString("StampDuty_Picker_Full_8")

// Stamp Duty 图表1
let STAMPDUTY_GRAPH_1_SUBTITLE            = magicString("StampDuty_Graph_1_SubTitle")
let STAMPDUTY_GRAPH_1_STAMPDUTY           = magicString("StampDuty_Graph_1_StampDuty")
let STAMPDUTY_GRAPH_1_TRANSFERFEE         = magicString("StampDuty_Graph_1_TransferFee")
let STAMPDUTY_GRAPH_1_REGISTRATION        = magicString("StampDuty_Graph_1_Registration")
let STAMPDUTY_GRAPH_1_TOTAL               = magicString("StampDuty_Graph_1_Total")
let STAMPDUTY_GRAPH_1_CONCESSION          = magicString("StampDuty_Graph_1_Concession")
let STAMPDUTY_GRAPH_1_DISCLAIMER          = magicString("StampDuty_Graph_1_Disclaimer")
let STAMPDUTY_GRAPH_1_DISCLAIMER_CONTENT  = magicString("StampDuty_Graph_1_Disclaimer_Content")

// Stamp Duty 图表2
let STAMPDUTY_GRAPH_2_SUBTITLE  = magicString("StampDuty_Graph_2_SubTitle")

let STAMPDUTY_EMAIL               = magicString("StampDuty_Email")
let STAMPDUTY_EMAIL_SUBTITLE      = magicString("StampDuty_Email_SubTitle")
let STAMPDUTY_EMAIL_PRICE         = magicString("StampDuty_Email_Price")
let STAMPDUTY_EMAILGOVERMENTFEES  = magicString("StampDuty_Email_GovermentFees")
// checklist 标题
let CHECKLIST_TITLE_1  = magicString("Checklist_Title_1")
let CHECKLIST_TITLE_2  = magicString("Checklist_Title_2")
let CHECKLIST_TITLE_3  = magicString("Checklist_Title_3")

//  checklist home 标题
let CHECKLIST_HOME_TITLE_1  = magicString("Checklist_Home_Title_1")
let CHECKLIST_HOME_TITLE_2  = magicString("Checklist_Home_Title_2")
let CHECKLIST_HOME_TITLE_3  = magicString("Checklist_Home_Title_3")
let CHECKLIST_HOME_TITLE_4  = magicString("Checklist_Home_Title_4")
let CHECKLIST_HOME_TITLE_5  = magicString("Checklist_Home_Title_5")

// checklist home select
let CHECKLIST_HOME_SELECT_1_1  = magicString("Checklist_Home_Select_1_1")
let CHECKLIST_HOME_SELECT_1_2  = magicString("Checklist_Home_Select_1_2")
let CHECKLIST_HOME_SELECT_1_3  = magicString("Checklist_Home_Select_1_3")
let CHECKLIST_HOME_SELECT_1_4  = magicString("Checklist_Home_Select_1_4")
let CHECKLIST_HOME_SELECT_1_5  = magicString("Checklist_Home_Select_1_5")
let CHECKLIST_HOME_SELECT_1_6  = magicString("Checklist_Home_Select_1_6")

let CHECKLIST_HOME_SELECT_2_1  = magicString("Checklist_Home_Select_2_1")
let CHECKLIST_HOME_SELECT_2_2  = magicString("Checklist_Home_Select_2_2")
let CHECKLIST_HOME_SELECT_2_3  = magicString("Checklist_Home_Select_2_3")
let CHECKLIST_HOME_SELECT_2_4  = magicString("Checklist_Home_Select_2_4")

let CHECKLIST_HOME_SELECT_3_1  = magicString("Checklist_Home_Select_3_1")
let CHECKLIST_HOME_SELECT_3_2  = magicString("Checklist_Home_Select_3_2")

let CHECKLIST_HOME_SELECT_4_1  = magicString("Checklist_Home_Select_4_1")
let CHECKLIST_HOME_SELECT_4_2  = magicString("Checklist_Home_Select_4_2")
let CHECKLIST_HOME_SELECT_4_3  = magicString("Checklist_Home_Select_4_3")

let CHECKLIST_HOME_SELECT_5_1  = magicString("Checklist_Home_Select_5_1")
let CHECKLIST_HOME_SELECT_5_2  = magicString("Checklist_Home_Select_5_2")
// checklist moving 标题
let CHECKLIST_MOVING_TITLE_1  = magicString("Checklist_Moving_Title_1")
let CHECKLIST_MOVING_TITLE_2  = magicString("Checklist_Moving_Title_2")
let CHECKLIST_MOVING_TITLE_3  = magicString("Checklist_Moving_Title_3")
let CHECKLIST_MOVING_TITLE_4  = magicString("Checklist_Moving_Title_4")
let CHECKLIST_MOVING_TITLE_5  = magicString("Checklist_Moving_Title_5")
let CHECKLIST_MOVING_TITLE_6  = magicString("Checklist_Moving_Title_6")

// checklist moving question
let CHECKLIST_MOVING_QUESTION_1  = magicString("Checklist_Moving_Question_1")
let CHECKLIST_MOVING_QUESTION_2  = magicString("Checklist_Moving_Question_2")
let CHECKLIST_MOVING_QUESTION_3  = magicString("Checklist_Moving_Question_3")
let CHECKLIST_MOVING_QUESTION_4  = magicString("Checklist_Moving_Question_4")
let CHECKLIST_MOVING_QUESTION_5  = magicString("Checklist_Moving_Question_5")
let CHECKLIST_MOVING_QUESTION_6  = magicString("Checklist_Moving_Question_6")


// checklist moving select
let CHECKLIST_MOVING_SELECT_1_1  = magicString("Checklist_Moving_Select_1_1")
let CHECKLIST_MOVING_SELECT_1_2  = magicString("Checklist_Moving_Select_1_2")
let CHECKLIST_MOVING_SELECT_1_3  = magicString("Checklist_Moving_Select_1_3")
let CHECKLIST_MOVING_SELECT_1_4  = magicString("Checklist_Moving_Select_1_4")

let CHECKLIST_MOVING_SELECT_2_1  = magicString("Checklist_Moving_Select_2_1")
let CHECKLIST_MOVING_SELECT_2_2  = magicString("Checklist_Moving_Select_2_2")
let CHECKLIST_MOVING_SELECT_2_3  = magicString("Checklist_Moving_Select_2_3")
let CHECKLIST_MOVING_SELECT_2_4  = magicString("Checklist_Moving_Select_2_4")
let CHECKLIST_MOVING_SELECT_2_5  = magicString("Checklist_Moving_Select_2_5")

let CHECKLIST_MOVING_SELECT_3_1   = magicString("Checklist_Moving_Select_3_1")
let CHECKLIST_MOVING_SELECT_3_2   = magicString("Checklist_Moving_Select_3_2")
let CHECKLIST_MOVING_SELECT_3_3   = magicString("Checklist_Moving_Select_3_3")
let CHECKLIST_MOVING_SELECT_3_4   = magicString("Checklist_Moving_Select_3_4")
let CHECKLIST_MOVING_SELECT_3_5   = magicString("Checklist_Moving_Select_3_5")
let CHECKLIST_MOVING_SELECT_3_6   = magicString("Checklist_Moving_Select_3_6")
let CHECKLIST_MOVING_SELECT_3_7   = magicString("Checklist_Moving_Select_3_7")
let CHECKLIST_MOVING_SELECT_3_8   = magicString("Checklist_Moving_Select_3_8")
let CHECKLIST_MOVING_SELECT_3_9   = magicString("Checklist_Moving_Select_3_9")
let CHECKLIST_MOVING_SELECT_3_10  = magicString("Checklist_Moving_Select_3_10")
let CHECKLIST_MOVING_SELECT_3_11  = magicString("Checklist_Moving_Select_3_11")
let CHECKLIST_MOVING_SELECT_3_12  = magicString("Checklist_Moving_Select_3_12")
let CHECKLIST_MOVING_SELECT_3_13  = magicString("Checklist_Moving_Select_3_13")

let CHECKLIST_MOVING_SELECT_4_1   = magicString("Checklist_Moving_Select_4_1")
let CHECKLIST_MOVING_SELECT_4_2   = magicString("Checklist_Moving_Select_4_2")
let CHECKLIST_MOVING_SELECT_4_3   = magicString("Checklist_Moving_Select_4_3")
let CHECKLIST_MOVING_SELECT_4_4   = magicString("Checklist_Moving_Select_4_4")
let CHECKLIST_MOVING_SELECT_4_5   = magicString("Checklist_Moving_Select_4_5")
let CHECKLIST_MOVING_SELECT_4_6   = magicString("Checklist_Moving_Select_4_6")
let CHECKLIST_MOVING_SELECT_4_7   = magicString("Checklist_Moving_Select_4_7")
let CHECKLIST_MOVING_SELECT_4_8   = magicString("Checklist_Moving_Select_4_8")
let CHECKLIST_MOVING_SELECT_4_9   = magicString("Checklist_Moving_Select_4_9")
let CHECKLIST_MOVING_SELECT_4_10  = magicString("Checklist_Moving_Select_4_10")
let CHECKLIST_MOVING_SELECT_4_11  = magicString("Checklist_Moving_Select_4_11")

let CHECKLIST_MOVING_SELECT_5_1  = magicString("Checklist_Moving_Select_5_1")
let CHECKLIST_MOVING_SELECT_5_2  = magicString("Checklist_Moving_Select_5_2")
let CHECKLIST_MOVING_SELECT_5_3  = magicString("Checklist_Moving_Select_5_3")
let CHECKLIST_MOVING_SELECT_5_4  = magicString("Checklist_Moving_Select_5_4")

let CHECKLIST_MOVING_SELECT_6_1  = magicString("Checklist_Moving_Select_6_1")
let CHECKLIST_MOVING_SELECT_6_2  = magicString("Checklist_Moving_Select_6_2")
let CHECKLIST_MOVING_SELECT_6_3  = magicString("Checklist_Moving_Select_6_3")
let CHECKLIST_MOVING_SELECT_6_4  = magicString("Checklist_Moving_Select_6_4")

// checklist pre-settle 标题
let CHECKLIST_PRESETTLE_TITLE_1  = magicString("Checklist_Presettle_Title_1")
let CHECKLIST_PRESETTLE_TITLE_2  = magicString("Checklist_Presettle_Title_2")

// checklist pre-settle 子标题
let CHECKLIST_PRESETTLE_SUBTITLE_1  = magicString("Checklist_Presettle_SubTitle_1")
let CHECKLIST_PRESETTLE_SUBTITLE_2  = magicString("Checklist_Presettle_SubTitle_2")

// checklist pre-select select
let CHECKLIST_PRESETTLE_SELECT_1   = magicString("checklist_presettle_select_1")
let CHECKLIST_PRESETTLE_SELECT_2   = magicString("checklist_presettle_select_2")

// contact us 标题
let CONTACTUS_TITLE_1  = magicString("ContactUs_Title_1")
let CONTACTUS_TITLE_2  = magicString("ContactUs_Title_2")
let CONTACTUS_TITLE_3  = magicString("ContactUs_Title_3")
let CONTACTUS_TITLE_4  = magicString("ContactUs_Title_4")

// contact us 标题栏内容
let CONTACTUS_CONTENT_1  = magicString("ContactUs_Content_1")
let CONTACTUS_CONTENT_2  = magicString("ContactUs_Content_2")
let CONTACTUS_CONTENT_3  = magicString("ContactUs_Content_3")

// contact us 地图界面标题
let CONTACTUS_MAP_TITLE_1  = magicString("ContactUs_Map_Title_1")
let CONTACTUS_MAP_TITLE_2  = magicString("ContactUs_Map_Title_2")
let CONTACTUS_MAP_TITLE_3  = magicString("ContactUs_Map_Title_3")

// contact us 地图界面电话
let CONTACTUS_MAP_PHONE_1  = magicString("ContactUs_Map_Phone_1")
let CONTACTUS_MAP_PHONE_2  = magicString("ContactUs_Map_Phone_2")
let CONTACTUS_MAP_PHONE_3  = magicString("ContactUs_Map_Phone_3")

// contact us 地图界面地址
let CONTACTUS_MAP_ADDRESS_1  = magicString("ContactUs_Map_Address_1")
let CONTACTUS_MAP_ADDRESS_2  = magicString("ContactUs_Map_Address_2")
let CONTACTUS_MAP_ADDRESS_3  = magicString("ContactUs_Map_Address_3")
