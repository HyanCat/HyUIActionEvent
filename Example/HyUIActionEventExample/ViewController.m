//
//  ViewController.m
//  HyUIActionEventExample
//
//  Created by HyanCat on 06/02/2017.
//  Copyright © 2017 HyanCat. All rights reserved.
//

#import "ViewController.h"
#import <HyUIActionEvent/HyUIActionCore.h>
#import "SecondViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic, assign) NSUInteger count;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Main";
}

- (void)setCount:(NSUInteger)count
{
    _count = count;

    self.countLabel.text = [NSString stringWithFormat:@"%ld", count];
}

#pragma - mark Handlers

- (HyUIActionEventResult *)handleIncreaseCountWithActionEvent:(HyUIActionEvent *)event
{
    NSLog(@"%@ Handled increase count event.", NSStringFromClass([self class]));

    self.count ++;

    return [HyUIActionEventResult resultWithContinueDispatching:NO];
}

@end
