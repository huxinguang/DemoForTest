//
//  TableThree.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/10.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "TableThree.h"
#import "SelectorReceiver.h"

@implementation TableThree

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    BOOL canResolve = [super resolveInstanceMethod:sel];
//    NSLog(@"InstanceMethodName = %s , canResolve = %@",sel_getName(sel),canResolve ? @"YES" : @"NO");
    NSLog(@"InstanceMethodName = %@ , canResolve = %@",NSStringFromSelector(sel),canResolve ? @"YES" : @"NO");
    return canResolve;
}

+ (BOOL)resolveClassMethod:(SEL)sel{
    BOOL canResolve = [super resolveClassMethod:sel];
//    NSLog(@"ClassMethodName = %s , canResolve = %@",sel_getName(sel),canResolve ? @"YES" : @"NO");
    NSLog(@"ClassMethodName = %@ , canResolve = %@",NSStringFromSelector(sel),canResolve ? @"YES" : @"NO");
    return canResolve;
}

/*
 
 Returns the object to which unrecognized messages should first be directed.
 
 - (id)forwardingTargetForSelector:(SEL)aSelector;
 
 aSelector
 A Selector for a method that the receiver does not implement.
 
 Return Value
 The object to which unrecognized messages should first be directed.
 
 Discussion
 If an object implements (or inherits) this method, and returns a non-nil (and non-self) result, that returned object is used as the new receiver object and the message dispatch resumes to that new object. (Obviously if you return self from this method, the code would just fall into an infinite loop.)
 
 If you implement this method in a non-root class, if your class has nothing to return for the given selector then you should return the result of invoking super’s implementation.
 
 This method gives an object a chance to redirect an unknown message sent to it before the much more expensive forwardInvocation: machinery takes over. This is useful when you simply want to redirect messages to another object and can be an order of magnitude faster than regular forwarding. It is not useful where the goal of the forwarding is to capture the NSInvocation, or manipulate the arguments or return value during the forwarding.
 
 //返回值不能为self,否则会出现死循环
 
 */

- (id)forwardingTargetForSelector:(SEL)aSelector{
//    NSString *methodName = [NSString stringWithFormat:@"%s",sel_getName(aSelector)];
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"notExistInstanceMethod"]) {
        return [SelectorReceiver shareReceiver];
    }
    
    //If you implement this method in a non-root class, if your class has nothing to return for the given selector then you should return the result of invoking super’s implementation.
    return [super forwardingTargetForSelector:aSelector];
}


//题外话： 这里正好测试一下返回值id类型和instancetype类型的区别。
/*
    假如shareReceiver方法的返回值类型用id,那我们像下面test方法中直接初始化调用addObject方法,不会报警，编译也能通过（当然，前提是这个方法是某个对象的方法，可以是自定义类的实例对象，也可以是系统类的实例对象）。
    但如果shareReceiver方法的返回值类型用instancetype,那么直接初始化调用addObject就会立即报错。
 
 原因：
 
 使用instancetype作为返回值类型，那么方法在哪个类就返回值类型就是对应类的类型，这时调用addObject方法编译器就会到SelectorReceiver中（或它的父类）找是否存在该方法，显然SelectorReceiver类和其父类都没有这个方法，所以编译器会报错。
 
 使用id作为返回值类型,那么用id类型的对象调用addObject方法，因为id可以代表任何类型，而NSArray类型的对象是存在这个方法的，所以编译器会认为[SelectorReceiver shareReceiver]的值是一个NSArray类型的对象，所以编译期是不会报错的，但如果到了运行期，runtime找不到addObject方法，就会出现-[SelectorReceiver addObject:]: unrecognized selector sent to instance 0x60000042a980
 
 结论：使用instancetype作为返回值类型,在下面这种初始化后直接调用某方法时，会帮助我们进行检查。
 
 */
- (void)test{
   
//    [[SelectorReceiver shareReceiver] addObject:@""];
}


@end
