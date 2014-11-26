//
//  ColorViewController.m
//  NavigationDemo
//
//  Created by Todd Grooms on 11/26/14.
//  Copyright (c) 2014 Groomsy Dev. All rights reserved.
//

#import "ColorViewController.h"

@interface ColorViewController ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation ColorViewController

#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = self.backgroundColor;
}

@end
