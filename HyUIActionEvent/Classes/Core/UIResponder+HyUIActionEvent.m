//
//  UIResponder+HyUIActionEvent.m
//
//  Created by HyanCat on 16/3/30.
//  Copyright © 2016年 hyancat. All rights reserved.
//

#import "UIResponder+HyUIActionEvent.h"
#import "HyUIActionEvent.h"
#import "HyUIActionEventResult.h"
#import <objc/message.h>

static dispatch_queue_t dispatchUIEventQueue;

const char *dispatchUIEventQueueName = "HyUIActionEventDispatchQueue";

@implementation UIResponder (HyUIActionEvent)

- (void)dispatchHyUIActionEvent:(HyUIActionEvent *)actionEvent
{
	[self dispatchHyUIActionEvent:actionEvent inMainThead:YES];
}

- (void)dispatchHyUIActionEvent:(HyUIActionEvent *)actionEvent inMainThead:(BOOL)inMainThead
{
	if (inMainThead) {
		if ([NSThread isMainThread]) {
			[self _dispatchHyUIActionEvent:actionEvent];
		}
		else {
			dispatch_async(dispatch_get_main_queue(), ^{
				[self _dispatchHyUIActionEvent:actionEvent];
			});
		}
	}
	else {
		__weak typeof(self) weakSelf = self;
		dispatch_async([self _dispatchQueue], ^{
			__strong typeof(weakSelf) strongSelf = weakSelf;
			if (strongSelf) {
				[strongSelf _dispatchHyUIActionEvent:actionEvent];
			}
		});
	}
}

- (void)_dispatchHyUIActionEvent:(HyUIActionEvent *)actionEvent
{
	NSString * name = [[[actionEvent.eventName substringToIndex:1] uppercaseString] stringByAppendingString:[actionEvent.eventName substringFromIndex:1]];
	NSString * actionSelectorName = [NSString stringWithFormat:@"handle%@WithActionEvent:", name];
	SEL selector = NSSelectorFromString(actionSelectorName);
	if ([self respondsToSelector:selector]) {
		HyUIActionEventResult * (*action)(id, SEL, HyUIActionEvent *) = (HyUIActionEventResult *(*)(id, SEL, HyUIActionEvent *)) objc_msgSend;
		HyUIActionEventResult * result = action(self, selector, actionEvent);
		if (result == nil || ![result isKindOfClass:[HyUIActionEventResult class]] || result.shouldContinueDispatching == NO) {
			// 结束 event
			return ;
		}
	}
	
    UIResponder *next = [self nextEventResponder];
	if (next) {
		[next dispatchHyUIActionEvent:actionEvent inMainThead:[NSThread isMainThread]];
	}
	else {
		NSLog(@"Failed to dispatch HyUIActionEvent，Cann't find [%@] selector!", actionSelectorName);
	}
}

- (UIResponder *)nextEventResponder
{
    UIResponder *next;
    if ([self isKindOfClass:[UIViewController class]]) {

        UIViewController *parentViewController = [(UIViewController *)self parentViewController];
        if (parentViewController && ![parentViewController isKindOfClass:[UINavigationController class]]) {
            // parent view controller and should not be navigation controller.
            return parentViewController;
        }

        UINavigationController *navigationController = [(UIViewController *)self navigationController];
        if (navigationController) {
            NSArray *viewControllers = navigationController.viewControllers;
            NSUInteger index = [viewControllers indexOfObject:self];
            if (index == 0 || index == NSNotFound) {
                return navigationController;
            }
            if (index >= 1 && index < viewControllers.count) {
                next = [viewControllers objectAtIndex:index-1];
                return next;
            }
        }
    }
    if (!next) {
        next = [self nextResponder];
    }
    return next;
}

- (dispatch_queue_t)_dispatchQueue
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		dispatchUIEventQueue = dispatch_queue_create(dispatchUIEventQueueName, DISPATCH_QUEUE_SERIAL);
	});
	return dispatchUIEventQueue;
}

@end
