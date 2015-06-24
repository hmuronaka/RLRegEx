//
//  RLRegExTest.swift
//  RLRegEx
//
//  Created by Muronaka Hiroaki on 2015/06/20.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

import UIKit
import XCTest

class RLRegExTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: -
    // MARK: match
    func testRegExFound() {
        
        if let result = "http://C/TableName/".match("http://C/([^/]+)") {
            XCTAssertEqual(2, result.count)
            XCTAssertEqual("http://C/TableName", result[0])
            XCTAssertEqual("TableName", result[1])
            XCTAssertEqual("", result[2])
        } else {
            XCTFail("fail")
        }
    }
    
    func testRegExError() {
        var error:NSError?
        
        if let result = "http://C/TableName/".match("http://C/([[^/]+)", error:&error) {
            XCTFail("False")
        } else {
            XCTAssertNotNil(error!, "\(error!)")
        }
    }
    
    func testRegExNotFound() {
        
        if let result = "http://C//".match("http://C/([^/]+)") {
            XCTFail("fail")
        } else {
            XCTAssert(true)
        }
        
    }

    func testRegExFound2() {
        
        if let result = "http://AC/BD".match("http://([^/]+)/([^/]+)") {
            XCTAssertEqual(3, result.count)
            XCTAssertEqual("AC", result[1])
            XCTAssertEqual("BD", result[2])
        } else {
            XCTAssert(false)
        }
        
    }
    
    
    // MARK: -
    // MARK: gsub
    
    func test_gsubNoTemplate() {
        XCTAssertEqual("http://AC/AC/", "http://ac/bd/".gsub("/\\w+", replacement: "/AC")!)
    }
    
    func test_gsubTemplate() {
        XCTAssertEqual("http://ac/bd/", "http://ac/bd/".gsub("http://(\\w+)/(\\w+)", replacement: "$0")!)
        XCTAssertEqual("ac/", "http://ac/bd/".gsub("http://(\\w+)/(\\w+)", replacement: "$1")!)
        XCTAssertEqual("ac", "http://ac/bd/".gsub("http://(\\w+)/(\\w+)/", replacement: "$1")!)
        XCTAssertEqual("http://bd/", "http://ac/bd/".gsub("(\\w+)/(\\w+)", replacement: "$2")!)
        XCTAssertEqual("http://acbd/", "http://ac/bd/".gsub("(\\w+)/(\\w+)", replacement: "$1$2")!)
        XCTAssertEqual("acbd/", "http://ac/bd/".gsub("http://(\\w+)/(\\w+)", replacement: "$1$2")!)
        XCTAssertEqual("acbd", "http://ac/bd/".gsub("http://(\\w+)/(\\w+)/", replacement: "$1$2")!)
    }
 
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
