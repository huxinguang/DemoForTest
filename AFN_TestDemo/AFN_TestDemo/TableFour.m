//
//  TableFour.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/10.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "TableFour.h"
#import "InvocationTarget.h"

@implementation TableFour


- (BOOL)respondsToSelector:(SEL)aSelector{
    BOOL rts = [super respondsToSelector:aSelector];
    NSLog(@"respondsToSelector: %@ = %@",NSStringFromSelector(aSelector),rts?@"YES":@"NO");
    return rts;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    BOOL canResolve = [super resolveInstanceMethod:sel];
//    NSLog(@"InstanceMethodName = %s , canResolve = %@",sel_getName(sel),canResolve ? @"YES" : @"NO");
    NSLog(@"ClassMethodName = %@ , canResolve = %@",NSStringFromSelector(sel),canResolve ? @"YES" : @"NO");
    return canResolve;
}

+ (BOOL)resolveClassMethod:(SEL)sel{
    BOOL canResolve = [super resolveClassMethod:sel];
//    NSLog(@"ClassMethodName = %s , canResolve = %@",sel_getName(sel),canResolve ? @"YES" : @"NO");
    NSLog(@"ClassMethodName = %@ , canResolve = %@",NSStringFromSelector(sel),canResolve ? @"YES" : @"NO");
    return canResolve;
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    id object = [super forwardingTargetForSelector:aSelector];
    if (object == nil) {
//        NSLog(@"没有给 %s 方法设置target",sel_getName(aSelector));
        NSLog(@"没有给 %@ 方法设置target",NSStringFromSelector(aSelector));
    }
    return object;
}

/*
 Overridden by subclasses to forward messages to other objects.
 When an object is sent a message for which it has no corresponding method, the runtime system gives the receiver an opportunity to delegate the message to another receiver. It delegates the message by creating an NSInvocation object representing the message and sending the receiver a forwardInvocation: message containing this NSInvocation object as the argument. The receiver’s forwardInvocation: method can then choose to forward the message to another object. (If that object can’t respond to the message either, it too will be given a chance to forward it.)
 The forwardInvocation: message thus allows an object to establish relationships with other objects that will, for certain messages, act on its behalf. The forwarding object is, in a sense, able to “inherit” some of the characteristics of the object it forwards the message to.
 
 
 Important
 To respond to methods that your object does not itself recognize, you must override methodSignatureForSelector: in addition to forwardInvocation:. The mechanism for forwarding messages uses information obtained from methodSignatureForSelector: to create the NSInvocation object to be forwarded. Your overriding method must provide an appropriate method signature for the given selector, either by pre formulating one or by asking another object for one.
 An implementation of the forwardInvocation: method has two tasks:
 
     To locate an object that can respond to the message encoded in anInvocation. This object need not be the same for all messages.
     To send the message to that object using anInvocation. anInvocation will hold the result, and the runtime system will extract and deliver this result to the original sender.
 
 In the simple case, in which an object forwards messages to just one destination (such as the hypothetical friend instance variable in the example below), a forwardInvocation: method could be as simple as this:
 
 
     - (void)forwardInvocation:(NSInvocation *)invocation
     {
         SEL aSelector = [invocation selector];
 
         if ([friend respondsToSelector:aSelector])
         [invocation invokeWithTarget:friend];
         else
         [super forwardInvocation:invocation];
     }
 
 The message that’s forwarded must have a fixed number of arguments; variable numbers of arguments (in the style of printf()) are not supported.
 The return value of the forwarded message is returned to the original sender. All types of return values can be delivered to the sender: id types, structures, double-precision floating-point numbers.
 Implementations of the forwardInvocation: method can do more than just forward messages. forwardInvocation: can, for example, be used to consolidate code that responds to a variety of different messages, thus avoiding the necessity of having to write a separate method for each selector. A forwardInvocation: method might also involve several other objects in the response to a given message, rather than forward it to just one.
 NSObject’s implementation of forwardInvocation: simply invokes the doesNotRecognizeSelector: method; it doesn’t forward any messages. Thus, if you choose not to implement forwardInvocation:, sending unrecognized messages to objects will raise exceptions.


 */


- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL aSelector = anInvocation.selector;
    InvocationTarget *target = [InvocationTarget shareTarget];
    if ([target respondsToSelector:aSelector]) {
        [anInvocation invokeWithTarget:target];

    }
    else
        [super forwardInvocation:anInvocation];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
//    NSString *methodName = [NSString stringWithFormat:@"%s",sel_getName(aSelector)];
    NSString *methodName = NSStringFromSelector(aSelector);
    
    if ([methodName isEqualToString:@"test:"]) {
        NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        return methodSignature;
    }
    else
    return [super methodSignatureForSelector:aSelector];
}



@end
