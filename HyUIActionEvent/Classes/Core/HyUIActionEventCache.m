//
//  HyUIActionEventCache.m
//  HyUIActionEvent
//
//  Created by HyanCat on 2018/7/13.
//

#import "HyUIActionEventCache.h"

@interface HyUIActionEventMemoryCache ()
@property (atomic, strong) NSMutableDictionary <NSString *, NSMutableArray <UIResponder *>*> *dict;
@end

@implementation HyUIActionEventMemoryCache

+ (instancetype)sharedCache
{
    static dispatch_once_t onceToken;
    static HyUIActionEventMemoryCache *cache;
    dispatch_once(&onceToken, ^{
        cache = [[HyUIActionEventMemoryCache alloc] init];
    });
    return cache;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSArray<UIResponder *> *)cachedRespondersForEventName:(NSString *)eventName
{
    return [[_dict objectForKey:eventName] copy];
}

- (void)cacheResponder:(__kindof UIResponder *)responder forEventName:(NSString *)eventName
{
    NSMutableArray *responders = [_dict objectForKey:eventName];
    if (responders) {
        [responders addObject:responder];
    } else {
        responders = [NSMutableArray arrayWithObject:responder];
        [_dict setObject:responders forKey:eventName];
    }
}

- (void)clean
{
    [_dict removeAllObjects];
}

@end
