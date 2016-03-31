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


const void *kHyUIActionEventNameKey     = &kHyUIActionEventNameKey;
const void *kHyUIActionEventUserInfoKey = &kHyUIActionEventUserInfoKey;

@implementation UIControl (HyUIActionEvent)

@dynamic eventName;
@dynamic eventUserInfo;

- (NSString *)eventName
{
	return objc_getAssociatedObject(self, kHyUIActionEventNameKey);
}

- (void)setEventName:(NSString *)eventName
{
	[self removeTarget:self action:@selector(_handleTouchEvent:) forControlEvents:UIControlEventTouchUpInside];

	objc_setAssociatedObject(self, kHyUIActionEventNameKey, eventName, OBJC_ASSOCIATION_COPY_NONATOMIC);

	if (eventName && eventName.length > 0) {
		[self addTarget:self action:@selector(_handleTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)_handleTouchEvent:(id)sender
{
	[self dispatchHyUIActionEvent:[HyUIActionEvent eventWithName:self.eventName object:self userInfo:self.eventUserInfo] inMainThead:YES];
}


@end
