//
//  BaseViewController.swift
//  Movies
//
//  Created by MohamedRafat on 6/5/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import UIKit
import PopupDialog


typealias alertCompeletionHandler = (Bool) -> Void

public enum BackImage {
    case wightLeftBack
}

// MARK: - BaseViewControllerProtocol
protocol BaseViewControllerProtocol {
    
    func setNavigationTitle(title:String, color: UIColor, font: UIFont)
    func setupNavigation(colors: [UIColor], backImage: BackImage?, isTranslucent: Bool)
    func setupBackBtn(backImage: BackImage)
    func pushViewController(viewController:UIViewController, animated: Bool)
    func popViewController(animated: Bool)
    func showLoadingView()
    func hideLoadingView()
}


class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    private var loadingIndicator: LoadingIndicator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        loadingIndicator = LoadingIndicator(frame: view.frame)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    func showLoadingView()  {
        view.addSubview(loadingIndicator!)
        loadingIndicator?.indicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func hideLoadingView()  {
        loadingIndicator?.removeFromSuperview()
        loadingIndicator?.indicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func showAlertWithOk(title:String , message:String, completion: alertCompeletionHandler? = nil) {
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, preferredWidth: (UIScreen.main.bounds.width * 0.70), tapGestureDismissal: true, panGestureDismissal: true, hideStatusBar: true, completion: nil)
        let okBtn = CancelButton(title: "OK", height: 45, dismissOnTap: true){
            completion?(true)
        }
        popup.addButtons([okBtn])
        self.present(popup, animated: true, completion: nil)
    }
    
    func showAlertWithYesNo(title:String , message:String, completion: alertCompeletionHandler? = nil) {
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, preferredWidth: (UIScreen.main.bounds.width * 0.70), tapGestureDismissal: true, panGestureDismissal: true, hideStatusBar: true, completion: nil)
        let yesBtn = DefaultButton(title: "Yes", height: 45, dismissOnTap: true) {
            completion?(true)
        }
        let noBtn = CancelButton(title: "No", height: 45, dismissOnTap: true){
            completion?(false)
        }
        popup.addButtons([yesBtn, noBtn])
        self.present(popup, animated: true, completion: nil)
    }
    
    
    func pushViewController(viewController: UIViewController, animated: Bool = false) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(animated: Bool = false) {
        navigationController?.popViewController(animated: animated)
    }
    
    func setNavigationTitle(title:String,
                            color: UIColor = ColorPalette.navigationTitleColor,
                            font: UIFont = Fonts.Arial) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font]
        self.navigationItem.title = title
    }
    
    func setupNavigation(colors: [UIColor] = [ColorPalette.navigationTopColor, ColorPalette.navigationBottomColor],
                         backImage: BackImage? = nil, isTranslucent: Bool = false)  {
        
        let img = UIImage()
        navigationController?.navigationBar.shadowImage = img
        navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        
        navigationController?.navigationBar.isTranslucent = isTranslucent;
        
        if !isTranslucent { navigationController?.navigationBar.setGradientBackground(colors: colors)}
        navigationController?.navigationBar.tintColor = ColorPalette.navigationTintColor
        
        guard let backImg = backImage else {
            navigationItem.hidesBackButton = true
            return }
        setupBackBtn(backImage: backImg)
    }
    
    func setupBackBtn(backImage: BackImage){
        switch backImage {
        case .wightLeftBack:
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(onTapBack))
        }
    }
    
    @objc func onTapBack()  {
        if navigationController?.viewControllers.count ?? 0 > 1 {
            navigationController?.popViewController(animated: true)
        }else {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func resetNav(){
        let img = UIImage()
        navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = img
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = ColorPalette.navigationTintColor
        navigationItem.hidesBackButton = true
    }
    
    func toggoleNavBar(isHidden: Bool){
        navigationController?.isNavigationBarHidden = isHidden
    }
}
