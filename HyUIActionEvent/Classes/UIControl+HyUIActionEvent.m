//
//  UIControl+HyUIActionEvent.m
//
//  Created by HyanCat on 16/3/31.
//  Copyright © 2016年 hyancat. All rights reserved.
//

#import "UIControl+HyUIActionEvent.h"
#import <objc/runtime.h>
#import "HyUIActionEvent.h"
#import "UIResponder+HyUIActionEvent.h"


const void *kHyUIControlActionEventNameKey     = &kHyUIControlActionEventNameKey;
const void *kHyUIControlActionEventUserInfoKey = &kHyUIControlActionEventUserInfoKey;

@implementation UIControl (HyUIActionEvent)

@dynamic eventName;
@dynamic eventUserInfo;

- (NSString *)eventName
{
	return objc_getAssociatedObject(self, kHyUIControlActionEventNameKey);
}

- (void)setEventName:(NSString *)eventName
{
	[self removeTarget:self action:@selector(_handleTouchEvent:) forControlEvents:UIControlEventTouchUpInside];

	objc_setAssociatedObject(self, kHyUIControlActionEventNameKey, eventName, OBJC_ASSOCIATION_COPY_NONATOMIC);

	if (eventName && eventName.length > 0) {
		[self addTarget:self action:@selector(_handleTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
	}
}

- (NSDictionary *)eventUserInfo
{
	return objc_getAssociatedObject(self, kHyUIControlActionEventUserInfoKey);
}

- (void)setEventUserInfo:(NSDictionary *)eventUserInfo
{
	objc_setAssociatedObject(self, kHyUIControlActionEventUserInfoKey, eventUserInfo, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)lock
{
    [self lockUntil:60];
}

- (void)lockUntil:(NSTimeInterval)afterTime
{
    if ([NSThread isMainThread]) {
        [self _lockUntil:afterTime];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _lockUntil:afterTime];
        });
    }
}

- (void)unlock
{
    if ([NSThread isMainThread]) {
        [self _unlock];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _unlock];
        });
    }
}

- (void)_handleTouchEvent:(id)sender
{
	[self dispatchHyUIActionEvent:[HyUIActionEvent eventWithName:self.eventName object:self userInfo:self.eventUserInfo] inMainThead:YES];
}

- (void)_lockUntil:(NSTimeInterval)afterTime
{
    self.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self _unlock];
    });
}

- (void)_unlock
{
    self.enabled = YES;
}

@end
