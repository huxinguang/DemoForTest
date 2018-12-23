//
//  BlackPerson.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/5.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "BlackPerson.h"



@implementation BlackPerson

@dynamic robot;//和WhitePerson中不同的是，在BlackPerson中没有声明跟父类同名的robot属性

/*
 成员变量用于类内部，无需与外界接触的变量。成员变量默认是protected，一般情况下，非子类对象无法访问
 因为成员变量不会生成set、get方法，所以外界无法与成员变量接触
 成员变量是定义在｛｝号中的变量，如果变量的数据类型是一个类则称这个变量为实例变量。
 因为实例变量是成员变量的一种特殊情况，所以实例变量也是类内部使用的，无需与外部接触的变量，这个也就是所谓的类私有变量。
 */


//虽然robot用了@dynamic修饰，但由于父类的robot没有被@dynamic修饰，所以即使自己没有实现robot属性的setter/getter方法，在调用setter/getter时也不会报错
//这里写setter只是为了测试能否访问父类生成的实例变量_robot
-(void)setRobot:(Robot<ProtocalFileTest> *)robot{
    //    _robot =   //不能访问
    //    @property生成了私有的带下划线的的成员变量,子类不可以直接访问，但是可以通过get/set方法访问。那么如果想让定义的成员变量让子类直接访问那么只能在.h文件中定义成员变量了，因为它默认是@protected,比如下面attemptToAccessInstanceVariable方法中可以访问父类的成员变量_gender
    [super setRobot:robot];
}


- (void)attemptToAccessInstanceVariable{
    self->_gender = @"男";
    _gender = @"男"; //子类的方法中可以访问父类位于接口文件（.h）中声明的成员变量
//    _country =    //子类的方法中不可以访问父类位于接口文件（.m）中声明的成员变量@implementation
//    _address =    //子类的方法中不可以访问父类位于接口文件（.m）中声明的成员变量@interface
}


@end
