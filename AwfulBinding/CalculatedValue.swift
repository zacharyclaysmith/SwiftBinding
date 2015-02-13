//
//  CalculatedValue.swift
//  AwfulBinding
//
//  Created by Zachary Smith on 2/13/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation

public class CalculatedValue<ValueType>:PUpdateable{
    private let _listenerOwner:NSObject = NSObject()
    
    private var _value:ValueType?
    private var _changeListeners:Dictionary<NSObject, ((ValueType?) -> Void)>
    
    private var _anyUpdateListeners:Dictionary<NSObject, (() -> Void)>
    
    public var value:ValueType?{return _value}
    
    private func calculateValue(){
        _value = calculator(_boundValues)
        
        alertChangeListeners()
        alertAnyUpdateListeners()
    }
    
    public var calculator:([PUpdateable]) -> ValueType
    
    private var _boundValues:[PUpdateable]
    
    public init(boundValues:[PUpdateable], calculator:([PUpdateable]) -> ValueType){
        _changeListeners = Dictionary<NSObject, ((ValueType?) -> Void)>()
        _anyUpdateListeners = Dictionary<NSObject, (() -> Void)>()
        _boundValues = boundValues
        self.calculator = calculator
        
        for boundValue in boundValues{
            boundValue.addAnyUpdateListener(_listenerOwner, listener: boundValueUpdated, alertNow: false)
        }
    }
    
    private func boundValueUpdated(){
        calculateValue()
    }
    
    public func addListener(owner:NSObject, listener:(ValueType?) -> Void, alertNow:Bool = false){
        _changeListeners[owner] = listener
        
        if(alertNow){
            listener(_value)
        }
    }
    
    public func removeListener(owner:NSObject){
        _changeListeners.removeValueForKey(owner)
    }
    
    private func alertChangeListeners(){
        for changeListener in _changeListeners.values{
            changeListener(_value)
        }
    }
    
    private func alertAnyUpdateListeners(){
        for anyUpdateListener in _anyUpdateListeners.values{
            anyUpdateListener()
        }
    }
    
    public func addAnyUpdateListener(owner:NSObject, listener:() -> Void, alertNow:Bool){
        _anyUpdateListeners[owner] = listener
        
        if(alertNow){
            listener()
        }
    }
    
    public func removeAnyUpdateListener(owner:NSObject){
        _anyUpdateListeners.removeValueForKey(owner)
    }
}