//
//  Dog.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/2.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "Dog.h"
#import "MJExtension.h"

@implementation Dog

+(id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    // nickName -> nick_name
    return [propertyName mj_underlineFromCamel];
}

@end

