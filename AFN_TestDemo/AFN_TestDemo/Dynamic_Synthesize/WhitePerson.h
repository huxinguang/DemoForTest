//
//  WhitePerson.h
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/5.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "Person.h"
#import "Robot.h"
#import "ProtocalFileTest.h"

@interface WhitePerson : Person
@property (nonatomic, strong) Robot<ProtocalFileTest> *robot;
@end
