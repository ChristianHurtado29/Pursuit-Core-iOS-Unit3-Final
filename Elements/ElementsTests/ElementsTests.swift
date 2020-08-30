//
//  ElementsTests.swift
//  ElementsTests
//
//  Created by Christian Hurtado on 8/30/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import XCTest
@testable import Elements

class ElementsTests: XCTestCase {
    
    var elements = [Element]()
    
    func testFirstElement(){
        var firstElement = ""
        let exp = XCTestExpectation(description: "elements match")
        ElementsSearchAPIClient.getElements(for: elements) { (result) in
            exp.fulfill()
            switch result {
            case .failure(let error):
                XCTFail("\(error)")
            case .success(let elems):
                firstElement = elems[0].name
                XCTAssert(firstElement == "hydrogen")
            }
        }
        wait(for: [exp], timeout: 3.0)
    }

    func testNumberOfElements(){
        var elementsNum = 0
        let exp = XCTestExpectation(description: "elements found")
        ElementsSearchAPIClient.getElements(for: elements) { (result) in
            exp.fulfill()
            switch result {
            case .failure(let error):
                XCTFail("error is \(error)")
            case .success(let elements):
                elementsNum = elements.count
                XCTAssert(elementsNum > 10)
            }
        }
        wait(for: [exp], timeout: 5.0)
    }


}
