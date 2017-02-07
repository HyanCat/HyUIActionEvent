//
//  FirstViewController.m
//  HyUIActionEventExample
//
//  Created by HyanCat on 07/02/2017.
//  Copyright © 2017 HyanCat. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import <HyUIActionEvent/HyUIActionCore.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"First";

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SecondViewController *second = [mainStoryboard instantiateViewControllerWithIdentifier:@"second"];
    [self addChildViewController:second];
    [self.view addSubview:second.view];
    second.view.frame = self.view.frame;
}

- (HyUIActionEventResult *)handleIncreaseCountWithActionEvent:(HyUIActionEvent *)event
{
    NSLog(@"%@ Handled increase count event.", NSStringFromClass([self class]));

    return [HyUIActionEventResult resultWithContinueDispatching:YES];
}

@end
