//
//  NotificationTests.swift
//  BurntFoundationTests
//
//  Created by Patrick Smith on 16/05/2015.
//  Copyright (c) 2015 Burnt Caramel. All rights reserved.
//

import Foundation
import XCTest
import BurntFoundation


private class Example {
	enum Notification: String {
		case DidUpdate = "NotificationTestsDidUpdateNotification"
	}
}


class NotificationTests: XCTestCase {
	enum TestNotification: String {
		case DidUpdate = "NotificationTestsDidUpdateNotification"
	}
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	var currentObjects: [AnyObject]?
	
	func testObserving() {
		let nc = NSNotificationCenter()
		let object = Example()
		
		let expectation = expectationWithDescription("Observed .DidUpdate notification")
		
		let notificationObserver = NotificationObserver<Example.Notification>(object: object, notificationCenter: nc, queue: NSOperationQueue.mainQueue())
		notificationObserver.addObserver(.DidUpdate) { notification in
			expectation.fulfill()
		}
		
		currentObjects = [
			object,
			notificationObserver
		]
		
		NSOperationQueue.mainQueue().addOperationWithBlock {
			nc.postNotificationName(Example.Notification.DidUpdate.rawValue, object: object)
		}
		
		waitForExpectationsWithTimeout(2) { error in
			self.currentObjects = nil
		}
	}
	
	func testPosting() {
		let nc = NSNotificationCenter.defaultCenter()
		let object = Example()
		
		let expectation = expectationForNotification(Example.Notification.DidUpdate.rawValue, object: object, handler: nil)
		
		currentObjects = [
			object
		]
		
		NSOperationQueue.mainQueue().addOperationWithBlock {
			nc.postNotification(Example.Notification.DidUpdate, object: object, userInfo: nil)
		}
		
		waitForExpectationsWithTimeout(2) { error in
			self.currentObjects = nil
		}
	}
	
}
