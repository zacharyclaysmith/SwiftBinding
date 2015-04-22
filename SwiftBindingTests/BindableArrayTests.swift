//
//  SwiftBindingTests.swift
//  SwiftBindingTests
//
//  Created by Zachary Smith on 1/27/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import UIKit
import XCTest

class BindableArrayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_append() {
        var test = BindableArray<String>()
        
        var callCount = 0
        
        test.addChangedListener(self, listener: { () -> Void in
            assert(test.count == 1)
            
            ++callCount
            
            assert(callCount == 1, "Callcount == " + String(callCount))
        })
        
        test.append(["Hello"])
        
        assert(test.count == 1)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
