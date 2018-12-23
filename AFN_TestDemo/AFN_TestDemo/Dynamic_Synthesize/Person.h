//
//  Person.h
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/5.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocalFileTest.h"
#import "Robot.h"

#warning ****Difference between Property 、Instance Variable 、Member Variable ****

/*
   实例的英文翻译为Instance(manifestation  of a  class)  说的是“类的表现”，说明实例变量应该是由类定义的变量
 
   实例变量首先得是一个对象，像int float double等基本数据类型，没有类的概念，无法称之为实例，所以不是实例变量。
 成员变量包括实例变量，在@interface或者@implementation后的{}中的都是成员变量，除了基本数据类型的之外，可称之为实例变量。
 
 */

@interface Person : NSObject{
    
    NSString *_gender;//成员变量，实例变量
    int _age;//成员变量
}
@property (nonatomic, strong)Robot <ProtocalFileTest> *robot;
@property (nonatomic, copy)NSString *name;


@end
