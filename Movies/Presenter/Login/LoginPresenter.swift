//
//  LoginPresenter.swift
//  Movies
//
//  Created by MohamedRafat on 6/7/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import Foundation

class LoginPresenter{
    
    private var _viewControllerDelegate: LoginViewController?
    private var _validator: ValidatorX!
    
    init(viewController: LoginViewController) {
        self._viewControllerDelegate = viewController
        self._validator = ValidatorX()
    }
    
    func loginWithUsername(username: String) {
        let usernameStatus = validateUserName(username: username)
        guard usernameStatus == true else { return }
        // Check if username is exists
        checkUserExists(username: username)
        
    }
    
    func checkUserExists(username: String) {
        _viewControllerDelegate?.showLoadingView()
        let request = BaseRequest(path: Urls.GetUser.getUrlStr(), HTTPMethod: .get, task: .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["username": username]), headers: nil)
        APIRequest().start(request: request) { (result: Result<[User], NetworkResponse>) in
            switch result {
            case .success(let users):
                if users.count > 0{
                    // success login
                    LocalCache().setUser(user: users[0]){ isSaved in
                        if isSaved {
                            self._viewControllerDelegate?.hideLoadingView()
                            self._viewControllerDelegate?.instantiateTabBarController()
                        }
                    }
                }else {
                    self._viewControllerDelegate?.hideLoadingView()
                    // create new username
                    self.createNewUsernameAlert(username: username)
                }
            case .failure(let error):
                self._viewControllerDelegate?.hideLoadingView()
                self._viewControllerDelegate?.showAlertWithOk(title: "Error", message: error.getErrorMsg())
            }
        }
    }
    
    func createNewUsernameAlert(username: String) {
        _viewControllerDelegate?.showAlertWithYesNo(title: "Info", message: #" Do you want to create a new user with username "\#(username)"?"#){ (yes) in
            if yes {
                // Call the server to create new username
               self.createNewUsername(username: username)
            }
        }
    }
    
    func createNewUsername(username: String){
        self._viewControllerDelegate?.showLoadingView()
        let request = BaseRequest(path: Urls.CreateUser.getUrlStr(), HTTPMethod: .post, task: .requestParameters(bodyParameters: ["user": ["username":username]], bodyEncoding: .jsonEncoding, urlParameters: nil), headers: nil)
        APIRequest().start(request: request) { (result: Result<User, NetworkResponse>) in
            switch result{
            case .success(let user):
                LocalCache().setUser(user: user)
                self._viewControllerDelegate?.hideLoadingView()
                self._viewControllerDelegate?.instantiateTabBarController()
            case .failure(let error):
                self._viewControllerDelegate?.hideLoadingView()
                self._viewControllerDelegate?.showAlertWithOk(title: "Error", message: error.getErrorMsg())
            }
        }
    }
    
    // Validate Username
    func validateUserName(username: String) -> Bool {
       var status = false
        if username.isEmpty {
            status = false
            _viewControllerDelegate?.showUsernameErrorLbl(message: "Please enter your username.")
        }else if !_validator.checkIfIsString(string: username){
            status = false
            _viewControllerDelegate?.showUsernameErrorLbl(message: "Please only introduce numbers, letters and underscore.")
        }else if !_validator.validateMaxLength(lenght: 20, string: username) {
            status = false
            _viewControllerDelegate?.showUsernameErrorLbl(message: "Max Characters for username is 20.")
        }else {
            status = true
            _viewControllerDelegate?.hideUsernameErrorLbl()
        }
        return status
    }
}
