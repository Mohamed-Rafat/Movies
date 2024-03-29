//
//  LoveButton.swift
//  Movies
//
//  Created by MohamedRafat on 6/7/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import UIKit


@IBDesignable
class LoveButton: UIButton {
    
    /// Selected love button color.
    @IBInspectable var loveColor: UIColor! = UIColor.red
    /// unSelected love button color.
    @IBInspectable var unLoveColor: UIColor! = UIColor.gray
    /// The image that will show when the status of the button selected.
    @IBInspectable var loveImage: UIImage!
    /// The image that will show when the status of the button unselected.
    @IBInspectable var unLoveImage: UIImage!
    /// The number of views will show when the button pressed.
    @IBInspectable var numberOfHearts: Int = 100
    
    /// When the value is true the color will be `loveColor` and the animation will start.
    var isLoved: Bool? = nil {
        didSet {
            changeStatus()
            guard let isLoved = isLoved,let oldValue = oldValue else {
                return
            }
            // check that the isLoved is equal to true and the old value for the isLoved was false
            if isLoved && !oldValue { addHearts() }
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        
        guard loveImage != nil && unLoveImage != nil else{
            fatalError("Please add loveImage and unLoveImage from the interface builder")
        }
        
        
        loveImage = loveImage.withRenderingMode(.alwaysTemplate)
        unLoveImage = unLoveImage.withRenderingMode(.alwaysTemplate)
        
        #if TARGET_INTERFACE_BUILDER
        isLoved = true
        #endif
        
        self.changeStatus()
    }
    
    
    private func animateLove() {
        UIView.animate(withDuration: 0.5) {
            self.changeStatus()
        }
    }
    
    private func changeStatus() {
        let isLoved = self.isLoved ?? false
        self.setImage(isLoved ? self.loveImage : self.unLoveImage, for: .normal)
        self.tintColor = isLoved ? self.loveColor : self.unLoveColor
    }
    
    private func addHearts(){
        let window = UIApplication.shared.keyWindow!
        let viewFrame = window.convert(self.frame, from: self.superview)
        for _ in 0...numberOfHearts {
            let size = viewFrame.width*0.2 // size of the small images
            // the y and the x is on the mid of the button
            let x = viewFrame.origin.x+(viewFrame.size.width/2)
            let y = viewFrame.origin.y+(viewFrame.size.height/2)
            let frame = CGRect(x: x, y: y, width: size, height: size)
            
            let heart = UIImageView(frame: frame)
            heart.image = loveImage
            heart.tintColor = loveColor
            window.addSubview(heart)
            
            // a random number between half button width before the button, and half button width after the button
            let addedX = CGFloat(arc4random_uniform(UInt32(viewFrame.size.width*2)))-(viewFrame.size.width)
            // a random number between the mid of the button and the half of button height above the button
            let addedY = -CGFloat(arc4random_uniform(UInt32(viewFrame.height*1.5)))
            
            heart.moveTo(addToX: addedX, andToY: addedY, withDuration: Double(drand48()*2), completion: {
                // remove the image when finish animating
                heart.removeFromSuperview()
            })
        }
    }
    
}


// MARK: Animation
extension UIView{
    fileprivate func moveTo(addToX x:CGFloat,andToY y:CGFloat,withDuration duration: TimeInterval,completion: @escaping () -> Void){
        UIView.animate(withDuration: duration, animations: {
            var frame = self.frame
            frame.origin.y = frame.origin.y + y
            frame.origin.x = frame.origin.x + x
            self.frame = frame
            
            self.alpha = 0
        }) { (finished) in
            completion()
        }
    }
}
