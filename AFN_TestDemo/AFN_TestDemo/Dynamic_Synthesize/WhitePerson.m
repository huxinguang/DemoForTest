//
//  WhitePerson.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/5.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "WhitePerson.h"

@implementation WhitePerson
@dynamic robot;//和BlackPerson中不同的是，WhitePerson中声明了跟父类同名的robot属性。在子类中声明和父类相同的属性，编译器会报警告 Auto property synthesis will not synthesize property 'responseSerializer'; it will be implemented by its superclass, use @dynamic to acknowledge intention。 因为父类@property已经自动生成了setter和getter方法，而且这两个方法会被子类继承，如果子类又用@property声明一个同名的属性，那么意味着又要生成setter和getter方法，编译器就无法明白真实的意图，所以子类的属性用@dynamic修饰，意思是不用编译器自动生成setter和getter方法，通常这样做的目的是

-(void)setRobot:(Robot<ProtocalFileTest> *)robot{
    [super setRobot:robot];
}

@end
