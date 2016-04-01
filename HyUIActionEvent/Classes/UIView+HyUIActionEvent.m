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

const void *kHyUIActionEventNameKey     = &kHyUIActionEventNameKey;
const void *kHyUIActionEventUserInfoKey = &kHyUIActionEventUserInfoKey;
const void *kHyUIActionEventGestureKey  = &kHyUIActionEventGestureKey;

@implementation UIView (HyUIActionEvent)

@dynamic eventName;
@dynamic eventUserInfo;

- (NSString *)eventName
{
	return objc_getAssociatedObject(self, kHyUIActionEventNameKey);
}

- (void)setEventName:(NSString *)eventName
{
	[self removeGestureRecognizer:self.eventGesture];
	
	objc_setAssociatedObject(self, kHyUIActionEventNameKey, eventName, OBJC_ASSOCIATION_COPY_NONATOMIC);
	
	if (eventName && eventName.length > 0) {
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTouchEvent:)];
		self.eventGesture = tapGesture;
		[self addGestureRecognizer:tapGesture];
	}
}

- (NSDictionary *)eventUserInfo
{
	return objc_getAssociatedObject(self, kHyUIActionEventUserInfoKey);
}

- (void)setEventUserInfo:(NSDictionary *)eventUserInfo
{
	objc_setAssociatedObject(self, kHyUIActionEventUserInfoKey, eventUserInfo, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UITapGestureRecognizer *)eventGesture
{
	return objc_getAssociatedObject(self, kHyUIActionEventGestureKey);
}

- (void)setEventGesture:(UITapGestureRecognizer *)eventGesture
{
	objc_setAssociatedObject(self, kHyUIActionEventGestureKey, eventGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)_handleTouchEvent:(id)sender
{
	[self dispatchHyUIActionEvent:[HyUIActionEvent eventWithName:self.eventName object:self userInfo:self.eventUserInfo] inMainThead:YES];
}

@end
