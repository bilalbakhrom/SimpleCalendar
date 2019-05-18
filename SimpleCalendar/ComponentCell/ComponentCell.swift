//
//  ComponentCell.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 17/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal class ComponentCell: UICollectionViewCell {
 
    private var titleLabel: UILabel!
    
    private weak var config: CalendarCellConfig?
    
    private weak var model: ComponentModel?
    
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func set(config: CalendarCellConfig?, andModel model: ComponentModel?) {
        self.config = config
        self.model = model
        configure()
    }
    
    private func initSubviews() {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circleView)
        addSubview(titleLabel)
        
        setSubviewConstraints()
    }
    
    private func setSubviewConstraints() {
        NSLayoutConstraint.activate([
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.widthAnchor.constraint(equalToConstant: UI.circularViewSize.width),
            circleView.heightAnchor.constraint(equalToConstant: UI.circularViewSize.height),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        
        circleView.layer.cornerRadius = UI.circularViewSize.height/2
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
                
                if let attributedText = config.passedDatesAttributedText {
                    titleLabel.attributedText = attributedText
                } else {
                    titleLabel.textColor = config.passedDatesTitleColor
                    titleLabel.font = config.passedDatesFont
                }
                
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
            if let attributedText = config.weekdayAttributedText {
                titleLabel.attributedText = attributedText
            } else {
                titleLabel.textColor = config.weekdayCellTitleColor
                titleLabel.font = config.weekdayCellTitleFont
                titleLabel.text = model.weekdaySymbol
            }
            titleLabel.sizeToFit()
            
        case .day:
            
            if let attributedText = config.dayAttributedText {
                titleLabel.attributedText = attributedText
            } else {
                titleLabel.textColor = config.dayCellTitleColor
                titleLabel.font = config.dayCellTitleFont
                titleLabel.text = (model.day ?? 0).str
            }
            titleLabel.sizeToFit()
            
        case .none:
            backgroundColor = .clear
            titleLabel.text = ""
        }
    
        updateCell(selected: model.isSelected)
    }
}

fileprivate extension ComponentCell {
    
    struct UI {
        static let circularViewSize = CalendarRatio.standard.scaledSquare(size: 35, accordingTo: .width)
    }
}
