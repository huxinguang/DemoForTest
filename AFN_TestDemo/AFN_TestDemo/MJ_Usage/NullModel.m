//
//  NullModel.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/31.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "NullModel.h"

@implementation NullModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
//    NSLog(@"%@",oldValue);
//    NSLog(@"%@",property.type.typeClass);
//    if ([oldValue isEqual:[NSNull class]] ) {
//        NSLog(@"111111111111111111%@",property.name);
//    }
//    if (oldValue == nil){
//        NSLog(@"222222222222222222%@",property.name);
//    }
//    if ([oldValue isEqual:[NSNull null]]){
//        NSLog(@"333333333333333333%@",property.name);
//    }
//    if ([oldValue isKindOfClass:[NSNull class]]){
//        NSLog(@"444444444444444444%@",property.name);
//    }
    NSLog(@"%@",property.type.code);
    if ([oldValue isKindOfClass:[NSNull class]] || oldValue == nil) {
        if (property.type.typeClass) {//表示属性不是基本数据类型
            if ([NSStringFromClass(property.type.typeClass) hasSuffix:@"String"]) {
                return @"";
            }else if ([NSStringFromClass(property.type.typeClass) hasSuffix:@"Array"]){
                return @[];
            }else if ([NSStringFromClass(property.type.typeClass) hasSuffix:@"Dictionary"]){
                return @{};
            }
        }else{//表示属性为基本数据类型或者BOOL类型
            if ([property.type.code isEqualToString:@"i"] || [property.type.code isEqualToString:@"s"] || [property.type.code isEqualToString:@"q"] ) {//int、 short int,  long longlong
                return @0;
            }else if ([property.type.code isEqualToString:@"B"]){//BOOL
                return @NO;
            }else if ([property.type.code isEqualToString:@"f"] || [property.type.code isEqualToString:@"d"]){//float double
                return @0.0;
            }else{
                return @0;
            }
        }
    }
    return oldValue;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"name = %@, age = %d, familyMembers = %@, grades = %@, married = %@, height = %f,weight = %f, timestamp_millisecond = %ld, timestamp_nanosecond = %lld",self.name,self.age,self.familyMembers,self.grades,self.married ? @"YES": @"NO",self.height,self.weight,self.timestamp_millisecond,self.timestamp_nanosecond];
}

@end
