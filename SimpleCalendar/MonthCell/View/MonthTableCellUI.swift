//
//  MonthTableCellUI.swift
//  SimpleCalendar
//
//  Created by Bilal Bakhrom on 20/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal protocol MonthTableCellUI: AppUIDelegate {
    var collectionView: UICollectionView! {get set}
    
    static func viewHeight() -> CGFloat
}


extension MonthTableCellUI {
    
    func setupUI(for view: UIView) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = UI.getItemSize()
        flowLayout.minimumInteritemSpacing = 1.0
        flowLayout.minimumLineSpacing = 1.0
        flowLayout.scrollDirection = .vertical
        let topInset = CalendarRatio.standard.scaled(size: 7, accordingTo: .height)
        flowLayout.sectionInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        
        addSubviews(into: view)
    }
    
    func addSubviews(into view: UIView) {        
        view.addSubview(collectionView)
        setSubviewsConstraints(for: view)
    }
    
    func setSubviewsConstraints(for view: UIView) {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UI.collectionViewLeadingSpace),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UI.collectionViewTrailingSpace),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: UI.collectionViewBottomSpace)
            ])
    }
    
    static func viewHeight() -> CGFloat {
        return UI.collectionViewHeight
    }
}



fileprivate struct UI {
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
        return collectionHeight + collectionViewBottomSpace
    }
}
