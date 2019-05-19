//
//  ComponentCellUI.swift
//  SimpleCalendar
//
//  Created by Bilal Bakhrom on 20/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal protocol ComponentCellUI: AppUIDelegate {
    var titleLabel: UILabel! {get set}
    var circleView: UIView! {get set}
}

internal extension ComponentCellUI {
    
    func setupUI(for view: UIView) {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        circleView = UIView()
        circleView.backgroundColor = .clear
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(into: view)
    }
    
    func addSubviews(into view: UIView) {
        view.addSubview(circleView)
        view.addSubview(titleLabel)
        setSubviewsConstraints(for: view)
    }
    
    func setSubviewsConstraints(for view: UIView) {
        NSLayoutConstraint.activate([
            circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.widthAnchor.constraint(equalToConstant: UI.circularViewSize.width),
            circleView.heightAnchor.constraint(equalToConstant: UI.circularViewSize.height),
            
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        circleView.layer.cornerRadius = UI.circularViewSize.height/2
    }
}

fileprivate struct UI {
    static let circularViewSize = CalendarRatio.standard.scaledSquare(size: 35, accordingTo: .width)
}
