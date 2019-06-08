//
//  LoginViewController.swift
//  Movies
//
//  Created by MohamedRafat on 6/5/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import UIKit

class LoginViewController: ViewControllerWithTabBar {

    // MARK: - Outlets
    @IBOutlet weak var usernameTxtField: UITextFieldX!
    @IBOutlet weak var usernameErrorLbl: UILabelX!
    
    // MARK:-  Properties
    private var _presenter: LoginPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIsLoggedIn()
        
        setupNavigation(isTranslucent: true)
        
        _presenter = LoginPresenter(viewController: self)
    }
    
    func checkIsLoggedIn(){
        LocalCache().getUser { (user) in
            guard let _ = user else { return }
            self.instantiateTabBarController(animated: false)
        }
    }
    
    // MARK: - Actions
    @IBAction func onGoBtnPressed(_ sender: UIButtonX) {
       _presenter?.loginWithUsername(username: usernameTxtField.text!)
    }
    
    func showUsernameErrorLbl(message: String) {
        usernameErrorLbl.isHidden = false
        usernameErrorLbl.text = message
    }
    
    func hideUsernameErrorLbl(){
        usernameErrorLbl.isHidden = true
        usernameErrorLbl.text = ""
    }
    
}
