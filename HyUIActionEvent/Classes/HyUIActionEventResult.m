//
//  HyUIActionEventResult.m
//
//  Created by HyanCat on 16/3/30.
//  Copyright © 2016年 hyancat. All rights reserved.
//

#import "HyUIActionEventResult.h"

@interface HyUIActionEventResult ()

@property (nonatomic, assign, readwrite) BOOL shouldContinueDispatching;

@end

@implementation HyUIActionEventResult

+ (instancetype)resultWithContinueDispatching:(BOOL)shouldContinueDispatching
{
	HyUIActionEventResult *result = [[self alloc] init];
	result.shouldContinueDispatching = shouldContinueDispatching;
	
	return result;
}

@end
