//
//  WeakDictionaryTests.swift
//  SwiftBinding
//
//  Created by Zachary Smith on 3/2/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import XCTest

class WeakDictionaryTests: XCTestCase {
    //var weakDictionary:WeakDictionary<NSObject, () -> String>!
    var strongKeyReference = NSObject()
    override func setUp() {
        super.setUp()
        
        //weakDictionary = WeakDictionary<NSObject, () -> String>()
        
        //weakDictionary.setItem(strongKeyReference, value: "Hello")
        
        //weakDictionary.setItem(strongKeyReference, value: {() -> String in return "Hello"})
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        //var result = weakDictionary.itemForKey(strongKeyReference)()
        
        //XCTAssert(result == "Hello", "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
