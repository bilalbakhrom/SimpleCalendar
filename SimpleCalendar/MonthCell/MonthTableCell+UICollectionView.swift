//
//  MonthTableCell+UICollectionView.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 18/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

extension MonthTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return container?.components.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ComponentCell
        let component = container?.components[indexPath.row]
        component?.componentDelegate = self
        cell.set(config: config, andModel: component)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let component = container?.components[indexPath.row] else { return }
        guard let config = self.config else { return }
        if config.disableSelectionOfPassedDates, component.isOutOfDate {
            // ignore
        } else {
            updateCellSelection(with: component, at: indexPath)
        }
    }
    
    private func updateCellSelection(with component: ComponentModel, at indexPath: IndexPath) {
        let numberOfSelectedCells = CalendarManager.shared.numberOfSelectedCells
        
        if CalendarManager.shared.isLimitReached {
            if component.isSelected {
                CalendarManager.shared.numberOfSelectedCells = numberOfSelectedCells-1
                component.isSelected.toggle()
                collectionView.reloadItems(at: [indexPath])
            }
        } else {
            CalendarManager.shared.numberOfSelectedCells = (!component.isSelected) ? numberOfSelectedCells+1 : numberOfSelectedCells-1
            component.isSelected.toggle()
            collectionView.reloadItems(at: [indexPath])
        }
        
    }
    
}

extension MonthTableCell: ComponentDelegate {
    
    func component(isSelected: Bool, date: Date) {
        let dateString = CalendarManager.shared.dateFormatter.string(from: date)
        model.selectedDatesDictionary[dateString] = (isSelected) ? date : nil
        
        if !isSelected {
            delegate?.monthTable(deselectedDate: date)
        }
        
        delegate?.monthTable(selectedDates: model.getSelectedDates())
    }
    
}
