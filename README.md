# HyUIActionEvent

> An elegant way to handle UI action events based on UIResponder.

[Swift version](https://github.com/HyanCat/UIActionKit)

## Installation

By using Cocoapods, Add library in your `Podfile`.

    pod 'HyUIActionEvent'

## Usage

1. Event.

    The event class named `HyUIActionEvent`.
    You can create an event object manually and then dispatch it.

    By another way, it provide a property `eventName` for `UIView` and `UIControl`. After assigned the `eventName` property, an event object also been associated to this target.

2. Dispatch event.

    ```objectivec
    HyUIActionEvent *event = [HyUIActionEvent eventWithName:@"eventNameA" object:objOrNil userInfo:@{@"key1": @"value1"}];
    [someObject dispatchHyUIActionEvent:event];
    ```

    If, we just want to add a tap on a view, or a touch event on a button.

    ```objectivec
    someView.eventName = @"eventNameA";
    soneView.eventUserInfo = @{@"key1": @"value1"};	// Optional.
    ```

3. Handle event.

    Actually, We can handle events in any class inherited from `UIResponder`, but by sugguestion, you should always handle events in a view controller.

    ```objectivec
    // handle an event by construct a method.
    // handle{$eventName}WithActionEvent:
    // return a HyUIActionEventResult object, it provide a boolean value that tell the respond chain whether should continue dispatching event or not.
    - (HyUIActionEventResult *)handleEventNameAWithActionEvent:(HyUIActionEvent *)actionEvent {
    	// some code here...
    	return [HyUIActionEventResult resultWithContinueDispatching:NO];	// So this event will not be past.
    }
    ```

## License

[MIT License](https://github.com/HyanCat/HyUIActionEvent/blob/master/LICENSE)
