//
//  HyUIActionEventCache.h
//  HyUIActionEvent
//
//  Created by HyanCat on 2018/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HyUIActionEventCachable <NSObject>

- (NSArray <__kindof UIResponder *> * _Nullable)cachedRespondersForEventName:(NSString *)eventName;

- (void)cacheResponder:(__kindof UIResponder *)responder forEventName:(NSString *)eventName;

- (void)clean;

@end

@interface HyUIActionEventMemoryCache : NSObject <HyUIActionEventCachable>

+ (instancetype)sharedCache;

@end

NS_ASSUME_NONNULL_END
