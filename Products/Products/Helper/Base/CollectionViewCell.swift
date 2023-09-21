//
//  CollectionViewCell.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import RxSwift
import UIKit

/// Base protocol for all UICollectionViewCell
open class CollectionViewCell: UICollectionViewCell, Reusable {
    // MARK: - Properties

    public lazy var disposeBag = DisposeBag()

    // MARK: - Constructor

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupView()
        setupLocalization()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
        setupView()
        setupLocalization()
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    // MARK: - Fucntions

    open func setupView() {}

    open func setupConstraints() {}

    open func setupLocalization() {}
}
