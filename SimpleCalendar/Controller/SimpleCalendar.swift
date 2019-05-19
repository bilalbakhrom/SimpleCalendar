//
//  SimpleCalendar.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

open class SimpleCalendar: UIViewController, SimpleCalendarUI {
    
    internal var tableView: UITableView!
    
    internal var headerView: CalendarHeaderView!
    
    internal var calendarConfig: CalendarConfig
    
    internal let cellIdentifier = "MonthCompenentTableViewCell"
    
    internal let model = SimpleCalendarModel()
    
    open weak var delegate: SimpleCalendarDelegate?
    
    open override var prefersStatusBarHidden: Bool {
        return calendarConfig.prefersStatusBarHidden
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return calendarConfig.preferredStatusBarStyle
    }
    
    public init(calendarConfig: CalendarConfig) {
        self.calendarConfig = calendarConfig
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(_ completion: @escaping (CalendarConfig) -> Void) {
        calendarConfig = CalendarConfig()
        completion(calendarConfig)
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.setStatusViewBackgroundColor(calendarConfig.barBackgroundColor)
        
        if let delegate = self.delegate {
            model.updateComponents(withSelectedDates: delegate.simpleCalendar())
            tableView.reloadData()
        } else {
            CalendarManager.shared.numberOfSelectedCells = 0
        }
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.setStatusViewBackgroundColor(.clear)
    }
    
    open func reloadData() {
        tableView.reloadData()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()        
        
        headerView = CalendarHeaderView(controller: self)
        setupUI(for: view)
        
        tableView.register(MonthTableCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        model.configure(with: calendarConfig)
    }
    
    @objc private func closeCalendar() {
        if isPresented {
            dismiss(animated: true, completion: nil)
        } else if isPushed {
            navigationController?.popViewController(animated: true)
        }
    }
}


extension SimpleCalendar: MonthTableDelegate {
    
    internal func monthTable(selectedDates dates: [Date]) {
        for date in dates {
            let dateString = CalendarManager.shared.dateFormatter.string(from: date)
            model.selectedDatesDictionary[dateString] = date
        }
        
        delegate?.simpleCalendar(selectedDates: model.getSelectedDates())
        
        if calendarConfig.shouldCloseIfLimitReached, CalendarManager.shared.isLimitReached {
            closeCalendar()
        }
    }
    
    internal func monthTable(deselectedDate date: Date) {
        let dateString = CalendarManager.shared.dateFormatter.string(from: date)
        model.selectedDatesDictionary[dateString] = nil
    }
}
