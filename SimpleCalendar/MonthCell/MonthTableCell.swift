//
//  MonthTableCell.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal class MonthTableCell: UITableViewCell {

    public let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = UI.getItemSize()
        flowLayout.minimumInteritemSpacing = 1.0
        flowLayout.minimumLineSpacing = 1.0
        flowLayout.scrollDirection = .vertical
        let topInset = CalendarRatio.standard.scaled(size: 7, accordingTo: .height)
        flowLayout.sectionInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    public weak var delegate: MonthTableDelegate?
    
    public let cellIdentifier = "DayComponentCollectionViewCell"
    
    public weak var config: CalendarCellConfig?
    
    public weak var container: MonthDataContainer?
    
    public let model = MonthTableCellModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(config: CalendarCellConfig?, andRecyclable container: MonthDataContainer?) {
        self.config = config
        self.container = container
        collectionView.reloadData()
    }
    
    private func initSubviews() {
        collectionView.register(ComponentCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        
        setSubviewsConstriants()
    }
    
    private func setSubviewsConstriants() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.collectionViewLeadingSpace),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UI.collectionViewTrailingSpace),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UI.collectionViewBottomSpace)
            ])
    }
    
    public static var viewHeight: CGFloat {
        return UI.collectionViewHeight
    }
}

fileprivate extension MonthTableCell {
    
    struct UI {
        static let collectionViewLeadingSpace = CalendarRatio.standard.scaled(size: 24, accordingTo: .width)
        static let collectionViewTrailingSpace = CalendarRatio.standard.scaled(size: 23, accordingTo: .width)
        static let collectionViewBottomSpace = CalendarRatio.standard.scaled(size: 26, accordingTo: .height)
        
        static func getItemSize() -> CGSize {
            let itemsSpace: CGFloat = 6.0
            let width = UIScreen.main.bounds.width - collectionViewLeadingSpace - collectionViewTrailingSpace
            let length = (width - itemsSpace)/7
            return CGSize(width: length, height: length)
        }
        
        static var collectionViewHeight: CGFloat {
            let itemSize = getItemSize()
            let collectionHeight = itemSize.height * 7
            return collectionHeight
        }
    }
    
}
