//
//  ProductCollectionViewCell.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit
import RxSwift
import SnapKit

/// Product cell - contains info about cell
final class ProductCollectionViewCell: CollectionViewCell {
    
    private var containerView = UIView()
    private var productImageView = UIImageView()
    private var titleLabel = UILabel()
    private var priceLabel = UILabel()
    private var stattPriceLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        stattPriceLabel.text = nil
        
        disposeBag = DisposeBag()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(productImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(stattPriceLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        productImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(containerView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom)
            $0.left.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().offset(-15)
        }
        
        stattPriceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.right.equalToSuperview().offset(-15)
            $0.left.greaterThanOrEqualTo(priceLabel.snp.right)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
    
    override func setupView() {
        super.setupView()
        
        self.addShadow(with: 12)

        containerView.backgroundColor = .white
        containerView.setCornersRadius(12)
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.textColor = .darkText
        titleLabel.font = Style.Font.regularMidleText
        
        priceLabel.numberOfLines = 1
        priceLabel.textAlignment = .left
        priceLabel.textColor = .darkText
        priceLabel.font = Style.Font.semiboldText
        
        stattPriceLabel.numberOfLines = 1
        stattPriceLabel.textAlignment = .left
        stattPriceLabel.textColor = .gray
        stattPriceLabel.font = Style.Font.regularSmallText
    }
    
    func render(_ model: ProductDataType) {
        productImageView.setImage(with: model.imageURL)
        titleLabel.text = model.title
        priceLabel.text = "\(model.price) ".replacingOccurrences(of: ".", with: ",") + Localizationable.Product.euro.localized
        
        if let strikePrice = model.strikePrice {
            let string = Localizationable.Product.actionPrice.localized + " \(strikePrice) ".replacingOccurrences(of: ",", with: ".") + Localizationable.Product.euro.localized
            let attributeString = NSMutableAttributedString(string: string,
                                                            attributes: [.foregroundColor: UIColor.gray,
                                                                         .font: Style.Font.regularSmallText])
            let rangeValue = Localizationable.Product.actionPrice.localized.count
            attributeString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue,
                                         range: NSMakeRange(rangeValue, attributeString.length - rangeValue))
            stattPriceLabel.attributedText = attributeString
        }
    }
}
