//
//  SlideInTransition.swift
//  GoGrabing
//
//  Created by Darshan,Bhavik, Madan, Farshad on 2020-03-22.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit

//SlideInTransition
//animation class for slidein
class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    let dimmingView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        
        
        let contrainerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeight = toViewController.view.bounds.height
        
        if isPresenting {
            // Addming dimming view
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            contrainerView.addSubview(dimmingView)
            dimmingView.frame = contrainerView.bounds
            // Add menu view controller to container
            contrainerView.addSubview(toViewController.view)
            
            //Initial frame off the screen
            
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        //Animate on the screen
         let transform = {
            self.dimmingView.alpha = 0.5
             toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
             
         }
         
         // Animate back off screen
         let identity = {
            self.dimmingView.alpha = 0.0
             fromViewController.view.transform = .identity
         }
        
         //Animation of the transition
         let duration = transitionDuration(using: transitionContext)
         let isCancelled = transitionContext.transitionWasCancelled
         UIView.animate(withDuration: duration, animations: {
             self.isPresenting ? transform() : identity()
         }) {(_) in
             transitionContext.completeTransition(!isCancelled)
         }
        
    }
    

}
