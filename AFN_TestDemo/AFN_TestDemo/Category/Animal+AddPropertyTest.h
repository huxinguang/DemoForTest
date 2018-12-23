//
//  Animal+AddPropertyTest.h
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/9.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "Animal.h"

@interface Animal (AddPropertyTest)

@property (nonatomic, assign)int age;//此属性会被加入到属性列表，即使用class_copyPropertyList可以获取到

@end
