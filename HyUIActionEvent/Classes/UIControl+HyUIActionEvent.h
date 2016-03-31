//
//  UIControl+HyUIActionEvent.h
//
//  Created by HyanCat on 16/3/31.
//  Copyright © 2016年 hyancat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (HyUIActionEvent)

@property (nullable, nonatomic, copy) NSString *eventName;
@property (nullable, nonatomic, copy) NSDictionary *eventUserInfo;

@end

NS_ASSUME_NONNULL_END
