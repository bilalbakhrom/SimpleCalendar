//
//  SimpleCalendar.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

open class SimpleCalendar: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var headerView: CalendarHeaderView = {
        let cview = CalendarHeaderView(controller: self)
        cview.set(config: self.calendarConfig)
        cview.translatesAutoresizingMaskIntoConstraints = false
        return cview
    }()
    
    private let cellIdentifier = "MonthCompenentTableViewCell"
    private let model = SimpleCalendarModel()    
    private let calendarConfig: CalendarConfig
    
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
        guard let delegate = self.delegate else { return }
        model.updateComponents(withSelectedDates: delegate.simpleCalendar())
        tableView.reloadData()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        guard let statusBarView = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {
            return
        }
        statusBarView.backgroundColor = .clear
    }
    
    open func reloadData() {
        tableView.reloadData()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        CalendarManager.shared.locale = calendarConfig.locale
        CalendarManager.shared.selectionLimit = calendarConfig.selectionLimit
        CalendarManager.shared.numberOfSelectedCells = 0
        
        initSubviews()
        
        model.configure(with: calendarConfig)
    }


    private func initSubviews() {
        view.backgroundColor = calendarConfig.backgroundColor
        tableView.backgroundColor = calendarConfig.backgroundColor
        tableView.register(MonthTableCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubview(headerView)
        addSubview(tableView)
        
        setSubviewsConstraints()
    }
    
    
    private func setSubviewsConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.compatibleSafeArea.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerView.viewHeight),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.compatibleSafeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    @objc private func closeCalendar() {
        if isPresented {
            dismiss(animated: true, completion: nil)
        } else if isPushed {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension SimpleCalendar: UITableViewDataSource, UITableViewDelegate, MonthTableDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return model.monthContainers.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MonthTableCell
        let container = model.monthContainers[indexPath.section]
        cell.set(config: calendarConfig.cellConfig, andRecyclable: container)
        cell.delegate = self
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MonthTableCell.viewHeight // Ratio.standard.scaled(size: 360, accordingTo: .height)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CalendarRatio.standard.scaled(size: 34, accordingTo: .height)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = UIScreen.main.bounds.width
        let x = CalendarRatio.standard.scaled(size: 16, accordingTo: .width)
        let h = CalendarRatio.standard.scaled(size: 34, accordingTo: .height)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: h))
        let headerLabel = UILabel(frame: CGRect(x: x, y: 0, width: width - 2*x, height: h))
        
        headerLabel.text = model.monthContainers[section].header
        headerLabel.textColor = calendarConfig.headerConfig.sectionHeaderTextColor
        headerLabel.font = calendarConfig.headerConfig.sectionHeaderFont
        headerView.backgroundColor = calendarConfig.headerConfig.sectionHeaderBackgrounColor
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    public func monthTable(selectedDates dates: [Date]) {
        for date in dates {
            let dateString = CalendarManager.shared.dateFormatter.string(from: date)
            model.selectedDatesDictionary[dateString] = date
        }
        
        delegate?.simpleCalendar(selectedDates: model.getSelectedDates())
        
        if calendarConfig.shouldCloseIfLimitReached, CalendarManager.shared.isLimitReached {
            closeCalendar()
        }
    }
    
    public func monthTable(deselectedDate date: Date) {
        let dateString = CalendarManager.shared.dateFormatter.string(from: date)
        model.selectedDatesDictionary[dateString] = nil
    }
}
