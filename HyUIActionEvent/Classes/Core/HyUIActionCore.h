//
//  HyUIActionCore.h
//
//  Created by HyanCat on 16/3/30.
//  Copyright © 2016年 hyancat. All rights reserved.
//

#ifndef HyUIActionCore_h
#define HyUIActionCore_h

#import <HyUIActionEvent/HyUIActionEvent.h>
#import <HyUIActionEvent/HyUIActionEventResult.h>
#import <HyUIActionEvent/UIResponder+HyUIActionEvent.h>
#import <HyUIActionEvent/UIControl+HyUIActionEvent.h>
#import <HyUIActionEvent/UIView+HyUIActionEvent.h>

/**
 We have two ways to handle the event easily.

 First way is like:

 ```ObjectiveC
 HyUIActionHandler(ClickEventA, {
    // Your code here...
    return NO;
 })
 ```

 Another way is like:

 ```ObjectiveC
 HyUIActionHandlerBegin(ClickEventA) {
    // Your code here...
    HyUIActionHandlerEnd(NO)
 }
 ```
 */

#define HyUIActionHandler(name, block) \
- (HyUIActionEventResult *)handle##name##WithActionEvent:(HyUIActionEvent *)event { \
    BOOL (^handlerBlock)(HyUIActionEvent *) = ^(HyUIActionEvent *event) block; \
    BOOL continueDispatching = handlerBlock(event); \
    return [HyUIActionEventResult resultWithContinueDispatching:continueDispatching]; \
}


#define HyUIActionHandlerBegin(name) \
- (HyUIActionEventResult *)handle##name##WithActionEvent:(HyUIActionEvent *)event

#define HyUIActionHandlerEnd(continue) \
return [HyUIActionEventResult resultWithContinueDispatching:continue];

#endif /* HyUIActionCore_h */
