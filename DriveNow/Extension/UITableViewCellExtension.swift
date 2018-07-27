//
//  UITableViewCellExtension.swift
//  DriveNow
//
//  Created by Kirill Konovalov on 27.07.2018.
//  Copyright © 2018 SixSystems. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
