//
//  LoadingIndicator.swift
//  Movies
//
//  Created by MohamedRafat on 6/8/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class LoadingIndicator: UIView {

    var view: UIView!
    
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    @IBOutlet var parent_view: UIView!
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        parent_view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LoadingIndicator", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    

}
