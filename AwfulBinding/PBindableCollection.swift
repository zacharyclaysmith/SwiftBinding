//
//  PBindableCollection.swift
//  ARWorld
//
//  Created by Zachary Smith on 1/14/15.
//  Copyright (c) 2015 Scal.io. All rights reserved.
//

import Foundation

public protocol PBindableCollection:PUpdateable{
    var count:Int{get}
    func addIndexChangedListener(owner:NSObject, listener:(indexChanged:Int) -> Void)
    func addChangedListener(owner:NSObject, listener:() -> Void, alertNow:Bool)
}