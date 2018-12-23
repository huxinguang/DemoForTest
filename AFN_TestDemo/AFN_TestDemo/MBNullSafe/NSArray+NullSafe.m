//
//  NSArray+NullSafe.m
//  Pods
//
//  Created by ManoBoo on 2017/6/30.
//
//

#import "NSArray+NullSafe.h"

#import "NSObject+NullSafe.h"


@implementation NSArray (NullSafe)
/*
 
 + (void)load;
 
 Invoked whenever a class or category is added to the Objective-C runtime; implement this method to perform class-specific behavior upon loading.
 The load message is sent to classes and categories that are both dynamically loaded and statically linked, but only if the newly loaded class or category implements a method that can respond.
 
 In addition:
 A class’s +load method is called after all of its superclasses’ +load methods.
 A category +load method is called after the class’s own +load method.
 
 
 重写 +load 方法时，没有必要显式调用其父类的方法。
 
 */

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safe_objectAtIndex:)];
    });
}

#pragma mark - Method

- (id)safe_objectAtIndex: (NSUInteger)index {
    if (index < self.count) {
        return [self safe_objectAtIndex:index];
    }else {
        NSLog(@"[NSArray objectAtIndex: index], index is beyond bounds");
        return nil;
    }
}

@end

