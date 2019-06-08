//
//  ValidatorX.swift
//  Movies
//
//  Created by MohamedRafat on 6/7/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import Foundation

class ValidatorX{
    
    func checkIfIsString(string: String)-> Bool {
        let regex = ".*[^A-Z0-9a-z._].*"//".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return !testString.evaluate(with: string)
    }
    
    func vaidateMinLenght(lenght: Int, string: String) ->Bool {
        if string.count < lenght {
            return false
        }else {
            return true
        }
    }
    
    func validateMaxLength(lenght: Int, string: String) -> Bool {
        if string.count > lenght {
            return false
        }else {
            return true
        }
    }
    
}
