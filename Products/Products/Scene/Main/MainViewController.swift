//
//  MainViewController.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

/// Main screen controller
final class MainViewController: ViewController<BaseMainViewModel> {
    
    // MARK: - UI elements
    
    private let containerView = UIView()
    private let loaderView = LoaderView()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    
    // MARK: - Set Up VC
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(containerView)
        
        containerView.addSubview(collectionView)
        containerView.addSubview(loaderView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loaderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupScrollCollection() {
        super.setupScrollCollection()
        
        flowLayout.scrollDirection = .vertical
        
        collectionView.registerCellClass(ProductCollectionViewCell.self)
        collectionView.registerSupplementaryHeaderView(HeaderView.self)
        
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray6
        collectionView.contentInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    override func setupOutput() {
        super.setupOutput()
        
        let input = BaseMainViewModel.Input(
            itemsSelected: collectionView.rx.itemSelected.map({$0}).asObservable(),
            disposeBag: disposeBag)
        
        viewModel.transform(input, outputHandler: setupInput(input:))
    }
    
    override func setupInput(input: BaseMainViewModel.Output) {
        super.setupInput(input: input)
        
        disposeBag.insert(
            setUpLoadingObserving(with: input.isLoading, loaderView: loaderView),
            setupItemsObserving(with: input.collectionItems, collectionView: collectionView)
        )
    }
    
    private func setupItemsObserving(with signal: Driver<[Products]>, collectionView: UICollectionView) -> Disposable {
        signal
            .asObservable()
            .bind(to: collectionView.rx.items(dataSource: dataSource()))
    }
    
    private func setUpLoadingObserving(with signal: Driver<Bool>, loaderView: LoaderView) -> Disposable {
        signal
            .asObservable()
            .subscribe { isLoading in
                guard let isLoading = isLoading.element else { return }
                
                if isLoading {
                    loaderView.start()
                } else {
                    loaderView.stop()
                }
            }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 60) / 2
        return CGSize(width: width, height: width * 1.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
    
    func dataSource() -> RxCollectionViewSectionedAnimatedDataSource<Products> {
        return RxCollectionViewSectionedAnimatedDataSource<Products>(
            configureCell: { (dataSource, collectionView, indexPath, viewModel) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(ofType: ProductCollectionViewCell.self,
                                                              at: indexPath)
                cell.render(viewModel)
                return cell
            },
            configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
                let header = collectionView.dequeueReusableSupplementaryView(ofType: HeaderView.self,
                                                                             at: indexPath,
                                                                             kind: kind)
                header.render(with: dataSource.sectionModels[indexPath.section].title)
                return header
            })
    }
}
