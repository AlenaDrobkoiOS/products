//
//  MainViewModelTests.swift
//  ProductsTests
//
//  Created by Alena Drobko on 06.08.23.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Products

class MainViewModelTests: XCTestCase {
    
    var viewModel: MainViewModel!
    let bag = DisposeBag()
    
    var mockResponse: [Products] = []
    let expectation = XCTestExpectation(description: "Items loaded")
    
    override func setUp() {
        guard let serviceHolder = TestConfiguration.getServiceHolder() else {
            XCTFail("Can't fetch ServiceHolder")
            return
        }
        
        let injections = MainViewModel.Injections(serviceHolder: serviceHolder)
        viewModel = MainViewModel(injections: injections)
        viewModel.collectionItems
            .subscribe { [weak self] items in
                guard let self else { return }
                
                if self.viewModel.isLoading.value == false {
                    XCTAssertEqual(items, self.mockResponse)
                    self.expectation.fulfill()
                }
            }
            .disposed(by: bag)
    }
    
    func testTransform() {
        let input = MainViewModel.Input(itemsSelected: .never(), disposeBag: bag)
        
        var outputTableItems: [Products] = []
        var outputLoader: Bool = false
        let outputHandler: (MainViewModel.Output) -> Void = { output in
            output.collectionItems.drive(onNext: { items in
                outputTableItems = items
            }).disposed(by: self.bag)
            
            output.isLoading.drive(onNext: { items in
                outputLoader = items
            }).disposed(by: self.bag)
        }
        
        viewModel.transform(input, outputHandler: outputHandler)
        
        XCTAssertEqual(outputTableItems, viewModel.collectionItems.value)
        XCTAssertEqual(outputLoader, viewModel.isLoading.value)
    }
    
    func testSetUpItemsSelected() {
        if let productInfo = viewModel.collectionItems.value.first?.products.first {
            let indexPath = IndexPath(row: 0, section: 0)
            viewModel.setUpItemsSelected(with: .just(indexPath)).disposed(by: bag)
            XCTAssertEqual(try viewModel.openProductDetails.value(), productInfo)
        }
    }
    
    func testFetchProductsListSuccess() {
        mockResponse = [.init(title: Constants.defaultTitle,
                              products: [.init(id: nil,
                                               title: "Apfel Elstar aus Österreich",
                                               imageURL: "https://shopreme.com/jobinterview/data/apfel.jpeg",
                                               price: 2.49,
                                               strikePrice: nil,
                                               description: "Klasse I\n\nElstar Äpfel von Da komm ich her! sind mittelfest und haben einen frischen, süß-säuerlichen Geschmack. Die Sorte gehört zu den beliebtesten Speiseäpfeln.\n\nQualität aus Österreich\neignet sich gut für Strudel oder zum Dörren"),
                                         .init(id: nil,
                                               title: "Weißkraut aus Österreich",
                                               imageURL: "https://shopreme.com/jobinterview/data/weisskraut.jpeg",
                                               price: 0.99,
                                               strikePrice: 1.25,
                                               description: "Klasse I\n\n\nfester Kopf\nkeine fleckigen oder trockenen Außenblätter\nWeißkraut ist eine Variante des Kopfkohls\nvorwiegend in Herbst und Winter Saison"),
                                         .init(id: nil,
                                               title: "Snack Radieschen aus Österreich",
                                               imageURL: "https://shopreme.com/jobinterview/data/radieschen.jpeg",
                                               price: 1.00,
                                               strikePrice: 1.49,
                                               description: "Klasse I\n\nHeute schon gesund gesnackt? Die Snack Radieschen zeichnen sich durch ihr unverkennbares Aroma aus und schmecken auch gut im frisch zubereiteten Salat.\n\nliefern wichtige Vitamine und Mineralstoffe"),
                                         .init(id: nil,
                                               title: "Kartoffel, speckig",
                                               imageURL: "https://shopreme.com/jobinterview/data/kartoffel.jpg",
                                               price: 2.49,
                                               strikePrice: nil,
                                               description: "Klasse I\n\nHeimisches Gemüse aus österreichischem Anbau: Die speckigen Erdäpfel von Da komm` ich her! lassen sich wunderbar zu Salat und köstlichen Beilagen verarbeiten.\n\naus der Region\nreich an Vitaminen und Mineralstoffen"),
                                         .init(id: nil,
                                               title: "Erdbeeren aus Spanien",
                                               imageURL: "https://shopreme.com/jobinterview/data/erdbeeren.jpeg",
                                               price: 2.79,
                                               strikePrice: 2.99,
                                               description: "Klasse I\n\nsaftig-süß\nfeste, gleichmäßig gereifte Früchte\nideal für Obstsalate oder für den gesunden Snack zwischendurch"),
                                         .init(id: nil,
                                               title: "Erdnüsse",
                                               imageURL: "https://shopreme.com/jobinterview/data/erdnuesse.jpeg",
                                               price: 1.59,
                                               strikePrice: nil,
                                               description: "Klasse I\n\nOb als knackige Knabberei, Salatzutat, in warmen Gerichten oder Gebäck: SanLucar Erdnüsse bilden einen wertvollen Bestandteil für eine ausgewogene Ernährung.\n\ngeröstete Erdnüsse mit Schale\nideal als nahrhafter Snack oder Zutat in warmen und kalten Speisen\nreich an Eiweiß, Mineralien und Vitaminen")])]
        viewModel.fetchProducts(by: .list)
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchProductsCategorySuccess() {
        mockResponse = [.init(title: "Frische Früchte",
                              products: [.init(id: nil,
                                               title: "Apfel Elstar aus Österreich",
                                               imageURL: "https://shopreme.com/jobinterview/data/apfel.jpeg",
                                               price: 2.49,
                                               strikePrice: nil,
                                               description: "Klasse I\n\nElstar Äpfel von Da komm ich her! sind mittelfest und haben einen frischen, süß-säuerlichen Geschmack. Die Sorte gehört zu den beliebtesten Speiseäpfeln.\n\nQualität aus Österreich\neignet sich gut für Strudel oder zum Dörren"),
                                         .init(id: nil,
                                               title: "Erdbeeren aus Spanien",
                                               imageURL: "https://shopreme.com/jobinterview/data/erdbeeren.jpeg",
                                               price: 2.79,
                                               strikePrice: 2.99,
                                               description: "Klasse I\n\nsaftig-süß\nfeste, gleichmäßig gereifte Früchte\nideal für Obstsalate oder für den gesunden Snack zwischendurch"),
                                         .init(id: nil,
                                               title: "Erdnüsse",
                                               imageURL: "https://shopreme.com/jobinterview/data/erdnuesse.jpeg",
                                               price: 1.59,
                                               strikePrice: nil,
                                               description: "Klasse I\n\nOb als knackige Knabberei, Salatzutat, in warmen Gerichten oder Gebäck: SanLucar Erdnüsse bilden einen wertvollen Bestandteil für eine ausgewogene Ernährung.\n\ngeröstete Erdnüsse mit Schale\nideal als nahrhafter Snack oder Zutat in warmen und kalten Speisen\nreich an Eiweiß, Mineralien und Vitaminen")]),
                        .init(title: "Gesundes Gemüse",
                              products: [.init(id: nil,
                                               title: "Weißkraut aus Österreich",
                                               imageURL: "https://shopreme.com/jobinterview/data/weisskraut.jpeg",
                                               price: 0.99,
                                               strikePrice: 1.25,
                                               description: "Klasse I\n\n\nfester Kopf\nkeine fleckigen oder trockenen Außenblätter\nWeißkraut ist eine Variante des Kopfkohls\nvorwiegend in Herbst und Winter Saison"),
                                         .init(id: nil,
                                               title: "Snack Radieschen aus Österreich",
                                               imageURL: "https://shopreme.com/jobinterview/data/radieschen.jpeg",
                                               price: 1.00,
                                               strikePrice: 1.49,
                                               description: "Klasse I\n\nHeute schon gesund gesnackt? Die Snack Radieschen zeichnen sich durch ihr unverkennbares Aroma aus und schmecken auch gut im frisch zubereiteten Salat.\n\nliefern wichtige Vitamine und Mineralstoffe"),
                                         .init(id: nil,
                                               title: "Kartoffel, speckig",
                                               imageURL: "https://shopreme.com/jobinterview/data/kartoffel.jpg",
                                               price: 2.49,
                                               strikePrice: nil,
                                               description: "Klasse I\n\nHeimisches Gemüse aus österreichischem Anbau: Die speckigen Erdäpfel von Da komm` ich her! lassen sich wunderbar zu Salat und köstlichen Beilagen verarbeiten.\n\naus der Region\nreich an Vitaminen und Mineralstoffen")])]
        viewModel.fetchProducts(by: .category)
        wait(for: [expectation], timeout: 10.0)
    }
}
