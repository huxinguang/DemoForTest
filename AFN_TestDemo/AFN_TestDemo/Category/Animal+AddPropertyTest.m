//
//  Animal+AddPropertyTest.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/9.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "Animal+AddPropertyTest.h"

@implementation Animal (AddPropertyTest)
//报警告
//Property 'age' requires method 'age' to be defined - use @dynamic or provide a method implementation in this category
//Property 'age' requires method 'setAge:' to be defined - use @dynamic or provide a method implementation in this category

//如果像下面这样手动添加age 的setter/getter 方法，会发现获取不到age属性对应的成员变量_age,这样就没法添加setter/getter方法

//-(void)setAge:(int)age{
//    if (_age != age) {
//        _age = age;
//    }
//}
//
//-(int)age{
//    return _age;
//}

@end
