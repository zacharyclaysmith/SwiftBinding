//
//  CalculatedValue.swift
//  AwfulBinding
//
//  Created by Zachary Smith on 2/13/15.
//  Copyright (c) 2015 Zachary Smith. All rights reserved.
//

import Foundation

//NOTE: Written as an extension here so that BindableValue doesn't have a dependency on CalculatedValue
public extension BindableValue{
    ///SUMMARY: Convenience function to generate calculated values off of a single bindable value.
    public func transform<ValueType>(calculator:() -> ValueType) -> CalculatedValue<ValueType>{
        return CalculatedValue(boundValues: [self], calculator: calculator)
    }
    
    public func transform<ValueType>(calculator: @autoclosure () -> ValueType) -> CalculatedValue<ValueType>{
        return CalculatedValue(boundValues: [self], calculator: calculator)
    }
    
    public func combine<ValueType>(otherValue:PUpdateable, calculator:() -> ValueType) -> CalculatedValue<ValueType>{
        return CalculatedValue(boundValues: [self, otherValue], calculator: calculator)
    }
    
    public func combine<ValueType>(otherValue:PUpdateable, calculator:@autoclosure  () -> ValueType) -> CalculatedValue<ValueType>{
        return CalculatedValue(boundValues: [self, otherValue], calculator: calculator)
    }
    
    public func combine<ValueType>(otherValues:[PUpdateable], calculator:@autoclosure  () -> ValueType) -> CalculatedValue<ValueType>{
        return CalculatedValue(boundValues: [self] + otherValues, calculator: calculator)
    }
}

public extension BindableArray{
    public func distill<ValueType>(calculator:() -> ValueType) -> CalculatedValue<ValueType>{
        return CalculatedValue(boundValues: [self], calculator: calculator)
    }
    
    public func distill<ValueType>(calculator: @autoclosure () -> ValueType) -> CalculatedValue<ValueType>{
        return CalculatedValue(boundValues: [self], calculator: calculator)
    }
}

public class CalculatedValue<ValueType>:BindableValue<ValueType>{
    private let _listenerOwner:NSObject = NSObject()
    
    private func calculateValue(){
        self.value = calculator()
    }
    
    public var calculator:() -> ValueType
    
    private var _boundValues:[PUpdateable]
    
    public init(boundValues:[PUpdateable], calculator:() -> ValueType){
        _boundValues = boundValues
        self.calculator = calculator
        
        super.init(value:calculator())
        
        for boundValue in boundValues{
            boundValue.addAnyUpdateListener(_listenerOwner, listener: boundValueUpdated, alertNow: false)
        }
    }
    
    deinit{
        for boundValue in _boundValues{
            boundValue.removeAnyUpdateListener(_listenerOwner)
        }
    }
    
    private func boundValueUpdated(){
        calculateValue()
    }
}