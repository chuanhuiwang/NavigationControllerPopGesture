//
//  InterruptNavigationControllerPopGesture.swift
//  NavigationControllerPopGesture
//
//  Created by 王传辉 on 2019/12/20.
//  Copyright © 2019 王传辉. All rights reserved.
//

import UIKit

public protocol InterruptNavigationControllerPopGesture {
    
    func interruptNavigationController(_ navigationController: UINavigationController, PopGesture: UIGestureRecognizer) -> Bool
    
}
