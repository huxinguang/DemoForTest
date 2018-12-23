//
//  NullModel.h
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/31.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NullModel : NSObject
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) int age;
@property (assign, nonatomic) short int shortAge;
@property (assign, nonatomic) long int longAge;
@property (strong, nonatomic) NSArray *familyMembers;
@property (strong, nonatomic) NSDictionary *grades;
@property (assign, nonatomic) BOOL married;
@property (assign, nonatomic) float height;
@property (assign, nonatomic) double weight;
@property (assign, nonatomic) long timestamp_millisecond;
@property (assign, nonatomic) long long timestamp_nanosecond;
@property (assign, nonatomic) char content;

@end
