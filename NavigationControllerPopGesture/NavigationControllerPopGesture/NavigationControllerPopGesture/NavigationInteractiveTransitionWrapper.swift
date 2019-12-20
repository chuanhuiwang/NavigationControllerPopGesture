//
//  NavigationInteractiveTransitionWrapper.swift
//  NavigationControllerPopGesture
//
//  Created by 王传辉 on 2019/12/20.
//  Copyright © 2019 王传辉. All rights reserved.
//

import UIKit

open class NavigationInteractiveTransitionWrapper: NSObject {
    
    public private(set) weak var navigationController: UINavigationController?
    public let wrapped: UIGestureRecognizerDelegate
    
    //wrapped传入navigationController.interactivePopGestureRecognizer?.delegate
    public init(navigationController: UINavigationController, wrapped: UIGestureRecognizerDelegate) {
        self.navigationController = navigationController
        self.wrapped = wrapped
    }
    
    open func navigationControllerShouldPop() -> Bool {
        guard let navigationController = self.navigationController else {
            return false
        }
        if navigationController.viewControllers.count <= 1 {
            return false
        }
        return true
    }
    
    open func isTouchViewInNavigationBar(_ view: UIView?) -> Bool {
        guard let navigationController = self.navigationController else {
            return false
        }
        var temp = view
        while temp != nil {
            if navigationController.navigationBar.isEqual(temp) {
                return true
            }else {
                temp = temp?.superview
            }
        }
        return false
    }
    
    open func navigationControllerShouldInterruptPopGesture(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController = navigationController else {
            return true
        }
        guard let object = navigationController.topViewController as? InterruptNavigationControllerPopGesture else {
            return false
        }
        return object.interruptNavigationController(navigationController, PopGesture: gestureRecognizer)
    }
    
}

extension NavigationInteractiveTransitionWrapper: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if navigationControllerShouldInterruptPopGesture(gestureRecognizer) {
            return false
        }
        if let result = wrapped.gestureRecognizerShouldBegin?(gestureRecognizer) {
            return result
        }
        return true
    }
        
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if navigationControllerShouldPop() == false {
            return false
        }
        if isTouchViewInNavigationBar(touch.view) {
            return false
        }
        return true
    }
        
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let result = wrapped.gestureRecognizer?(gestureRecognizer, shouldRecognizeSimultaneouslyWith: otherGestureRecognizer) {
            return result
        }
        return true
    }
    
}
