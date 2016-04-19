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

- (void)_handleTouchEvent:(id)sender
{
	[self dispatchHyUIActionEvent:[HyUIActionEvent eventWithName:self.eventName object:self userInfo:self.eventUserInfo] inMainThead:YES];
}

@end
