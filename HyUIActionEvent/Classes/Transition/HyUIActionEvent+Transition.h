//
//  HyUIActionEvent+Transition.h
//
//  Created by HyanCat on 16/3/30.
//  Copyright © 2016年 HyanCat. All rights reserved.
//

#import "HyUIActionEvent.h"

extern NSString *const kHyUITransitionName;

extern NSString *const kHyUITransitionType;
extern NSString *const kHyUITransitionIsAnimated;
extern NSString *const kHyUITransitionCompletionBlock;
extern NSString *const kHyUITransitionToViewControllerURL;
extern NSString *const kHyUITransitionToViewControllerInstanceMethod;
extern NSString *const kHyUITransitionToViewControllerInstanceObjects;
extern NSString *const kHyUITransitionToViewControllerInfo;

typedef NS_ENUM(NSUInteger, HyUITransitionType) {
	HyUITransitionTypeNone = 0,			// 普通展现
	HyUITransitionTypePush,				// Push
	HyUITransitionTypePresent,			// Present
	
	HyUITransitionTypeBack,				// 返回 (单个页面 pop or dismiss)
	HyUITransitionTypeDismiss,			// 返回（返回到 present 之前的页面）
	HyUITransitionTypeDisAppear,			// 返回（返回到 present 之前的页面）
	
	HyUITransitionTypeInsertBelow,		// 在当前页面的底部新增页面
	HyUITransitionTypeRemoveBelow,		// 移除当前页面底部的页面
	HyUITransitionTypeRemoveBelowAll,	// 移除当前页面底部的所有页面
	HyUITransitionTypeBackToRoot,		// 返回到 RootViewController
};
typedef void (^HyUITransitionCompletionBlock)(void);


@interface HyUIActionEvent (Transition)

+ (instancetype)eventWithTransitionTypeBackAnimated:(BOOL)animated;
+ (instancetype)eventWithTransitionTypeDismissAnimated:(BOOL)animated;
+ (instancetype)eventWithTransitionTypeDisAppearAnimated:(BOOL)animated;
+ (instancetype)eventWithTransitionTypeBackToRootAnimated:(BOOL)animated;
+ (instancetype)eventWithTransitionTypeRemoveBelow;
+ (instancetype)eventWithTransitionTypeRemoveBelowAll;


/**
 * 定义转场事件
 *
 * @param type                   转场类型
 * @param animated               是否动画
 * @param completion             转场结束 block
 * @param toViewControllerURL    需要转到的 ViewController（格式为：toViewControllerName?[xx]=[xx]&[xx]=[xx]）
 * @param toViewControllerValues ViewController的属性值
 *
 * @return HyUIActionEvent Instance Object
 */
+ (instancetype)eventWithTransitionType:(HyUITransitionType)type
							   animated:(BOOL)animated
							 completion:(HyUITransitionCompletionBlock)completion
					toViewControllerURL:(NSString *)toViewControllerURL
				 toViewControllerValues:(NSDictionary *)toViewControllerValues;


/**
 * 定义转场事件
 *
 * @param type                            转场类型
 * @param animated                        是否动画
 * @param completion                      转场结束 block
 * @param toViewControllerURL             需要转到的 ViewController（格式为：toViewControllerName?[xx]=[xx]&[xx]=[xx]）
 * @param toViewControllerInstanceMethod  构造 ViewController 的实例方法（这里必须为静态实例方法）
 * @param toViewControllerInstanceObjects 构造 ViewController 的实例方法参数
 * @param toViewControllerValues          ViewController 的属性值
 *
 * @return HyUIActionEvent Instance Object
 */
+ (instancetype)eventWithTransitionType:(HyUITransitionType)type
							   animated:(BOOL)animated
							 completion:(HyUITransitionCompletionBlock)completion
					toViewControllerURL:(NSString *)toViewControllerURL
		 toViewControllerInstanceMethod:(SEL)toViewControllerInstanceMethod
		toViewControllerInstanceObjects:(NSArray *)toViewControllerInstanceObjects
				 toViewControllerValues:(NSDictionary *)toViewControllerValues;

- (HyUITransitionType)transitionType;
- (BOOL)transitionIsAnimated;
- (HyUITransitionCompletionBlock)transitionCompletionBlock;
- (NSString *)transitionToViewControllerURL;
- (SEL)transitionToViewControllerInstanceMethod;
- (NSArray *)transitionToViewControllerInstanceObjects;
- (NSDictionary *)transitionToViewControllerInfo;

@end
