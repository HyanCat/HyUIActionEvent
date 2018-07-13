//
//  HyUIActionEvent.h
//
//  Created by HyanCat on 16/3/30.
//  Copyright © 2016年 hyancat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HyUIActionEvent;
HyUIActionEvent *HyUIEvent(NSString *name, id _Nullable object, NSDictionary * _Nullable userInfo);

@interface HyUIActionEvent : NSObject

+ (instancetype)eventWithName:(NSString *)name;
+ (instancetype)eventWithName:(NSString *)name object:(nullable id)object;
+ (instancetype)eventWithName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

@property (nonatomic, copy, readonly) NSString *eventName;
@property (nullable, nonatomic, strong, readonly) id eventObject;
@property (nullable, nonatomic, copy, readonly) NSDictionary *userInfo;

@end

NS_ASSUME_NONNULL_END