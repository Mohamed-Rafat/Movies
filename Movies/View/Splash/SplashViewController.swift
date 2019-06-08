//
//  SplashViewController.swift
//  Movies
//
//  Created by MohamedRafat on 6/5/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let loginVC = LoginViewController.instantiate(fromAppStoryboard: .Login)
        let mainNavC = MainNavigationController(rootViewController: loginVC)
        present(mainNavC, animated: true, completion: nil)
    }
}
