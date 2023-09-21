//
//  UIView.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit

// MARK: Xib load routine
extension UIView {
    static var describing: String {
        return String(describing: self)
    }
    
    private func setupView(subView: UIView) {
        backgroundColor = .clear
        subView.frame = bounds
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subView)
        self.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: 0).isActive = true
        self.topAnchor.constraint(equalTo: subView.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: 0).isActive = true
        subView.backgroundColor = .clear
    }
}

// MARK: Round Corners
extension UIView {
    func setCornersRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func roundedView() {
        superview?.layoutIfNeeded()
        setCornersRadius(frame.width / 2)
    }
    
    func addShadow(with cornerRadius: CGFloat = 0) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor

        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowOpacity = 0.1
        shadowLayer.shadowRadius = 4

        self.layer.insertSublayer(shadowLayer, at: 0)
    }
}
