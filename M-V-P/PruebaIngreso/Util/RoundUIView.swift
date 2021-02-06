//
//  RoundUIView.swift
//  PruebaIngreso
//
//  Created by Camilo Téllez on 4/02/21.
//

import UIKit

@IBDesignable
class RoundUIView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var useShadow: Bool = false{
        didSet{
            addShadow(flag: useShadow)
        }
    }
    
    func addShadow(flag: Bool){
        if flag{
            self.layer.shadowColor = UIColor.gray.cgColor
            self.layer.shadowOpacity = 0.3
            self.layer.shadowOffset = CGSize.zero
            self.layer.shadowRadius = 6
        }else{
            self.layer.shadowColor = nil
            self.layer.shadowOpacity = 0
            self.layer.shadowOffset = CGSize.zero
            self.layer.shadowRadius = 0
        }
    }
}
