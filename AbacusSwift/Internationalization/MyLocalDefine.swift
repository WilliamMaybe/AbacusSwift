//
//  MyLocalDefine.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

import Foundation

class InternationalControl {
    private struct staticBundle {
        static var bundle: NSBundle?
    }
    
    let userDefault = NSUserDefaults.standardUserDefaults()
    let languageKey = "userLanguage"
    
    /**
     改变当前语言
     */
    func changeLanguage() {
        
    }
    
    /**
     检验当前语言是否是英语
     
     - returns: true or false
     */
    func checkIfIsEnglish() -> Bool {
        return false
    }
    
    /**
    初始化语言
    */
    private func initLanguage() {
        let language: String? = userDefault.valueForKey(languageKey) as? String
        if language == nil {
            
        }
    }
}

func localStringFromKey(key: String) {
    
}

let SETMAIL    = "setMail"
let CANTPHONE  = "cantPhone"

// 时间
let MONTHS   = "Months"
let YEARS    = "Years"
let MONTH    = "Month"
let YEAR     = "Year"


// 加载
let LOADFAIL     = "LoadFail"
let RESET        = "reset"
let BACK         = "back"
let DONE         = "Done"

// 底部栏标题
let ABACUS       = "Abacus"
let REPAYMENT    = "Repayment"
let STAMPDUTY    = "Stamp_Duty"
let CHECKLIST    = "Checklist"
let CONTACTUS    = "Contact_Us"

// 中英文转换
let REMIND       = "Remind"
let CONTENT      = "Content"
let CANCEL       = "Cancel"

let ABACUS_HOME_LOANS  = "Abacus_Home_Loans"

// Abacus 列表大标题
let ABACUS_TITLE  = "Abacus_Title"

// Abacus Loan 标题
let ABACUS_LOAN_TITLE_1  = "Abacus_Loan_Title_1"
let ABACUS_LOAN_TITLE_2  = "Abacus_Loan_Title_2"

// Abacus 语言切换按钮
let ABACUS_BUTTON_TEXT   = "Abacus_Button_Text"

// Repayment 标题
let REPAYMENT_TITLE_1  = "Repayment_Title_1"
let REPAYMENT_TITLE_2  = "Repayment_Title_2"
let REPAYMENT_TITLE_3  = "Repayment_Title_3"
let REPAYMENT_TITLE_4  = "Repayment_Title_4"
let REPAYMENT_TITLE_5  = "Repayment_Title_5"

// Repayment Frequency 选项
let REPAYMENT_FREQUENCY_1  = "Repayment_Frequency_1"
let REPAYMENT_FREQUENCY_2  = "Repayment_Frequency_2"
let REPAYMENT_FREQUENCY_3  = "Repayment_Frequency_3"

// Repayment Type 选项
let REPAYMENT_TYPE_1  = "Repayment_Type_1"
let REPAYMENT_TYPE_2  = "Repayment_Type_2"

// Repayment Graph frequency 标题
let REPAYMENT_GRAPH_1_FREQUENCY_1  = "Repayment_Graph_1_Frequency_1"
let REPAYMENT_GRAPH_1_FREQUENCY_2  = "Repayment_Graph_1_Frequency_2"
let REPAYMENT_GRAPH_1_FREQUENCY_3  = "Repayment_Graph_1_Frequency_3"

// Repayment Graph 1 title
let REPAYMENT_GRAPH_1_TITLE        = "Repayment_Graph_1_Title"
let REPAYMENT_GRAPH_1_SUBTITLE_1   = "Repayment_Graph_1_SubTitle_1"
let REPAYMENT_GRAPH_1_SUBTITLE_2   = "Repayment_Graph_1_SubTitle_2"

// Repayment Graph 2 title
let REPAYMENT_GRAPH_2_TITLE        = "Repayment_Graph_2_Title"
let REPAYMENT_GRAPH_2_SUBTITLE     = "Repayment_Graph_2_SubTitle"
let REPAYMENT_GRAPH_2_INTEREST     = "Repayment_Graph_2_Interest"
// Repayment Graph 3 extra title
let REPAYMENT_GRAPH_3_EXTRA        = "Repayment_Graph_3_Extra"
let REPAYMENT_GRAPH_3_ORIGINAL     = "Repayment_Graph_3_Original"
let REPAYMENT_GRAPH_3_AFTEREXTRA   = "Repayment_Graph_3_AfterExtra"

// Repayment Graph 3 ExtraView title
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_1  = "Repayment_Graph_3_ExtraView_Title_1"
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_2  = "Repayment_Graph_3_ExtraView_Title_2"

let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_MIN_MONTH      = "Repayment_Graph_3_ExtraView_Title_Min_Month"
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_INC_MONTH      = "Repayment_Graph_3_ExtraView_Title_Inc_Month"
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_MIN_FORTNIGHT  = "Repayment_Graph_3_ExtraView_Title_Min_Fortnight"
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_INC_FORTNIGHT  = "Repayment_Graph_3_ExtraView_Title_Inc_Fortnight"
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_MIN_WEEK       = "Repayment_Graph_3_ExtraView_Title_Min_Week"
let REPAYMENT_GRAPH_3_EXTRAVIEW_TITLE_INC_WEEK       = "Repayment_Graph_3_ExtraView_Title_Inc_Week"

let REPAYMENT_EMAIL                = "Repayment_email"
let REPAYMENT_EMAIL_TITLE          = "Repayment_email_title"
let REPAYMENT_EMAIL_RESULT         = "Repayment_email_result"
let REPAYMENT_EMAIL_TOTALCOST      = "Repayment_email_totalcost"
let REPAYMENT_EMAIL_TOTALINTEREST  = "Repayment_email_totalinterest"
// StampDuty 标题
let STAMPDUTY_TITLE_1  = "StampDuty_Title_1"
let STAMPDUTY_TITLE_2  = "StampDuty_Title_2"
let STAMPDUTY_TITLE_3  = "StampDuty_Title_3"
let STAMPDUTY_TITLE_4  = "StampDuty_Title_4"

// Stamp Duty pickerstate选项缩写
let STAMPDUTY_PICKER_1  = "StampDuty_Picker_1"
let STAMPDUTY_PICKER_2  = "StampDuty_Picker_2"
let STAMPDUTY_PICKER_3  = "StampDuty_Picker_3"
let STAMPDUTY_PICKER_4  = "StampDuty_Picker_4"
let STAMPDUTY_PICKER_5  = "StampDuty_Picker_5"
let STAMPDUTY_PICKER_6  = "StampDuty_Picker_6"
let STAMPDUTY_PICKER_7  = "StampDuty_Picker_7"
let STAMPDUTY_PICKER_8  = "StampDuty_Picker_8"

// Stamp Duty pickerstate选项全称
let STAMPDUTY_PICKER_FULL_1  = "StampDuty_Picker_Full_1"
let STAMPDUTY_PICKER_FULL_2  = "StampDuty_Picker_Full_2"
let STAMPDUTY_PICKER_FULL_3  = "StampDuty_Picker_Full_3"
let STAMPDUTY_PICKER_FULL_4  = "StampDuty_Picker_Full_4"
let STAMPDUTY_PICKER_FULL_5  = "StampDuty_Picker_Full_5"
let STAMPDUTY_PICKER_FULL_6  = "StampDuty_Picker_Full_6"
let STAMPDUTY_PICKER_FULL_7  = "StampDuty_Picker_Full_7"
let STAMPDUTY_PICKER_FULL_8  = "StampDuty_Picker_Full_8"

// Stamp Duty 图表1
let STAMPDUTY_GRAPH_1_SUBTITLE            = "StampDuty_Graph_1_SubTitle"
let STAMPDUTY_GRAPH_1_STAMPDUTY           = "StampDuty_Graph_1_StampDuty"
let STAMPDUTY_GRAPH_1_TRANSFERFEE         = "StampDuty_Graph_1_TransferFee"
let STAMPDUTY_GRAPH_1_REGISTRATION        = "StampDuty_Graph_1_Registration"
let STAMPDUTY_GRAPH_1_TOTAL               = "StampDuty_Graph_1_Total"
let STAMPDUTY_GRAPH_1_CONCESSION          = "StampDuty_Graph_1_Concession"
let STAMPDUTY_GRAPH_1_DISCLAIMER          = "StampDuty_Graph_1_Disclaimer"
let STAMPDUTY_GRAPH_1_DISCLAIMER_CONTENT  = "StampDuty_Graph_1_Disclaimer_Content"

// Stamp Duty 图表2
let STAMPDUTY_GRAPH_2_SUBTITLE  = "StampDuty_Graph_2_SubTitle"

let STAMPDUTY_EMAIL               = "StampDuty_Email"
let STAMPDUTY_EMAIL_SUBTITLE      = "StampDuty_Email_SubTitle"
let STAMPDUTY_EMAIL_PRICE         = "StampDuty_Email_Price"
let STAMPDUTY_EMAILGOVERMENTFEES  = "StampDuty_Email_GovermentFees"
// checklist 标题
let CHECKLIST_TITLE_1  = "Checklist_Title_1"
let CHECKLIST_TITLE_2  = "Checklist_Title_2"
let CHECKLIST_TITLE_3  = "Checklist_Title_3"

//  checklist home 标题
let CHECKLIST_HOME_TITLE_1  = "Checklist_Home_Title_1"
let CHECKLIST_HOME_TITLE_2  = "Checklist_Home_Title_2"
let CHECKLIST_HOME_TITLE_3  = "Checklist_Home_Title_3"
let CHECKLIST_HOME_TITLE_4  = "Checklist_Home_Title_4"
let CHECKLIST_HOME_TITLE_5  = "Checklist_Home_Title_5"

// checklist home select
let CHECKLIST_HOME_SELECT_1_1  = "Checklist_Home_Select_1_1"
let CHECKLIST_HOME_SELECT_1_2  = "Checklist_Home_Select_1_2"
let CHECKLIST_HOME_SELECT_1_3  = "Checklist_Home_Select_1_3"
let CHECKLIST_HOME_SELECT_1_4  = "Checklist_Home_Select_1_4"
let CHECKLIST_HOME_SELECT_1_5  = "Checklist_Home_Select_1_5"
let CHECKLIST_HOME_SELECT_1_6  = "Checklist_Home_Select_1_6"

let CHECKLIST_HOME_SELECT_2_1  = "Checklist_Home_Select_2_1"
let CHECKLIST_HOME_SELECT_2_2  = "Checklist_Home_Select_2_2"
let CHECKLIST_HOME_SELECT_2_3  = "Checklist_Home_Select_2_3"
let CHECKLIST_HOME_SELECT_2_4  = "Checklist_Home_Select_2_4"

let CHECKLIST_HOME_SELECT_3_1  = "Checklist_Home_Select_3_1"
let CHECKLIST_HOME_SELECT_3_2  = "Checklist_Home_Select_3_2"

let CHECKLIST_HOME_SELECT_4_1  = "Checklist_Home_Select_4_1"
let CHECKLIST_HOME_SELECT_4_2  = "Checklist_Home_Select_4_2"
let CHECKLIST_HOME_SELECT_4_3  = "Checklist_Home_Select_4_3"

let CHECKLIST_HOME_SELECT_5_1  = "Checklist_Home_Select_5_1"
let CHECKLIST_HOME_SELECT_5_2  = "Checklist_Home_Select_5_2"
// checklist moving 标题
let CHECKLIST_MOVING_TITLE_1  = "Checklist_Moving_Title_1"
let CHECKLIST_MOVING_TITLE_2  = "Checklist_Moving_Title_2"
let CHECKLIST_MOVING_TITLE_3  = "Checklist_Moving_Title_3"
let CHECKLIST_MOVING_TITLE_4  = "Checklist_Moving_Title_4"
let CHECKLIST_MOVING_TITLE_5  = "Checklist_Moving_Title_5"
let CHECKLIST_MOVING_TITLE_6  = "Checklist_Moving_Title_6"

// checklist moving question
let CHECKLIST_MOVING_QUESTION_1  = "Checklist_Moving_Question_1"
let CHECKLIST_MOVING_QUESTION_2  = "Checklist_Moving_Question_2"
let CHECKLIST_MOVING_QUESTION_3  = "Checklist_Moving_Question_3"
let CHECKLIST_MOVING_QUESTION_4  = "Checklist_Moving_Question_4"
let CHECKLIST_MOVING_QUESTION_5  = "Checklist_Moving_Question_5"
let CHECKLIST_MOVING_QUESTION_6  = "Checklist_Moving_Question_6"


// checklist moving select
let CHECKLIST_MOVING_SELECT_1_1  = "Checklist_Moving_Select_1_1"
let CHECKLIST_MOVING_SELECT_1_2  = "Checklist_Moving_Select_1_2"
let CHECKLIST_MOVING_SELECT_1_3  = "Checklist_Moving_Select_1_3"
let CHECKLIST_MOVING_SELECT_1_4  = "Checklist_Moving_Select_1_4"

let CHECKLIST_MOVING_SELECT_2_1  = "Checklist_Moving_Select_2_1"
let CHECKLIST_MOVING_SELECT_2_2  = "Checklist_Moving_Select_2_2"
let CHECKLIST_MOVING_SELECT_2_3  = "Checklist_Moving_Select_2_3"
let CHECKLIST_MOVING_SELECT_2_4  = "Checklist_Moving_Select_2_4"
let CHECKLIST_MOVING_SELECT_2_5  = "Checklist_Moving_Select_2_5"

let CHECKLIST_MOVING_SELECT_3_1   = "Checklist_Moving_Select_3_1"
let CHECKLIST_MOVING_SELECT_3_2   = "Checklist_Moving_Select_3_2"
let CHECKLIST_MOVING_SELECT_3_3   = "Checklist_Moving_Select_3_3"
let CHECKLIST_MOVING_SELECT_3_4   = "Checklist_Moving_Select_3_4"
let CHECKLIST_MOVING_SELECT_3_5   = "Checklist_Moving_Select_3_5"
let CHECKLIST_MOVING_SELECT_3_6   = "Checklist_Moving_Select_3_6"
let CHECKLIST_MOVING_SELECT_3_7   = "Checklist_Moving_Select_3_7"
let CHECKLIST_MOVING_SELECT_3_8   = "Checklist_Moving_Select_3_8"
let CHECKLIST_MOVING_SELECT_3_9   = "Checklist_Moving_Select_3_9"
let CHECKLIST_MOVING_SELECT_3_10  = "Checklist_Moving_Select_3_10"
let CHECKLIST_MOVING_SELECT_3_11  = "Checklist_Moving_Select_3_11"
let CHECKLIST_MOVING_SELECT_3_12  = "Checklist_Moving_Select_3_12"
let CHECKLIST_MOVING_SELECT_3_13  = "Checklist_Moving_Select_3_13"

let CHECKLIST_MOVING_SELECT_4_1   = "Checklist_Moving_Select_4_1"
let CHECKLIST_MOVING_SELECT_4_2   = "Checklist_Moving_Select_4_2"
let CHECKLIST_MOVING_SELECT_4_3   = "Checklist_Moving_Select_4_3"
let CHECKLIST_MOVING_SELECT_4_4   = "Checklist_Moving_Select_4_4"
let CHECKLIST_MOVING_SELECT_4_5   = "Checklist_Moving_Select_4_5"
let CHECKLIST_MOVING_SELECT_4_6   = "Checklist_Moving_Select_4_6"
let CHECKLIST_MOVING_SELECT_4_7   = "Checklist_Moving_Select_4_7"
let CHECKLIST_MOVING_SELECT_4_8   = "Checklist_Moving_Select_4_8"
let CHECKLIST_MOVING_SELECT_4_9   = "Checklist_Moving_Select_4_9"
let CHECKLIST_MOVING_SELECT_4_10  = "Checklist_Moving_Select_4_10"
let CHECKLIST_MOVING_SELECT_4_11  = "Checklist_Moving_Select_4_11"

let CHECKLIST_MOVING_SELECT_5_1  = "Checklist_Moving_Select_5_1"
let CHECKLIST_MOVING_SELECT_5_2  = "Checklist_Moving_Select_5_2"
let CHECKLIST_MOVING_SELECT_5_3  = "Checklist_Moving_Select_5_3"
let CHECKLIST_MOVING_SELECT_5_4  = "Checklist_Moving_Select_5_4"

let CHECKLIST_MOVING_SELECT_6_1  = "Checklist_Moving_Select_6_1"
let CHECKLIST_MOVING_SELECT_6_2  = "Checklist_Moving_Select_6_2"
let CHECKLIST_MOVING_SELECT_6_3  = "Checklist_Moving_Select_6_3"
let CHECKLIST_MOVING_SELECT_6_4  = "Checklist_Moving_Select_6_4"

// checklist pre-settle 标题
let CHECKLIST_PRESETTLE_TITLE_1  = "Checklist_Presettle_Title_1"
let CHECKLIST_PRESETTLE_TITLE_2  = "Checklist_Presettle_Title_2"

// checklist pre-settle 子标题
let CHECKLIST_PRESETTLE_SUBTITLE_1  = "Checklist_Presettle_SubTitle_1"
let CHECKLIST_PRESETTLE_SUBTITLE_2  = "Checklist_Presettle_SubTitle_2"

// checklist pre-select select
let CHECKLIST_PRESETTLE_SELECT_1_1  = "Checklist_Presettle_Select_1_1"
let CHECKLIST_PRESETTLE_SELECT_1_2  = "Checklist_Presettle_Select_1_2"
let CHECKLIST_PRESETTLE_SELECT_1_3  = "Checklist_Presettle_Select_1_3"
let CHECKLIST_PRESETTLE_SELECT_1_4  = "Checklist_Presettle_Select_1_4"
let CHECKLIST_PRESETTLE_SELECT_1_5  = "Checklist_Presettle_Select_1_5"
let CHECKLIST_PRESETTLE_SELECT_1_6  = "Checklist_Presettle_Select_1_6"
let CHECKLIST_PRESETTLE_SELECT_1_7  = "Checklist_Presettle_Select_1_7"

let CHECKLIST_PRESETTLE_SELECT_2_1  = "Checklist_Presettle_Select_1_1"
let CHECKLIST_PRESETTLE_SELECT_2_2  = "Checklist_Presettle_Select_2_2"
let CHECKLIST_PRESETTLE_SELECT_2_3  = "Checklist_Presettle_Select_2_3"
let CHECKLIST_PRESETTLE_SELECT_2_4  = "Checklist_Presettle_Select_2_4"
let CHECKLIST_PRESETTLE_SELECT_2_5  = "Checklist_Presettle_Select_2_5"
let CHECKLIST_PRESETTLE_SELECT_2_6  = "Checklist_Presettle_Select_2_6"
let CHECKLIST_PRESETTLE_SELECT_2_7  = "Checklist_Presettle_Select_2_7"

// contact us 标题
let CONTACTUS_TITLE_1  = "ContactUs_Title_1"
let CONTACTUS_TITLE_2  = "ContactUs_Title_2"
let CONTACTUS_TITLE_3  = "ContactUs_Title_3"
let CONTACTUS_TITLE_4  = "ContactUs_Title_4"

// contact us 标题栏内容
let CONTACTUS_CONTENT_1  = "ContactUs_Content_1"
let CONTACTUS_CONTENT_2  = "ContactUs_Content_2"
let CONTACTUS_CONTENT_3  = "ContactUs_Content_3"

// contact us 地图界面标题
let CONTACTUS_MAP_TITLE_1  = "ContactUs_Map_Title_1"
let CONTACTUS_MAP_TITLE_2  = "ContactUs_Map_Title_2"
let CONTACTUS_MAP_TITLE_3  = "ContactUs_Map_Title_3"

// contact us 地图界面电话
let CONTACTUS_MAP_PHONE_1  = "ContactUs_Map_Phone_1"
let CONTACTUS_MAP_PHONE_2  = "ContactUs_Map_Phone_2"
let CONTACTUS_MAP_PHONE_3  = "ContactUs_Map_Phone_3"

// contact us 地图界面地址
let CONTACTUS_MAP_ADDRESS_1  = "ContactUs_Map_Address_1"
let CONTACTUS_MAP_ADDRESS_2  = "ContactUs_Map_Address_2"
let CONTACTUS_MAP_ADDRESS_3  = "ContactUs_Map_Address_3"
