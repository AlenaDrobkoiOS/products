//
//  TextTableCell.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit
import RxSwift

/// Details screen text cell - contains text by type
final class TextTableCell: TableViewCell {
    
    private var containerView = UIView()
    private var infoLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        infoLabel.text = nil
        disposeBag = DisposeBag()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(infoLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.left.equalToSuperview().offset(20)
            $0.centerX.bottom.equalToSuperview()
        }
    }
    
    override func setupView() {
        super.setupView()
        
        selectionStyle = .none
        backgroundColor = .clear
        
        containerView.backgroundColor = .clear
        
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .left
        infoLabel.textColor = .darkText
        infoLabel.font = Style.Font.regularMidleText
    }
    
    func render(_ model: TextCellModel) {
        switch model {
        case .title(let text):
            infoLabel.font = Style.Font.boldText
            infoLabel.text = text
        case .content(let text):
            infoLabel.textAlignment = .natural
            infoLabel.textColor = .darkGray
            infoLabel.text = text
        case .price(price: let price, strokePrice: let strokePrice):
            let string = "\(price) ".replacingOccurrences(of: ".", with: ",") + Localizationable.Product.euro.localized + " "
            let attributeString = NSMutableAttributedString(string:  string,
                                                            attributes: [.foregroundColor: UIColor.darkText,
                                                                         .font: Style.Font.boldText])
            
            if let strokePrice = strokePrice {
                let string = Localizationable.Product.actionPrice.localized + " \(strokePrice) ".replacingOccurrences(of: ",", with: ".") + Localizationable.Product.euro.localized
                let strokePriceAttributeString = NSMutableAttributedString(string: string,
                                                                    attributes: [.foregroundColor: UIColor.gray,
                                                                                 .font: Style.Font.regularMidleText])
                let rangeValue = Localizationable.Product.actionPrice.localized.count
                strokePriceAttributeString.addAttribute(.strikethroughStyle,
                                                        value: NSUnderlineStyle.single.rawValue,
                                                        range: NSMakeRange(rangeValue, attributeString.length - rangeValue))
                attributeString.append(strokePriceAttributeString)
            }
            
            infoLabel.attributedText = attributeString
        }
    }
}
