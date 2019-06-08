//
//  Device.swift
//  Movies
//
//  Created by MohamedRafat on 6/7/19.
//  Copyright © 2019 ATeam. All rights reserved.
//

import UIKit

struct Device {
    static let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
}
