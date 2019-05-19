//
//  MonthTableCell.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal class MonthTableCell: UITableViewCell, MonthTableCellUI {
    
    internal var collectionView: UICollectionView!
    
    internal weak var delegate: MonthTableDelegate?
    
    internal let cellIdentifier = "DayComponentCollectionViewCell"
    
    internal weak var config: CalendarCellConfig?
    
    internal weak var container: MonthDataContainer?
    
    internal let model = MonthTableCellModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI(for: self)
        configureCollection()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func set(config: CalendarCellConfig?, andRecyclable container: MonthDataContainer?) {
        self.config = config
        self.container = container
        collectionView.reloadData()
    }
    
    private func configureCollection() {
        collectionView.register(ComponentCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
