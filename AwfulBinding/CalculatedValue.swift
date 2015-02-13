//
//  CalculatedValue.swift
//  AwfulBinding
//
//  Created by Zachary Smith on 2/13/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation

public class CalculatedValue<ValueType>:BindableValue<ValueType>{
    private let _listenerOwner:NSObject = NSObject()
    
    private func calculateValue(){
        self.value = calculator(_boundValues)
    }
    
    public var calculator:([PUpdateable]) -> ValueType
    
    private var _boundValues:[PUpdateable]
    
    public init(boundValues:[PUpdateable], calculator:([PUpdateable]) -> ValueType){
        _boundValues = boundValues
        self.calculator = calculator
        
        super.init()
        
        for boundValue in boundValues{
            boundValue.addAnyUpdateListener(_listenerOwner, listener: boundValueUpdated, alertNow: false)
        }
    }
    
    private func boundValueUpdated(){
        calculateValue()
    }
}