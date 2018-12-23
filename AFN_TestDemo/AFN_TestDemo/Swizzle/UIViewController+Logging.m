//
//  UIViewController+Logging.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/11.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "UIViewController+Logging.h"
#import "LogUtil.h"
#import <objc/runtime.h>

@implementation UIViewController (Logging)

+ (void)load
{
    swizzleMethod([self class], @selector(viewDidAppear:), @selector(swizzled_viewDidAppear:));
}

- (void)swizzled_viewDidAppear:(BOOL)animated{
    
    [self swizzled_viewDidAppear:animated];
    
    [LogUtil logWithEventName:[NSString stringWithFormat:@"调用了%@的viewDidAppear方法",NSStringFromClass([self class])]];
    
}


void swizzleMethod(Class class,SEL originalSelector, SEL swizzledSelector){
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    /*
     Adds a new method to a class with a given name and implementation.
     
     BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types);
     
     
     class_addMethod will add an override of a superclass's implementation, but will not replace an existing implementation in this class.
     
     Return value
     YES if the method was added successfully, otherwise NO (for example, the class already contains a method implementation with that name).
     */
    

    /*
     这里唯一可能需要解释的是 class_addMethod 。要先尝试添加 原selector 是为了做一层保护，因为如果这个类没有实现 originalSelector ，但其父类实现了，那 class_getInstanceMethod 会返回父类的方法。这样 method_exchangeImplementations 替换的是父类的那个方法，这当然不是你想要的。所以我们先尝试添加 orginalSelector ，如果已经存在，再用 method_exchangeImplementations 把原方法的实现跟新的方法实现给交换掉。
    
     */
    // class_addMethod will fail if original method already exists
    // class_addMethod will add an override of a superclass's implementation, but will not replace an existing implementation in this class.
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    NSLog(@"%@ didAddMethod = %@",NSStringFromClass(class),didAddMethod ? @"Yes":@"No");
    
    if (didAddMethod) {
        //如果上面添加方法成功，证明该类并没有实现originalSelector，那么class_addMethod就添加了一个方法名为originalSelector，但实现为method_getImplementation(swizzledMethod) 的方法。
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}


@end
