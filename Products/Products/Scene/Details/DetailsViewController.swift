//
//  DetailsViewController.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

/// Details screen controller
final class DetailsViewController: ViewController<BaseDetailsViewModel> {
    
    // MARK: - UI elements
    
    private let containerView = UIView()
    private let tableView = UITableView()
    
    // MARK: - Set Up VC
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(containerView)
        
        containerView.addSubview(tableView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.right.left.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setupView() {
        super.setupView()
        
        containerView.backgroundColor = .systemGray6
    }
    
    override func setupScrollCollection() {
        super.setupScrollCollection()
        
        tableView.registerCellClass(ImageTableViewCell.self)
        tableView.registerCellClass(TextTableCell.self)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.alwaysBounceVertical = false
        tableView.alwaysBounceHorizontal = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
    }
    
    override func setupOutput() {
        super.setupOutput()
        
        let input = BaseDetailsViewModel.Input(
            backTapped: self.navigationController?.interactivePopGestureRecognizer?.rx
                .event
                .map({ _ in return () })
                .asObservable() ?? .never(),
            disposeBag: disposeBag
        )
        
        viewModel.transform(input, outputHandler: setupInput(input:))
    }
    
    override func setupInput(input: BaseDetailsViewModel.Output) {
        super.setupInput(input: input)
        
        disposeBag.insert(
            setUpItemsObserving(with: input.tableItems, tableView: tableView)
        )
    }
    
    private func setUpItemsObserving(with signal: Driver<[DetailsCellModel]>, tableView: UITableView) -> Disposable {
        signal
            .drive(tableView.rx.items) { tableView, row, viewModel in
                switch viewModel {
                case .image(let model):
                    let cell = tableView.dequeueReusableCell(ofType: ImageTableViewCell.self,
                                                             at: IndexPath(row: row, section: .zero))
                    cell.render(model)
                    return cell
                case .text(let model):
                    let cell = tableView.dequeueReusableCell(ofType: TextTableCell.self,
                                                             at: IndexPath(row: row, section: .zero))
                    cell.render(model)
                    return cell
                }
            }
    }
}

extension DetailsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
