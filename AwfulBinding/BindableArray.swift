//
//  BindableArray.swift
//  AwfulBinding
//
//  Created by Zachary Smith on 12/22/14.
//  Copyright (c) 2014 Zachary Smith. All rights reserved.
//

import Foundation

public class BindableArray<T> : PBindableCollection{
    private var _internalArray:[T]
    private var _changedListeners:Dictionary<NSObject, () -> Void>
    private var _indexChangedListeners:Dictionary<NSObject, ((indexChanged:Int) -> Void)>
    private var _anyUpdateListeners:Dictionary<NSObject, (() -> Void)>
    
    public subscript(index:Int) -> T{
        get{
            return _internalArray[index]
        }
        
        set(newValue){
            _internalArray[index] = newValue
            
            alertIndexChangedListeners(index)
            alertAnyUpdateListeners()
        }
    }
    
    public var internalArray:[T]{
        get{
            return _internalArray
        }
        set(value){
            _internalArray = value
            alertChangedListeners()
            alertAnyUpdateListeners()
        }
    }
    
    public init(internalArray:[T] = []){
        _internalArray = internalArray
        _changedListeners = Dictionary<NSObject, () -> Void>()
        _indexChangedListeners = Dictionary<NSObject, (indexChanged:Int) -> Void>()
        _anyUpdateListeners = Dictionary<NSObject, (() -> Void)>()
    }
    
    public func addIndexChangedListener(owner:NSObject, listener:(indexChanged:Int) -> Void){
        _indexChangedListeners[owner] = listener
    }
    
    public func addChangedListener(owner:NSObject, alertNow:Bool = false, listener:() -> Void){
        _changedListeners[owner] = listener
        
        if(alertNow){
            listener()
        }
    }
    
    public func removeChangedListener(owner:NSObject){
        _changedListeners.removeValueForKey(owner)
    }
    
    public func removeIndexChangedListener(owner:NSObject){
        _indexChangedListeners.removeValueForKey(owner)
    }
    
    public func removeAtIndex(index:Int) -> T{
        let value = _internalArray.removeAtIndex(index)
        
        alertChangedListeners()
        alertAnyUpdateListeners()
        
        return value
    }
    
    public var count:Int{
        return _internalArray.count
    }
    
    public func append(newElement:T){
        _internalArray.append(newElement)
        
        alertChangedListeners()
        alertAnyUpdateListeners()
    }
    
    public func append(newElements:[T]){
        _internalArray.splice(newElements, atIndex: _internalArray.count)
        
        alertChangedListeners()
        alertAnyUpdateListeners()
    }
    
    public func splice(newElements:[T], atIndex:Int){
        _internalArray.splice(newElements, atIndex: atIndex)
        
        alertChangedListeners()
        alertAnyUpdateListeners()
    }
    
    private func alertChangedListeners(){
        for listener in _changedListeners.values{
            listener()
        }
    }
    
    private func alertIndexChangedListeners(indexChanged:Int){
        for listener in _indexChangedListeners.values{
            listener(indexChanged: indexChanged)
        }
    }
    
    public func notifyChanged(){
        alertChangedListeners()
        alertAnyUpdateListeners()
    }
    
    public func notifyIndexChanged(index:Int){
        alertIndexChangedListeners(index)
        alertAnyUpdateListeners()
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
    
    public func removeAll(keepCapacity:Bool = false){
        _internalArray.removeAll(keepCapacity: keepCapacity)
        
        alertChangedListeners()
        alertAnyUpdateListeners()
    }
}