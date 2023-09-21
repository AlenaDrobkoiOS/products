//
//  HeaderView.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit
import SnapKit

/// HeaderView - collectionview header contains title
final class HeaderView: UICollectionReusableView, Reusable {
    
    // MARK: - Properties
    
    private var containerView = UIView()
    private var titleLabel = UILabel()
    
    // MARK: - Constructor
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    // MARK: - Fucntions
    
    func setupView() {
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.textColor = .darkText
        titleLabel.font = Style.Font.boldText
    }
    
    func setupConstraints() {
        self.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(10)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func render(with text: String) {
        titleLabel.text = text
    }
}
