//
//  ViewControllerWelcomeAndLogOut.swift
//  Movies
//
//  Created by MohamedRafat on 6/7/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import UIKit

class ViewControllerWelcomeAndLogOut: BaseViewController {

    private let usernameLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogOutBtn()
        setupWelcomeLbl()
        loadUsername()
    }
    
    // LogOut
    private func setupLogOutBtn(){
        let logoutBarButtonItem = UIBarButtonItem(title: "LogOut", style: .done, target: self, action: #selector(handleLogOut))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }
    
    @objc private func handleLogOut(){
        MainTabBarController.instance.dismiss(animated: true){
            LocalCache().setUser(user: nil)
        }
    }
    
    // Welcome
    private func setupWelcomeLbl(){
        let welcomeTxtLbl = UILabel()
        welcomeTxtLbl.textAlignment = .center
        welcomeTxtLbl.text = "Welcome,"
        welcomeTxtLbl.textColor = ColorPalette.welcomeTxtColor
        welcomeTxtLbl.font = Fonts.welcomeFont
        usernameLbl.textAlignment = .center
        usernameLbl.text = "username"
        usernameLbl.textColor = ColorPalette.usernameTxtColor
        usernameLbl.font = Fonts.usernameFont
        let stackView = UIStackView(arrangedSubviews: [welcomeTxtLbl, usernameLbl])
        stackView.axis = .horizontal
        stackView.spacing = 4
        let welcomeBarBtnItem = UIBarButtonItem(customView: stackView)
        self.navigationItem.leftBarButtonItem = welcomeBarBtnItem
    }
    
    func setUsernameText(username: String){
        usernameLbl.text = username
    }
    
    func loadUsername(){
        LocalCache().getUser { (user) in
            guard let user = user else { return }
            self.setUsernameText(username: user.username ?? "")
        }
    }
    
}
