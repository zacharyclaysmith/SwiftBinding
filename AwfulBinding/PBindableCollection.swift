//
//  PBindableCollection.swift
//  AwfulBinding
//
//  Created by Zachary Smith on 1/14/15.
//  Copyright (c) 2015 Zachary Smith. All rights reserved.
//

import Foundation

public protocol PBindableCollection:PUpdateable{
    var count:Int{get}
    func addIndexChangedListener(owner:NSObject, listener:(indexChanged:Int) -> Void)
    func addChangedListener(owner:NSObject, alertNow:Bool, listener:() -> Void)
    func removeIndexChangedListener(owner:NSObject)
    func removeChangedListener(owner:NSObject)
}