//
//  UIView+HyUIActionEvent.m
//  Wenxue
//
//  Created by HyanCat on 16/4/1.
//  Copyright © 2016年 ruogu. All rights reserved.
//

#import "UIView+HyUIActionEvent.h"
#import "HyUIActionEvent.h"
#import "UIResponder+HyUIActionEvent.h"
#import <objc/runtime.h>

const void *kHyUIViewActionEventNameKey     = &kHyUIViewActionEventNameKey;
const void *kHyUIViewActionEventUserInfoKey = &kHyUIViewActionEventUserInfoKey;
const void *kHyUIViewActionEventGestureKey  = &kHyUIViewActionEventGestureKey;

@implementation UIView (HyUIActionEvent)

@dynamic eventName;
@dynamic eventUserInfo;

- (NSString *)eventName
{
	return objc_getAssociatedObject(self, kHyUIViewActionEventNameKey);
}

- (void)setEventName:(NSString *)eventName
{
	[self removeGestureRecognizer:self.eventGesture];
	
	objc_setAssociatedObject(self, kHyUIViewActionEventNameKey, eventName, OBJC_ASSOCIATION_COPY_NONATOMIC);
	
	if (eventName && eventName.length > 0) {
        self.userInteractionEnabled = YES;
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTouchEvent:)];
		self.eventGesture = tapGesture;
		[self addGestureRecognizer:tapGesture];
	}
}

- (NSDictionary *)eventUserInfo
{
	return objc_getAssociatedObject(self, kHyUIViewActionEventUserInfoKey);
}

- (void)setEventUserInfo:(NSDictionary *)eventUserInfo
{
	objc_setAssociatedObject(self, kHyUIViewActionEventUserInfoKey, eventUserInfo, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UITapGestureRecognizer *)eventGesture
{
	return objc_getAssociatedObject(self, kHyUIViewActionEventGestureKey);
}

- (void)setEventGesture:(UITapGestureRecognizer *)eventGesture
{
	objc_setAssociatedObject(self, kHyUIViewActionEventGestureKey, eventGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)resetEvent
{
    self.eventName = nil;
    self.eventUserInfo = nil;
}

- (void)removeEvent
{
    [self resetEvent];
    [self removeGestureRecognizer:self.eventGesture];
    self.eventGesture = nil;
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
    self.eventGesture.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self _unlock];
    });
}

- (void)_unlock
{
    self.eventGesture.enabled = YES;
}

@end
