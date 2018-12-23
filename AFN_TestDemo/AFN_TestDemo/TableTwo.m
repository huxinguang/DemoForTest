//
//  TableTwo.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/29.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "TableTwo.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

@implementation TableTwo

//An Objective-C method is simply a C function that take at least two arguments—self and _cmd.
void dynamicInstanceMethodIMP(id self, SEL _cmd){
    NSLog(@"动态添加的实例方法resolveThisMethodDynamically解析成功");
}

//不能这样写
//- (void)dynamicMethodIMP{
//    NSLog(@"动态添加的实例方法resolveThisMethodDynamically解析成功");
//}


//此方法只会在runtime找不到resolveThisMethodDynamically这个方法时才会调用，如果像下面那样添加一个resolveThisMethodDynamically方法，那就不会调用此方法了,或者父类中有resolveThisMethodDynamically的实现，也不会调用此方法
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(resolveInstanceMethodDynamically)) {
        /*
         https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
         
         第一个字符v 表示返回值为void，剩余的字符为dynamicMethodIMP 函数的参数描述，@表示第一个参数id，:自然就是第二个参数SEL,由于前面说过动态方法的实现的前两个参数必须是id、SEL，所以第四个参数中的字符串的第二、三个字符一定是@:
         */
        
        class_addMethod([self class], sel, (IMP)dynamicInstanceMethodIMP, "v@:");
        return YES;
        
    }
    return [super resolveInstanceMethod:sel];
}


//- (void)resolveInstanceMethodDynamically{
//    NSLog(@"直接调用方法");
//}


//注意如果有返回值，一定要用id类型的,id类型有对应的Type Encoding @，如果用int，那么由于perfomSelector的返回值为id类型，是个对象，用int返回给id会报错
id dynamicClassMethodIMP(id self, SEL _cmd,NSString *a){
    NSLog(@"动态添加的类方法resolveClassMethodDynamically解析成功");
    return [NSString stringWithFormat:@"%@xxxx",a];
}


+(BOOL)resolveClassMethod:(SEL)sel{
    NSString *methodName = NSStringFromSelector(sel);
    Class metaClass = objc_getMetaClass("TableTwo");
    if ([methodName isEqualToString:@"resolveClassMethodDynamically:"]) {
        class_addMethod(metaClass, sel, (IMP)dynamicClassMethodIMP, "@@:@");
        return YES;
    }
    return [super resolveClassMethod:sel];
}



#pragma clang diagnostic pop
@end
