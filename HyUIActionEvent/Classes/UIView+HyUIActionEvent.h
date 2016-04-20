//
//  UIView+HyUIActionEvent.h
//
//  Created by HyanCat on 16/4/1.
//  Copyright © 2016年 ruogu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HyUIActionEvent)

@property (nullable, nonatomic, copy) NSString *eventName;
@property (nullable, nonatomic, copy) NSDictionary *eventUserInfo;
@property (nullable, nonatomic, strong) UITapGestureRecognizer *eventGesture;

- (void)resetEvent;
- (void)removeEvent;

- (void)lock;
- (void)lockUntil:(NSTimeInterval)afterTime;
- (void)unlock;

@end

NS_ASSUME_NONNULL_END