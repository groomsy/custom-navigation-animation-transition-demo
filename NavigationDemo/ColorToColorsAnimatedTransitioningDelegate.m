//
//  ColorToColorsAnimatedTransitioningDelegate.m
//  NavigationDemo
//
//  Created by Todd Grooms on 11/26/14.
//  Copyright (c) 2014 Groomsy Dev. All rights reserved.
//

#import "ColorToColorsAnimatedTransitioningDelegate.h"

@implementation ColorToColorsAnimatedTransitioningDelegate

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         fromViewController.view.alpha = 0.f;
                         fromViewController.view.transform = CGAffineTransformScale(fromViewController.view.transform, 0.5, 0.5);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end
