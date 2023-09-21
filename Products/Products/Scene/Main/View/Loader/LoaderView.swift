//
//  LoaderView.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit
import SnapKit

/// Loader View - contains activityIndicator and text
final class LoaderView: View {
    
    private var containerView = UIView()
    private var titleLabel = UILabel()
    private let activityIndicatorView = UIActivityIndicatorView()


    // MARK: - Fucntions

    override func setupView() {
        super.setupView()
        
        self.backgroundColor = .systemGray4
        
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
        titleLabel.font = Style.Font.regularMidleText
    }

    override func setupConstraints() {
        super.setupConstraints()
        
        self.addSubview(containerView)
        
        containerView.addSubview(activityIndicatorView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(activityIndicatorView.snp.bottom).offset(10)
            $0.left.bottom.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
        }
        
        activityIndicatorView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setupLocalization() {
        super.setupLocalization()
        
        titleLabel.text = Localizationable.Product.loading.localized
    }
    
    func start() {
        self.alpha = 1
        activityIndicatorView.startAnimating()
    }
    
    func stop() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            UIView.animate(withDuration: 1) { [weak self] in
                self?.activityIndicatorView.stopAnimating()
                self?.alpha = 0
            }
        })
    }
}
