//
//  ComponentCell.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal class ComponentCell: UICollectionViewCell, ComponentCellUI {
    
    internal var titleLabel: UILabel!
    
    internal var circleView: UIView!
    
    private weak var config: CalendarCellConfig?
    
    private weak var model: ComponentModel?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI(for: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func set(config: CalendarCellConfig?, andModel model: ComponentModel?) {
        self.config = config
        self.model = model
        configure()
    }
    
    private func updateCell(selected: Bool) {
        guard let config = self.config else { return }
        guard let model = self.model else { return }
        
        if model.state == .day {
         
            if config.disableSelectionOfPassedDates, model.isOutOfDate {
                
                /// Set Backgorund Color
                if config.dayCellSelectionStyle == .circle {
                    circleView.backgroundColor = config.passedDatesBackgroundColor
                } else {
                    backgroundColor = config.passedDatesBackgroundColor
                }
                
                titleLabel.textColor = config.passedDatesTitleColor
                titleLabel.font = config.passedDatesFont
                
            } else {
                let color = (selected) ? config.selectedDayCellBackgroundColor : config.dayCellBackgroundColor
                let textColor = (selected) ? config.selectedCellTitleColor : config.dayCellTitleColor
                
                /// Set Backgorund Color
                if config.dayCellSelectionStyle == .circle {
                    circleView.backgroundColor = (selected) ? color : .clear
                } else {
                    backgroundColor = color
                }
                
                titleLabel.textColor = textColor
            }
        }
    }
    
    private func configure() {
        guard let config = self.config else { return }
        guard let model = self.model  else { return }
        
        switch model.state {
        case .weekday:
            backgroundColor = config.weekdayCellBackgroundColor
            titleLabel.textColor = config.weekdayCellTitleColor
            titleLabel.font = config.weekdayCellTitleFont
            titleLabel.text = model.weekdaySymbol
            titleLabel.sizeToFit()
            
        case .day:
            titleLabel.textColor = config.dayCellTitleColor
            titleLabel.font = config.dayCellTitleFont
            titleLabel.text = (model.day ?? 0).str
            titleLabel.sizeToFit()
            
        case .none:
            backgroundColor = .clear
            titleLabel.text = ""
        }
    
        updateCell(selected: model.isSelected)
    }
}
