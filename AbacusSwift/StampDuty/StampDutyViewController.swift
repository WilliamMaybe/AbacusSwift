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
    
    private lazy var tableView: UITableView = {
        let lazyTableView = UITableView(frame: CGRect.zero, style: .Grouped)
        lazyTableView.bounces = false
        lazyTableView.delegate = self
        lazyTableView.dataSource = self
        return lazyTableView
    }()
    
    private lazy var pickerView: PickerStateView = {
        let lazyPickerView = PickerStateView()
        lazyPickerView.selectedIndex { (index) -> Void in
            self.stateChanged(index)
        }
        return lazyPickerView
    }()
    
    private lazy var pickerTitle     = stampDutyPickerTitleArray(false)
    private lazy var pickerFullTitle = stampDutyPickerTitleArray(true)
    
    private lazy var scrollView: UIScrollView = {
        let lazyScroll = UIScrollView()
        lazyScroll.pagingEnabled = true
        lazyScroll.showsHorizontalScrollIndicator = false
        lazyScroll.showsVerticalScrollIndicator = false
        lazyScroll.delegate = self
        lazyScroll.backgroundColor = UIColor.themeGray()
        return lazyScroll
    }()
    
    private lazy var pageControl: UIPageControl = {
        let lazyPageControl = UIPageControl()
        lazyPageControl.numberOfPages = 2
        lazyPageControl.pageIndicatorTintColor = UIColor.themeLightGreen()
        lazyPageControl.currentPageIndicatorTintColor = UIColor.themeGreen()
        return lazyPageControl
    }()
    
    private lazy var detailView: StampDutyDetailView         = StampDutyDetailView()
    private lazy var comparisonView: StampDutyComparisonView = StampDutyComparisonView()
    
    /// 选中的省份Index(初始化为0)
    private var selectedStateIndex = 0
    /// 初始价格
    private var propertyValue: Double = 600_000
    /// 是否自住
    private var isLiveIn = true
    
    private var bottomConstraint :Constraint?
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = localStringFromKey(STAMPDUTY)
        navigationItem.leftBarButtonItem  = UIBarButtonItem(title: localStringFromKey(RESET), style: .Plain, target: self, action: #selector(StampDutyViewController.clickToReset))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(StampDutyViewController.clickToMail))
        
        initComponents()
    }
    
    private func initComponents() {
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(view)
            make.height.equalTo(3 * tableView(tableView, heightForRowAtIndexPath: NSIndexPath()))
        }
        
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(tableView.snp_bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
        }
        
        view.addSubview(pageControl)
        pageControl.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
        }
        
        scrollView.addSubview(detailView)
        detailView.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(scrollView)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
            make.width.equalTo(view)
        }
        
        scrollView.addSubview(comparisonView)
        comparisonView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(detailView.snp_right)
            make.width.bottom.top.equalTo(detailView)
            make.right.equalTo(scrollView)
        }
        
        calculator()
        
        view.addSubview(pickerView)
        pickerView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(view)
            bottomConstraint = make.top.equalTo(self.snp_bottomLayoutGuideBottom).constraint
        }
    }
    
// MARK: - Button Click
    @objc private func clickToReset() {
        
    }
    
    @objc private func clickToMail() {
        
    }
    
// MARK: - Private Method
    private func cellAtIndex(index:Int) -> UITableViewCell? {
        
        struct cells {
            static var firstCell: UITableViewCell?
            static var secondCell: TextFieldTableViewCell?
            static var thirdCell: SwitchTableViewCell?
        }
        
        switch index {
        case 0:
            var cell = cells.firstCell
            if (cell == nil) {
                cell = UITableViewCell(style: .Value1, reuseIdentifier: nil)
                cell?.textLabel?.textColor = UIColor.themeGreen()
                cell?.textLabel?.text = localStringFromKey(STAMPDUTY_TITLE_1)
                cell?.detailTextLabel?.textColor = UIColor.themeGreen()
                cell?.detailTextLabel?.font = UIFont.font_hn_light(15)
            }
            return cell
            
        case 1:
            var cell = cells.secondCell
            if (cell == nil) {
                cell = TextFieldTableViewCell(style: .Default, reuseIdentifier: nil)
                cell?.titleLabel.text = localStringFromKey(STAMPDUTY_TITLE_2)
            }
            return cell
            
        case 2:
            var cell = cells.thirdCell
            if (cell == nil) {
                cell = SwitchTableViewCell(style: .Default, reuseIdentifier: nil)
                cell?.textLabel?.text = localStringFromKey(STAMPDUTY_TITLE_3)
            }
            return cell
            
        default: return nil
        }
    }
    
    private func switchClicked() {
        isLiveIn = !isLiveIn
        tableView .reloadRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: .None)
        calculator()
    }
    private func money(money: Double) {
        propertyValue = money;
        calculator()
    }
    
    private func stateChanged(index: Int) {
        bottomConstraint?.updateOffset(0)
        UIView.animateWithDuration(0.5) { () -> Void in
            self.view.layoutIfNeeded()
        }
        selectedStateIndex = index
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .None)
        calculator()
    }
    
    private func calculator() {
        let selectedModel = stampDutyModel()
        selectedModel.type = stampDutyType(rawValue: selectedStateIndex)!
        selectedModel.money = propertyValue
        selectedModel.isLive = isLiveIn
        
        detailView.setDataWithModel(handleMoney(selectedModel))
        comparisonView.setDataWithModel(selectedModel)
    }
}

// MARK: - UITableView Delegate & DataSource
extension StampDutyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 0.01}
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 0.01}
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat { return 45}
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: AnyObject
        
        cell = cellAtIndex(indexPath.row)!
        switch indexPath.row {
            case 0:
                cell.detailTextLabel??.text = pickerTitle[selectedStateIndex]
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 0:
            view.endEditing(true)
            bottomConstraint?.updateOffset(-CGRectGetHeight(pickerView.frame))
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        case 2:
            switchClicked()
        default:break
        }
    }
// MARK: - UIScrollView Delegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        pageControl.currentPage = (Int)(scrollView.contentOffset.x / CGRectGetWidth(view.frame))
    }
}