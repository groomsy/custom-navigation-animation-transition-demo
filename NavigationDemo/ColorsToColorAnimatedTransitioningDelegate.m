//
//  ColorsToColorAnimatedTransitioningDelegate.m
//  NavigationDemo
//
//  Created by Todd Grooms on 11/26/14.
//  Copyright (c) 2014 Groomsy Dev. All rights reserved.
//

#import "ColorsToColorAnimatedTransitioningDelegate.h"

@implementation ColorsToColorAnimatedTransitioningDelegate

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:toViewController.view];
    toViewController.view.alpha = 0.f;
    toViewController.view.transform = CGAffineTransformScale(toViewController.view.transform, 0.5, 0.5);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toViewController.view.alpha = 1.f;
                         toViewController.view.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                         });
                     }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end
