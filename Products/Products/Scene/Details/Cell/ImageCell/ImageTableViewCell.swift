//
//  ImageTableViewCell.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit
import RxSwift

/// Details screen image cell - contains poster image
final class ImageTableViewCell: TableViewCell {
    
    private var containerView = UIView()
    private var posterImageView = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        disposeBag = DisposeBag()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(posterImageView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerY.left.right.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width)
        }
    }
    
    override func setupView() {
        super.setupView()
        
        selectionStyle = .none
        backgroundColor = .clear
        
        containerView.backgroundColor = .white
        posterImageView.contentMode = .redraw
    }
    
    func render(_ imageURL: String?) {
        posterImageView.setImage(with: imageURL)
    }
}
