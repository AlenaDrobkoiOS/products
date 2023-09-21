//
//  TableViewCell.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit
import RxSwift

/// Base protocol for all UITableViewCell
open class TableViewCell: UITableViewCell, Reusable {
    // MARK: - Properties

    public lazy var disposeBag = DisposeBag()

    // MARK: - Constructor

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
