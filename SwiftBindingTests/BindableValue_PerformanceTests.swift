//
//  BindableValue_PerformanceTests.swift
//  SwiftBinding
//
//  Created by Zachary Smith on 6/6/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import UIKit
import XCTest

class BindableValue_PerformanceTests: XCTestCase {
  
  
    func test_1listener_unparallelized_change() {
      //SETUP
      let testValue = BindableValue(value: "")
      var owners = [NSObject]()
      var expectations = [XCTestExpectation]()
      
      for(var index = 0; index < 1; ++index){
        let currentOwner = NSObject()
        
        owners.append(currentOwner)
        
        testValue.addChangeListener(currentOwner, alertNow: false, listener: {value in
          print("DEBUG: Did Execute")
        })
      }
      
      //ACTION
      //var executionCount = 0
      measureBlock() { () -> Void in
        //if(executionCount == 0){
          testValue.value = "testValue"
        //}
        
        //++executionCount
      }
    }

  func test_100listener_unparallelized_change() {
    //SETUP
    let testValue = BindableValue(value: "")
    var owners = [NSObject]()
    var expectations = [XCTestExpectation]()
    
    for(var index = 0; index < 100; ++index){
      let currentOwner = NSObject()
      
      owners.append(currentOwner)
      
      testValue.addChangeListener(currentOwner, alertNow: false, listener: {value in
        
      })
    }
    
    //ACTION
    //var executionCount = 0
    measureBlock() { () -> Void in
      //if(executionCount == 0){
        testValue.value = "testValue"
      //}
      
      //++executionCount
    }
  }
  
  func test_1000listener_unparallelized_change() {
    //SETUP
    let testValue = BindableValue(value: "")
    var owners = [NSObject]()
    var expectations = [XCTestExpectation]()
    
    for(var index = 0; index < 1000; ++index){
      let currentOwner = NSObject()
      
      owners.append(currentOwner)
      
      testValue.addChangeListener(currentOwner, alertNow: false, listener: {value in
        
      })
    }
    
    //ACTION
    //var executionCount = 0
    measureBlock() { () -> Void in
      //if(executionCount == 0){
        testValue.value = "testValue"
      //}
      
      //++executionCount
    }
  }
  
  func test_10000listener_unparallelized_change() {
    //SETUP
    let testValue = BindableValue(value: "")
    var owners = [NSObject]()
    var expectations = [XCTestExpectation]()
    
    for(var index = 0; index < 10000; ++index){
      let currentOwner = NSObject()
      
      owners.append(currentOwner)
      
      testValue.addChangeListener(currentOwner, alertNow: false, listener: {value in
        
      })
    }
    
    //ACTION
    //var executionCount = 0
    measureBlock() { () -> Void in
      //if(executionCount == 0){
        testValue.value = "testValue"
      //}
      
      //++executionCount
    }
  }
}
