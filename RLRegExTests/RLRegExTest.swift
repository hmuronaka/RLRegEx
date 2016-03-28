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
        
        
        if let result = try! "http://C/TableName/".match("http://C/([^/]+)") {
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
        
        do {
            let _ = try "http://C/TableName/".match("http://C/([[^/]+)")
            XCTFail("False")
        } catch let error1 as NSError {
            error = error1
            XCTAssertNotNil(error!, "\(error!)")
        }
    }
    
    func testRegExNoError() {
        
        do {
            if let result = try "http://C/TableName/".match("http") {
                XCTAssertEqual(1, result.count)
                XCTAssertEqual("http", result[0])
            } else {
                XCTFail("fail")
            }
        } catch {
            XCTFail("fail")
        }
    }
    
    func testRegExNotFound() {
        
        if let result = try! "http://C//".match("http://C/([^/]+)") {
            XCTFail(result[0])
        } else {
            XCTAssert(true)
        }
        
    }

    func testRegExFound2() {
        
        if let result = try! "http://AC/BD".match("http://([^/]+)/([^/]+)") {
            XCTAssertEqual(3, result.count)
            XCTAssertEqual("http://AC/BD", result[0])
            XCTAssertEqual("AC", result[1])
            XCTAssertEqual("BD", result[2])
        } else {
            XCTAssert(false)
        }
        
    }
    
    func testRegExWords() {
        if let result = try! "http://AC/BD/CE".match("(\\w+)") {
            XCTAssertEqual(2, result.count)
            XCTAssertEqual("http", result[0])
            XCTAssertEqual("http", result[1])
        } else {
            XCTAssert(false)
        }
        
    }
    
    
    // MARK: -
    // MARK: gsub
    func test_gsubNoTemplate() {
        
        do {
            let str = try "http://ac/bd/".gsub("/\\w+", replacement: "/AC")!
            XCTAssertEqual("http://AC/AC/", str)
        } catch let error as NSError {
            print(error)
            
        }
    }
    
    func test_gsubTemplate() {
        var str = try! "http://ac/bd/".gsub("http://(\\w+)/(\\w+)", replacement: "$0")!
        XCTAssertEqual("http://ac/bd/", str)
        
        str = try! "http://ac/bd/".gsub("http://(\\w+)/(\\w+)", replacement: "$1")!
        XCTAssertEqual("ac/", str)
        str = try! "http://ac/bd/".gsub("http://(\\w+)/(\\w+)/", replacement: "$1")!
        XCTAssertEqual("ac", str)
        str = try! "http://ac/bd/".gsub("(\\w+)/(\\w+)", replacement: "$2")!
        XCTAssertEqual("http://bd/", str)
        str = try! "http://ac/bd/".gsub("(\\w+)/(\\w+)", replacement: "$1$2")!
        XCTAssertEqual("http://acbd/",str)
        str = try! "http://ac/bd/".gsub("http://(\\w+)/(\\w+)", replacement: "$1$2")!
        XCTAssertEqual("acbd/",str)
        str = try! "http://ac/bd/".gsub("http://(\\w+)/(\\w+)/", replacement: "$1$2")!
        XCTAssertEqual("acbd", str)
    }
    
    func test_gsubError() {
        var error:NSError?
        
        do {
            let _ = try "http".gsub("([", replacement: "afd")
            XCTFail("fail")
        } catch let error1 as NSError {
            error = error1
            XCTAssertNotNil(error, "\(error)")
        }
    }
    
    func test_gusbNoError() {
        var error:NSError? = nil
        
        do {
            let str = try "http".gsub("tp", replacement: "TP")
            XCTAssertNil(error)
            XCTAssertEqual("htTP", str)
        } catch let error1 as NSError {
            error = error1
            XCTFail("fail \(error)")
        }
    }
    
    // MARK: -
    // MARK: matches
    func test_matchesFound() {
        "http".matches("http", error: nil) { (rlMatch) -> Bool in
            XCTAssertEqual(rlMatch[0], "http")
            XCTAssertEqual(1, rlMatch.count)
            return true
        }
    }
    
    func test_matchesFoundWithoutError() {
        "http".matches("http") { (rlMatch) -> Bool in
            XCTAssertEqual(rlMatch[0], "http")
            XCTAssertEqual(1, rlMatch.count)
            return true
        }
    }
    
    func test_matchesFound2() {
        "http".matches("(\\w)tp(\\w)", error: nil) { (rlMatch) -> Bool in
            XCTAssertEqual(rlMatch[0], "h")
            XCTAssertEqual(rlMatch[1], "p")
            XCTAssertEqual(2, rlMatch.count)
            return true
        }
    }
    
    func test_matchesFoundWithoutError2() {
        "http".matches("(\\w)tp(\\w)") { (rlMatch) -> Bool in
            XCTAssertEqual(rlMatch[0], "h")
            XCTAssertEqual(rlMatch[1], "p")
            XCTAssertEqual(2, rlMatch.count)
            return true
        }
    }
    
    func test_matchesFound3() {
        
        var total = 0
        
        "http".matches("(\\w)", error: nil) { (rlMatch) -> Bool in
            switch(total) {
            case 0:
                XCTAssertEqual("h", rlMatch[0])
                XCTAssertEqual("h", rlMatch[1])
                XCTAssertEqual(2, rlMatch.count)
                break;
            case 1:
                XCTAssertEqual("t", rlMatch[0])
                XCTAssertEqual("t", rlMatch[1])
                XCTAssertEqual(2, rlMatch.count)
                break;
            case 2:
                XCTAssertEqual("t", rlMatch[0])
                XCTAssertEqual("t", rlMatch[1])
                XCTAssertEqual(2, rlMatch.count)
                break;
            case 3:
                XCTAssertEqual("p", rlMatch[0])
                XCTAssertEqual("p", rlMatch[1])
                XCTAssertEqual(2, rlMatch.count)
                break;
            default:
                XCTFail("default is fail")
            }
            total+=1
            return true
        }
        XCTAssertEqual(4, total)
    }
    func test_matchesFoundWithoutError3() {
        
        var total = 0
        
        "http".matches("(\\w)") { (rlMatch) -> Bool in
            switch(total) {
            case 0:
                XCTAssertEqual("h", rlMatch[0])
                XCTAssertEqual("h", rlMatch[1])
                XCTAssertEqual(2, rlMatch.count)
                break;
            case 1:
                XCTAssertEqual("t", rlMatch[0])
                XCTAssertEqual("t", rlMatch[1])
                XCTAssertEqual(2, rlMatch.count)
                break;
            case 2:
                XCTAssertEqual("t", rlMatch[0])
                XCTAssertEqual("t", rlMatch[1])
                XCTAssertEqual(2, rlMatch.count)
                break;
            case 3:
                XCTAssertEqual("p", rlMatch[0])
                XCTAssertEqual("p", rlMatch[1])
                XCTAssertEqual(2, rlMatch.count)
                break;
            default:
                XCTFail("default is fail")
            }
            total+=1
            return true
        }
        XCTAssertEqual(4, total)
    }
    
    func test_matchesStop() {
        
        var total = 0
        
        "http".matches("(\\w)", error: nil) { (rlMatch) -> Bool in
            switch(total) {
            case 0:
                XCTAssertEqual("h", rlMatch[0])
                XCTAssertEqual("h", rlMatch[1])
                XCTAssertEqual(2, rlMatch.count)
                break;
            default:
                XCTFail("default is fail")
            }
            total+=1
            return false
        }
        XCTAssertEqual(1, total)
    }
    
    func testWord() {
        
        do {
            let str = "We must will be\n the dog bad.Test"
            if let result = try str.match("the") {
                XCTAssertEqual(1, result.count)
                XCTAssertEqual("the", result[0])
            }
        } catch let err {
            XCTFail("\(err)")
        }
     }
    
    func testPhrase() {
        
        do {
            let str = try! "We must will be test the match.Double\n count Equal.\nAB CD EF.\n DDD. Test\n Bad Bud".gsub("\n", replacement: " ")!.gsub("\\s+", replacement: " ")!
            
            
            if let result = try str.match("\\s*([^\\.]*we(?:[^\\.]*\\.|.*))", options:[NSRegularExpressionOptions.AllowCommentsAndWhitespace , NSRegularExpressionOptions.CaseInsensitive]) {
                XCTAssertEqual(2, result.count)
                XCTAssertEqual("We must will be test the match.", result[0])
                XCTAssertEqual("We must will be test the match.", result[1])
            } else {
                XCTFail("faile")
            }
            if let result = try str.match("\\s*([^\\.]*will(?:[^\\.]*\\.|.*))", options:NSRegularExpressionOptions.AllowCommentsAndWhitespace) {
                XCTAssertEqual(2, result.count)
                XCTAssertEqual("We must will be test the match.", result[0])
                XCTAssertEqual("We must will be test the match.", result[1])
            } else {
                XCTFail("faile")
            }
            
            if let result = try str.match("\\s*([^\\.]*Double(?:[^\\.]*\\.|.*))", options:NSRegularExpressionOptions.AllowCommentsAndWhitespace) {
                XCTAssertEqual(2, result.count)
                let temp = try result[0].gsub("\\s+", replacement: " ")!
                XCTAssertEqual("Double count Equal.", temp)
//                XCTAssertEqual("Double count Equal.", result[1])
            } else {
                XCTFail("faile")
            }
            if let result = try str.match("\\s*([^\\.]*Bud(?:[^\\.]*\\.|.*))", options:NSRegularExpressionOptions.AllowCommentsAndWhitespace) {
                XCTAssertEqual(2, result.count)
                let temp = try result[0].gsub("^\\s+", replacement: "")!
                XCTAssertEqual("Test Bad Bud", temp)
                XCTAssertEqual("Test Bad Bud", result[1])
            } else {
                XCTFail("faile")
            }
            if let result = try str.match("\\s*([^\\.]*AB(?:[^\\.]*\\.|.*))", options:NSRegularExpressionOptions.AllowCommentsAndWhitespace) {
                XCTAssertEqual(2, result.count)
                let temp = try result[0].gsub("^\\s+", replacement: "")!
                XCTAssertEqual("AB CD EF.", temp)
                XCTAssertEqual("AB CD EF.", result[1])
            } else {
                XCTFail("faile")
            }
           } catch let err {
            XCTFail("\(err)")
        }
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
