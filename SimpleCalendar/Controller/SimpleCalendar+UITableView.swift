//
//  SimpleCalendar+UITableView.swift
//  SimpleCalendar
//
//  Created by Bilal Bakhrom on 20/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

extension SimpleCalendar: UITableViewDataSource, UITableViewDelegate {
    
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
        return MonthTableCell.viewHeight()
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return calendarConfig.headerConfig.sectionHeaderHeight
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
}
