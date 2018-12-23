//
//  NSObject+NullSafeOne.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/23.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "NSObject+NullSafeOne.h"

@implementation NSObject (NullSafeOne)

//void swizzleMethodTest(Class cls, SEL originalSelector, SEL swizzledSelector){
//    
//    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
//    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
//    
//    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//    if (didAddMethod) {
//        
//        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//    }else{
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
//    
//}

@end
