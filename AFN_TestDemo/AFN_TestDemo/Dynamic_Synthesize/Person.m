//
//  Person.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/5.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "Person.h"

@interface Person(){
    
    NSString *_address;
}

@end

@implementation Person{
    NSString *_country;
}

/*
 @dynamic告诉编译器,属性的setter与getter方法由用户自己实现，不自动生成。（当然对于readonly的属性只需提供getter即可）。假如一个属性被声明为@dynamic var，然后你没有提供@setter方法和@getter方法，编译的时候没问题，但是当程序运行到instance.var =someVar，由于缺setter方法会导致程序崩溃；或者当运行到 someVar = var时，由于缺getter方法同样会导致崩溃。编译时没问题，运行时才执行相应的方法，这就是所谓的动态绑定。
 
 但是如果父类(Person)中的属性(robot)没有被@dynamic标记，但在子类(BlackPerson)中robot用@dynamic标记，那么即使BlackPerson类中没有实现相应的setter和getter方法，在访问setter和getter方法时也不会报错，因为子类中没有方法的话就会到父类中寻找同名方法。
 
 */
@dynamic name;


@end
