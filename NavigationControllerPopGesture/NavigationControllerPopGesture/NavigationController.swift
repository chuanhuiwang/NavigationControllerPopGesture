//
//  NavigationController.swift
//  NavigationControllerPopGesture
//
//  Created by 王传辉 on 2019/12/20.
//  Copyright © 2019 王传辉. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    var wrapper: NavigationInteractiveTransitionWrapper?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let delegate = self.interactivePopGestureRecognizer?.delegate {
            wrapper = NavigationInteractiveTransitionWrapper(navigationController: self, wrapped: delegate)
            self.interactivePopGestureRecognizer?.delegate = wrapper
        }
        topViewController?.title = "root"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
