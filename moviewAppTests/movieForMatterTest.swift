//
//  movieForMatterTest.swift
//  moviewAppTests
//
//  Created by Jooeun Kim on 2022/12/09.
//

import XCTest
import RxSwift
@testable import moviewApp

 class movieForMatterTest: XCTestCase {
    // 올바른 테스트는 매번 조금 간단한 테스트후, 좀간단한 코드로 * 반복 하는것이다
    let formatter = NetworkManager()

    func testMovieForMatterWholeData(){
        //        XCTAssert : 테스트 expression이 true일때 확인
        //        XCTAssert(<#T##expression: Bool##Bool#>)
        //        XCTAssertEqual : 인자 1 테스트의 결과로, 인자 2번이 호출되는 지
        XCTAssertEqual(formatter.string(decimal: Decimal(string: "0")!), "0.00")
        XCTAssertEqual(formatter.string(decimal: Decimal(string: "1")!), "1.00")
        XCTAssertEqual(formatter.string(decimal: Decimal(string: "-2")!), "-2.00")
        XCTAssertEqual(formatter.string(decimal: Decimal(string: "12")!), "12.00")
    }
    
    func testMoviewFommatterDecimalNumberWithOneDecimalPlace() {
        XCTAssertEqual(formatter.string(decimal: Decimal(string: "1.1")!), "1.10")
    }
    
    func testMoviewFommatterDecimalNumberWithTwoDecimalPlace() {
        XCTAssertEqual(formatter.string(decimal: Decimal(string: "1.11")!), "1.11")
        XCTAssertEqual(formatter.string(decimal: Decimal(string: "2.22")!), "2.22")
        XCTAssertEqual(formatter.string(decimal: Decimal(string: "-2.22")!), "-2.22")
    }
    
    func testMoviewFommatterDecimalNumberWithAnyDecimalPlace() {
        XCTAssertEqual(formatter.string(decimal: Decimal(string: "1.11111")!), "1.11")
        XCTAssertEqual(formatter.string(decimal: Decimal(string: "2.229")!), "2.22")
        XCTAssertEqual(formatter.string(decimal: Decimal(string: "2.123456789")!), "2.12")
    }
    
    func testRealData(){
    }
}
