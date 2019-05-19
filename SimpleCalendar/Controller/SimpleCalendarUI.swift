//
//  SimpleCalendarUI.swift
//  SimpleCalendar
//
//  Created by Bilal Bakhrom on 20/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import Foundation

internal protocol SimpleCalendarUI: AppUIDelegate {
    var tableView: UITableView! { get set }
    var headerView: CalendarHeaderView! { get set}
    var calendarConfig: CalendarConfig {get set}
}

internal extension SimpleCalendarUI {
    
    func setupUI(for view: UIView) {
        CalendarManager.shared.locale = calendarConfig.locale
        CalendarManager.shared.selectionLimit = calendarConfig.selectionLimit
        
        view.backgroundColor = calendarConfig.backgroundColor
        
        tableView.backgroundColor = calendarConfig.backgroundColor
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        headerView.set(config: calendarConfig)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(into: view)
    }
    
    func addSubviews(into view: UIView) {
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        setSubviewsConstraints(for: view)
    }
    
    func setSubviewsConstraints(for view: UIView) {
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
    
}
