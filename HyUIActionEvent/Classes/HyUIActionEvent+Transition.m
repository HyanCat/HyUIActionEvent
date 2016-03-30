//
//  HyUIActionEvent+Transition.m
//
//  Created by HyanCat on 16/3/30.
//  Copyright © 2016年 HyanCat. All rights reserved.
//

#import "HyUIActionEvent+Transition.h"

NSString *const kHyUITransitionName = @"transition";

NSString *const kHyUITransitionType                            = @"hyUITransitionType";
NSString *const kHyUITransitionIsAnimated                      = @"hyUITransitionIsAnimated";
NSString *const kHyUITransitionCompletionBlock                 = @"hyUITransitionCompletionBlock";
NSString *const kHyUITransitionToViewControllerURL             = @"hyUITransitionToViewControllerURL";
NSString *const kHyUITransitionToViewControllerInstanceMethod  = @"hyUITransitionToViewControllerInstance";
NSString *const kHyUITransitionToViewControllerInstanceObjects = @"hyUITransitionToViewControllerInstanceObjects";
NSString *const kHyUITransitionToViewControllerInfo            = @"hyUITransitionToViewControllerInfo";

@implementation HyUIActionEvent (Transition)


+ (instancetype)eventWithTransitionTypeBackAnimated:(BOOL)animated
{
	return [self eventWithTransitionType:HyUITransitionTypeBack animated:animated completion:nil toViewControllerURL:nil toViewControllerValues:nil];
}
+ (instancetype)eventWithTransitionTypeDismissAnimated:(BOOL)animated
{
	return [self eventWithTransitionType:HyUITransitionTypeDismiss animated:animated completion:nil toViewControllerURL:nil toViewControllerValues:nil];
}
+ (instancetype)eventWithTransitionTypeDisAppearAnimated:(BOOL)animated
{
	return [self eventWithTransitionType:HyUITransitionTypeDisAppear animated:animated completion:nil toViewControllerURL:nil toViewControllerValues:nil];
}
+ (instancetype)eventWithTransitionTypeBackToRootAnimated:(BOOL)animated
{
	return [self eventWithTransitionType:HyUITransitionTypeBackToRoot animated:animated completion:nil toViewControllerURL:nil toViewControllerValues:nil];
}
+ (instancetype)eventWithTransitionTypeRemoveBelow
{
	return [self eventWithTransitionType:HyUITransitionTypeRemoveBelow animated:NO completion:nil toViewControllerURL:nil toViewControllerValues:nil];
}
+ (instancetype)eventWithTransitionTypeRemoveBelowAll
{
	return [self eventWithTransitionType:HyUITransitionTypeRemoveBelowAll animated:NO completion:nil toViewControllerURL:nil toViewControllerValues:nil];
}

+ (instancetype)eventWithTransitionType:(HyUITransitionType)type
							   animated:(BOOL)animated
							 completion:(HyUITransitionCompletionBlock)completion
					toViewControllerURL:(NSString *)toViewControllerURL
				 toViewControllerValues:(NSDictionary *)toViewControllerValues
{
	NSDictionary *userInfo = [self makeUserInfoWithTransitionType:type
														 animated:animated
													   completion:completion
											  toViewControllerURL:toViewControllerURL
								   toViewControllerInstanceMethod:nil
								  toViewControllerInstanceObjects:nil
										   toViewControllerValues:toViewControllerValues];
	
	return [self eventWithName:kHyUITransitionName object:nil userInfo:userInfo];
}

+ (instancetype)eventWithTransitionType:(HyUITransitionType)type
							   animated:(BOOL)animated
							 completion:(HyUITransitionCompletionBlock)completion
					toViewControllerURL:(NSString *)toViewControllerURL
		 toViewControllerInstanceMethod:(SEL)toViewControllerInstanceMethod
		toViewControllerInstanceObjects:(NSArray *)toViewControllerInstanceObjects
				 toViewControllerValues:(NSDictionary *)toViewControllerValues
{
	NSDictionary *userInfo = [self makeUserInfoWithTransitionType:type
														 animated:animated
													   completion:completion
											  toViewControllerURL:toViewControllerURL
								   toViewControllerInstanceMethod:toViewControllerInstanceMethod
								  toViewControllerInstanceObjects:toViewControllerInstanceObjects
										   toViewControllerValues:toViewControllerValues];
	
	return [self eventWithName:kHyUITransitionName object:nil userInfo:userInfo];
}

- (HyUITransitionType)transitionType
{
	return [[self.userInfo valueForKey:kHyUITransitionType] integerValue];
}
- (BOOL)transitionIsAnimated
{
	return [[self.userInfo valueForKey:kHyUITransitionIsAnimated] boolValue];
}
- (HyUITransitionCompletionBlock)transitionCompletionBlock
{
	return [self.userInfo valueForKey:kHyUITransitionCompletionBlock];
}
- (NSString *)transitionToViewControllerURL
{
	return [self.userInfo valueForKey:kHyUITransitionToViewControllerURL];
}
- (SEL)transitionToViewControllerInstanceMethod
{
	return NSSelectorFromString([self.userInfo valueForKey:kHyUITransitionToViewControllerInstanceMethod]);
}
- (NSArray *)transitionToViewControllerInstanceObjects
{
	return [self.userInfo valueForKey:kHyUITransitionToViewControllerInstanceObjects];
}
- (NSDictionary *)transitionToViewControllerInfo
{
	return [self.userInfo valueForKey:kHyUITransitionToViewControllerInfo];
}

+ (NSDictionary *)makeUserInfoWithTransitionType:(HyUITransitionType)type
										animated:(BOOL)animated
									  completion:(HyUITransitionCompletionBlock)completion
							 toViewControllerURL:(NSString * _Nonnull)toViewControllerURL
				  toViewControllerInstanceMethod:(SEL)toViewControllerInstanceMethod
				 toViewControllerInstanceObjects:(NSArray *)toViewControllerInstanceObjects
						  toViewControllerValues:(NSDictionary *)toViewControllerValues
{
	NSMutableDictionary *userInfo = [@{kHyUITransitionType: @(type),
									   kHyUITransitionIsAnimated: @(animated),
									   } mutableCopy];
	[userInfo setValue:completion forKey:kHyUITransitionCompletionBlock];
	[userInfo setValue:toViewControllerURL forKey:kHyUITransitionToViewControllerURL];
	[userInfo setValue:NSStringFromSelector(toViewControllerInstanceMethod) forKey:kHyUITransitionToViewControllerInstanceMethod];
	[userInfo setValue:toViewControllerInstanceObjects forKey:kHyUITransitionToViewControllerInstanceObjects];
	[userInfo setValue:toViewControllerValues forKey:kHyUITransitionToViewControllerInfo];
	
	return userInfo;
}

@end
