//
//  ProgressView.swift
//  PruebaIngreso
//
//  Created by Camilo Téllez on 4/02/21.
//

import Foundation
import UIKit

class ProgressView {
    static let shared = ProgressView()
    let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
    let visualEffectView = UIVisualEffectView()
    var view: UIView?
    
    private init(){}
    
    func show(view: UIView){
        self.view = view
        visualEffectView.isHidden = false
        activityIndicator.isHidden = false
        
        activityIndicator.alpha = 0
        visualEffectView.frame = view.frame
        visualEffectView.effect = UIBlurEffect(style: .dark)
        visualEffectView.alpha = 0
        self.view!.addSubview(visualEffectView)
        
        self.view!.addSubview(activityIndicator)
        activityIndicator.center = self.view!.center
        activityIndicator.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        
        activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 0.3) {
            self.activityIndicator.alpha = 1
            self.activityIndicator.transform = CGAffineTransform.identity
            self.visualEffectView.effect = UIBlurEffect(style: .dark)
            self.visualEffectView.alpha = 0.6
            self.visualEffectView.transform = CGAffineTransform.init(scaleX: 1.6, y: 1.6)
        }
    }
    
    func dismiss(){
        UIView.animate(withDuration: 0.3, animations: {
            self.activityIndicator.transform = CGAffineTransform.init(scaleX: 2, y: 2)
            self.activityIndicator.alpha = 0
            self.visualEffectView.effect = nil
        }) { (success: Bool) in
            self.activityIndicator.removeFromSuperview()
            self.visualEffectView.removeFromSuperview()
        }
    }
}
