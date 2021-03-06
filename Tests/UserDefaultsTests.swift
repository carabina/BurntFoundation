//
//  BurntFoundationTests.swift
//  BurntFoundationTests
//
//  Created by Patrick Smith on 16/05/2015.
//  Copyright (c) 2015 Burnt Caramel. All rights reserved.
//

import Foundation
import XCTest
import BurntFoundation


class UserDefaultsTests: XCTestCase {
	enum TestIntChoice: Int, UserDefaultsChoiceRepresentable {
		case One = 1
		case Two = 2
		case Three = 3
		
		static var defaultsKey: String = "testInt"
	}
	
	enum TestStringChoice: String, UserDefaultsChoiceRepresentable {
		case Apple = "apple"
		case Banana = "banana"
		case Carrot = "carrot"
		
		static var defaultsKey: String = "testString"
	}
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIntChoice() {
		let ud = NSUserDefaults()
		
		ud.setInteger(3, forKey: TestIntChoice.defaultsKey)
		XCTAssertEqual(ud.intChoiceWithFallback(TestIntChoice.One), .Three, "Set integer, get choice")
		
		ud.setIntChoice(TestIntChoice.Two)
		XCTAssertEqual(ud.integerForKey(TestIntChoice.defaultsKey), 2, "Set choice, get integer")
    }
	
	func testStringChoice() {
		let ud = NSUserDefaults()
		
		ud.setObject("banana", forKey: TestStringChoice.defaultsKey)
		XCTAssertEqual(ud.stringChoiceWithFallback(TestStringChoice.Apple), .Banana, "Set string, get choice")
		
		ud.setStringChoice(TestStringChoice.Carrot)
		XCTAssertEqual(ud.stringForKey(TestStringChoice.defaultsKey)!, "carrot", "Set choice, get string")
	}
	
}
