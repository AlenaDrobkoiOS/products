//
//  DetailsViewModelTests.swift
//  ProductsTests
//
//  Created by Alena Drobko on 06.08.23.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Products

class DetailsViewModelTests: XCTestCase {
    
    var viewModel: DetailsViewModel!
    let bag = DisposeBag()
    
    let productInfo = ProductDataType(id: "some id",
                                      title: "Product title",
                                      imageURL: "https://example.com/image.jpg",
                                      price: 1.59,
                                      strikePrice: 2.0,
                                      description: "Product description")
    let mockProductDetails: [DetailsCellModel] = [
        .image("https://example.com/image.jpg"),
        .text(.title("Product title")),
        .text(.price(price: 1.59, strokePrice: 2.0)),
        .text(.content("Product description"))
    ]

    override func setUp() {
        guard let serviceHolder = TestConfiguration.getServiceHolder() else {
            XCTFail("Can't fetch ServiceHolder")
            return
        }
        
        let injections = DetailsViewModel.Injections(serviceHolder: serviceHolder, productInfo: productInfo)
        viewModel = DetailsViewModel(injections: injections)
    }
    
    func testSetUpInfo() {
        XCTAssertEqual(viewModel.tableItems.value, mockProductDetails)
    }
    
    func testTransform() {
        let input = DetailsViewModel.Input(backTapped: .never(), disposeBag: bag)
        
        var outputTableItems: [DetailsCellModel] = []
        let outputHandler: (DetailsViewModel.Output) -> Void = { output in
            output.tableItems.drive(onNext: { items in
                outputTableItems = items
            }).disposed(by: self.bag)
        }
        
        viewModel.transform(input, outputHandler: outputHandler)
        
        XCTAssertEqual(outputTableItems, viewModel.tableItems.value)
    }
}
