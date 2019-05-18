//
//  CalendarHeaderView.swift
//  CalendarApp
//
//  Created by Bilal Bakhrom on 18/05/2019.
//  Copyright © 2019 Bilal Bakhrom. All rights reserved.
//

import UIKit

internal class CalendarHeaderView: UIView {

    private let cancelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let controller: UIViewController
    
    internal var viewHeight: CGFloat {
        return UI.viewHeight
    }
    
    init(controller: UIViewController) {
        self.controller = controller
        super.init(frame: .zero)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("coder has not been implemented yet")
    }

    internal func set(config: CalendarConfig) {
        guard let statusBarView = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {
            return
        }
        statusBarView.backgroundColor = config.barBackgroundColor
        backgroundColor = config.barBackgroundColor
        cancelImageView.tintColor = config.barImageTintColor
        
        if let image = config.barImage {
            cancelImageView.image = image.withRenderingMode(.alwaysTemplate)
            cancelImageView.setNeedsDisplay()
        } else {
            var bundle = Bundle(for: type(of: self))
            
            if let resourcePath = bundle.path(forResource: "SimpleCalendar", ofType: "bundle") {
                if let resourcesBundle = Bundle(path: resourcePath) {
                    bundle = resourcesBundle
                }
            }
            
            let image = UIImage(named: "cancel", in: bundle, compatibleWith: nil)
            cancelImageView.image = image?.withRenderingMode(.alwaysTemplate)
        }
        
        if let attributedText = config.barAttributedText {
            titleLabel.attributedText = attributedText
        } else {
            titleLabel.textColor = config.barTitleColor
            titleLabel.font = config.barTitleFont
            titleLabel.text = config.barTitle
        }
    }
    
    private func initSubviews() {
        cancelImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeCalendar)))
        addSubview(cancelImageView)
        addSubview(titleLabel)
        
        setSubviewsConstraints()
    }
    
    private func setSubviewsConstraints() {
        NSLayoutConstraint.activate([
            cancelImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cancelImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.imageLeadingSpace),
            cancelImageView.widthAnchor.constraint(equalToConstant: UI.imageSize.width),
            cancelImageView.heightAnchor.constraint(equalToConstant: UI.imageSize.height),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    
    @objc private func closeCalendar() {
        if controller.isPresented {
            controller.dismiss(animated: true, completion: nil)
        } else if controller.isPushed {
            controller.navigationController?.popViewController(animated: true)
        }
    }
}


fileprivate extension CalendarHeaderView {
    
    struct UI {
        static let imageSize = CalendarRatio.standard.scaledSquare(size: 14, accordingTo: .width)
        static let imageLeadingSpace = CalendarRatio.standard.scaled(size: 20, accordingTo: .width)
        static let viewHeight = CalendarRatio.standard.scaled(size: 54, accordingTo: .height)
    }
    
}
