//
//  CoverImageViewAnimator.swift
//  Finder
//
//  Created by Dmitrii on 22.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import UIKit

class CoverImageViewAnimator {
    
    private var initialImageView: UIImageView?
    private var showingView: UIView?
    
    func animateToFullScreen(imageView: UIImageView) {
        
        let window = UIApplication.shared.windows.first!
        
        initialImageView = imageView
        showingView = window
        
        let expandedImageView = UIImageView.init(image: imageView.image)
        expandedImageView.contentMode = .scaleAspectFit
        expandedImageView.frame = window.convert(imageView.frame, from: imageView.superview)
        expandedImageView.isUserInteractionEnabled = true
        expandedImageView.clipsToBounds = true
        expandedImageView.backgroundColor = .black
        
        window.addSubview(expandedImageView)
        expandedImageView.alpha = 0
        UIView.transition(with: expandedImageView,
                          duration: 0.7,
                          options: .curveEaseInOut,
                          animations: {
                            expandedImageView.frame = window.bounds
                            expandedImageView.alpha = 1
        }) { (finished) in
            let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.onTap(sender:)))
            expandedImageView.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    @objc private func onTap(sender: UITapGestureRecognizer) {
    
        guard let imageView = initialImageView, let showingView = showingView else {
            return
        }
        
        let point = showingView.convert(imageView.bounds, from: imageView)
        
        UIView.animate(withDuration: 0.7,
                       animations: {
                        sender.view?.frame = point
                        sender.view?.alpha = 0
        }) { (finished) in
            sender.view?.removeFromSuperview()
        }
    }
}
