//
//  HyUIActionEventResult.h
//  HyUIActionEvent-Demo
//
//  Created by HyanCat on 16/3/30.
//  Copyright © 2016年 hyancat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HyUIActionEventResult : NSObject

@property (nonatomic, assign, readonly) BOOL shouldContinueDispatching;

+ (instancetype)resultWithContinueDispatching:(BOOL)shouldContinueDispatching;

@end

NS_ASSUME_NONNULL_END