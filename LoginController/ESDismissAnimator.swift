//
//  ESDismissAnimator.swift
//  ES_UIPresentationController_Demo
//
//  Created by Eric Stroh on 2/24/15.
//  Copyright (c) 2015 com.strohtennis. All rights reserved.
//

import UIKit

public class ESDismissAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey){
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                fromViewController.view.alpha = 0.0
                fromViewController.view.transform = CGAffineTransformMakeScale(0.2, 0.2)
                }) { (finished) -> Void in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
        }
    }
}
