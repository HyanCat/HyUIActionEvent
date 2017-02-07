//
//  SecondViewController.m
//  HyUIActionEventExample
//
//  Created by NyanCat on 06/02/2017.
//  Copyright © 2017 HyanCat. All rights reserved.
//

#import "SecondViewController.h"
#import "HyUIActionCore.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic, assign) NSUInteger count;

@property (weak, nonatomic) IBOutlet UIButton *increaseButton;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Second";

    // Register event name.
    self.increaseButton.eventName = @"increaseCount";
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

    return [HyUIActionEventResult resultWithContinueDispatching:YES];
}

@end
