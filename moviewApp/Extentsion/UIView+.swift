//
//  UIView+.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/01.
//

import Foundation
import UIKit

extension UIView{
    func addSubviews(_ views:[UIView]) {
        views.map{ self.addSubview($0)}
    }
}
