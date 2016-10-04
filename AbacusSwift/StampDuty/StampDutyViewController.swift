//
//  StampDutyViewController.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  印花税主页

import UIKit
import SnapKit

class StampDutyViewController: BaseViewController {
    
    fileprivate lazy var tableView: UITableView = {
        let lazyTableView = UITableView(frame: CGRect.zero, style: .grouped)
        lazyTableView.bounces = false
        lazyTableView.delegate = self
        lazyTableView.dataSource = self
        return lazyTableView
    }()
    
    fileprivate lazy var pickerView: PickerStateView = {
        let lazyPickerView = PickerStateView(pickers: self.stampdutyEnum)
        lazyPickerView.selectedIndex { (index) -> Void in
            self.stateChanged(index)
        }
        return lazyPickerView
    }()
    
    fileprivate var stampdutyEnum = [stampDutyType.act(stampDutyModel()),
                                 .nsw(stampDutyModel()),
                                 .nt(stampDutyModel()),
                                 .qld(stampDutyModel()),
                                 .sa(stampDutyModel()),
                                 .tas(stampDutyModel()),
                                 .vic(stampDutyModel()),
                                 .wa(stampDutyModel())
                                ]
    
    fileprivate lazy var scrollView: UIScrollView = {
        let lazyScroll = UIScrollView()
        lazyScroll.isPagingEnabled = true
        lazyScroll.showsHorizontalScrollIndicator = false
        lazyScroll.showsVerticalScrollIndicator = false
        lazyScroll.delegate = self
        lazyScroll.backgroundColor = UIColor.themeGray()
        return lazyScroll
    }()
    
    fileprivate lazy var pageControl: UIPageControl = {
        let lazyPageControl = UIPageControl()
        lazyPageControl.numberOfPages = 2
        lazyPageControl.pageIndicatorTintColor = UIColor.themeLightGreen()
        lazyPageControl.currentPageIndicatorTintColor = UIColor.themeGreen()
        return lazyPageControl
    }()
    
    fileprivate lazy var detailView: StampDutyDetailView         = StampDutyDetailView()
    fileprivate lazy var comparisonView: StampDutyComparisonView = {
        return StampDutyComparisonView(lineCount: self.stampdutyEnum.count)
    }()
    
    /// 选中的省份Index(初始化为0)
    fileprivate lazy var selectedIndex = 0
    /// 初始价格
    fileprivate var propertyValue: Double = 600_000
    /// 是否自住
    fileprivate var isLiveIn = true
    
    fileprivate var bottomConstraint :Constraint?
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = STAMPDUTY()
        navigationItem.leftBarButtonItem  = UIBarButtonItem(title: RESET(), style: .plain, target: self, action: #selector(StampDutyViewController.clickToReset))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(StampDutyViewController.clickToMail))
        
        initComponents()
    }
    
    fileprivate func initComponents() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(view)
            make.height.equalTo(3 * tableView(tableView, heightForRowAt: IndexPath()))
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(tableView.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
        scrollView.addSubview(detailView)
        detailView.snp.makeConstraints { (make) -> Void in
            make.left.top.equalTo(scrollView)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
            make.width.equalTo(view)
        }
        
        scrollView.addSubview(comparisonView)
        comparisonView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(detailView.snp.right)
            make.width.bottom.top.equalTo(detailView)
            make.right.equalTo(scrollView)
        }
        
        calculator()
        
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(view)
            bottomConstraint = make.top.equalTo(bottomLayoutGuide.snp.bottom).constraint
        }
    }
    
// MARK: - Button Click
    @objc fileprivate func clickToReset() {
        
    }
    
    @objc fileprivate func clickToMail() {
        
    }
    
// MARK: - Private Method
    fileprivate func cellAtIndex(_ index:Int) -> UITableViewCell? {
        
        struct cells {
            static var firstCell: UITableViewCell?
            static var secondCell: TextFieldTableViewCell?
            static var thirdCell: SwitchTableViewCell?
        }
        
        switch index {
        case 0:
            var cell = cells.firstCell
            if (cell != nil) { return cell }
            
            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell?.textLabel?.textColor = UIColor.themeGreen()
            cell?.textLabel?.text = STAMPDUTY_TITLE_1()
            cell?.detailTextLabel?.textColor = UIColor.themeGreen()
            cell?.detailTextLabel?.font = UIFont.font_hn_light(15)
            
            return cell
            
        case 1:
            var cell = cells.secondCell
            if (cell == nil) {
                cell = TextFieldTableViewCell(style: .default, reuseIdentifier: nil)
                cell?.titleLabel.text = STAMPDUTY_TITLE_2()
            }
            return cell
            
        case 2:
            var cell = cells.thirdCell
            if (cell == nil) {
                cell = SwitchTableViewCell(style: .default, reuseIdentifier: nil)
                cell?.textLabel?.text = STAMPDUTY_TITLE_3()
            }
            return cell
            
        default: return nil
        }
    }
    
    fileprivate func switchClicked() {
        isLiveIn = !isLiveIn
        tableView .reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)
        calculator()
    }
    fileprivate func money(_ money: Double) {
        propertyValue = money;
        calculator()
    }
    
    fileprivate func stateChanged(_ index: Int) {
        bottomConstraint?.update(offset: 0)
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }) 
        selectedIndex = index
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        calculator()
    }
    
    fileprivate func calculator() {
        stampdutyEnum.forEach { (body) in
            var tmp = body
            tmp.money  = propertyValue
            tmp.isLive = isLiveIn
            tmp.calculate()
        }
        
        detailView.setData(stampdutyEnum[selectedIndex])
        comparisonView.setDatas(stampdutyEnum, selectedAtIndex: selectedIndex)
    }
}

// MARK: - UITableView Delegate & DataSource
extension StampDutyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 0.01}
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 0.01}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 45}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: AnyObject
        
        cell = cellAtIndex((indexPath as NSIndexPath).row)!
        switch (indexPath as NSIndexPath).row {
            case 0:
                cell.detailTextLabel??.text = stampdutyEnum[selectedIndex].pickerTitle
            case 1:
                (cell as! TextFieldTableViewCell).setTextFieldText("$600,000")
                (cell as! TextFieldTableViewCell).textFinished({ (money) -> Void in
                    self.money(money)
                })
            case 2:
                (cell as! SwitchTableViewCell).switchOn(isLiveIn)
                (cell as! SwitchTableViewCell).switchDidClicked({ () -> Void in
                    self.switchClicked()
                })
            default:break
        }
        
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        switch (indexPath as NSIndexPath).row {
        case 0:
            view.endEditing(true)
            bottomConstraint?.update(offset: -pickerView.frame.height)
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        case 2:
            switchClicked()
        default:break
        }
    }
// MARK: - UIScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = (Int)(scrollView.contentOffset.x / view.frame.width)
    }
}
