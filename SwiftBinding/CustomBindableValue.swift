//
//  CustomBindableValue.swift
//  SwiftBinding
//
//  Created by Zachary Smith on 7/16/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation

//TODO: this should actually be the base class for BindableValue, but for backwards compatibility in this version we'll just override BindableValue
public class CustomBindableValue<ValueType>:BindableValue<ValueType>{
  public override var value:ValueType{
    get{
      return _getMethod()
    }
    
    set(newValue){
      _setMethod(newValue)
      super.value = newValue //HACK: doing this to fire the proper values.
    }
  }
  
  private var _getMethod:(() -> ValueType)!
  private var _setMethod:((ValueType) -> Void)!
  
  public init(getMethod:() -> ValueType, setMethod:(ValueType) -> Void){
    _getMethod = getMethod
    _setMethod = setMethod
    
    super.init(value: _getMethod()) //HACK: doing this to set other things properly.
  }
  
  public override init(value: ValueType) {
    print("WARNING: the init(value:ValueType) method should not be used when using CustomBindableValue...this will be removed in a future version.")
    
    super.init(value: value)
  }
}