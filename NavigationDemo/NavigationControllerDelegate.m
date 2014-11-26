//
//  NavigationControllerDelegate.m
//  NavigationDemo
//
//  Created by Todd Grooms on 11/26/14.
//  Copyright (c) 2014 Groomsy Dev. All rights reserved.
//

#import "NavigationControllerDelegate.h"

#import "ColorViewController.h"
#import "ColorsViewController.h"

#import "ColorToColorsAnimatedTransitioningDelegate.h"
#import "ColorsToColorAnimatedTransitioningDelegate.h"

@interface NavigationControllerDelegate ()

@property (nonatomic, weak) IBOutlet UINavigationController *navigationController;

@property (nonatomic, strong) ColorToColorsAnimatedTransitioningDelegate *colorToColorsAnimatedTransitioningDelegate;
@property (nonatomic, strong) ColorsToColorAnimatedTransitioningDelegate *colorsToColorAnimatedTransitioningDelegate;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation NavigationControllerDelegate

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.colorToColorsAnimatedTransitioningDelegate = [ColorToColorsAnimatedTransitioningDelegate new];
    self.colorsToColorAnimatedTransitioningDelegate = [ColorsToColorAnimatedTransitioningDelegate new];
}

#pragma mark - Gesture

- (void)handlePopRecognizer:(UIScreenEdgePanGestureRecognizer*)recognizer {
    /*
     * Interesting tidbit: If you call [self.interactionController updateInteractiveTransition:progress] with 
     * progress >= 1.f, then calling [self.interactionController finishInteractiveTransition] leads to an odd
     * visual glitch where the UIViewControllerAnimatedTransitioning's UIViewControllerContextTransitioning's
     * UITransitionContextFromViewControllerKey reappears before disappearing again.
     */
    
    CGFloat distanceTravelled = [recognizer translationInView:recognizer.view].x;
    CGFloat progress = distanceTravelled / ( recognizer.view.bounds.size.width * [UIScreen mainScreen].scale );
    progress = MAX(0.0, progress);
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactionController = [UIPercentDrivenInteractiveTransition new];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactionController updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if ( progress > 0.5f ) {
            [self.interactionController finishInteractiveTransition];
        }
        else {
            [self.interactionController cancelInteractiveTransition];
        }
        
        self.interactionController = nil;
    }
}

#pragma mark - UINavigationControllerDelegate Methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if ( [fromVC isKindOfClass:[ColorsViewController class]] && [toVC isKindOfClass:[ColorViewController class]] ) {
        return self.colorsToColorAnimatedTransitioningDelegate;
    }
    if ( [fromVC isKindOfClass:[ColorViewController class]] && [toVC isKindOfClass:[ColorsViewController class]] ) {
        return self.colorToColorsAnimatedTransitioningDelegate;
    }
    return nil;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ( ![viewController isEqual:navigationController.viewControllers.firstObject] ) {
        UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
        popRecognizer.edges = UIRectEdgeLeft;
        [viewController.view addGestureRecognizer:popRecognizer];
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ( [animationController isEqual:self.colorToColorsAnimatedTransitioningDelegate] ) {
        return self.interactionController;
    }
    return nil;
}

@end
