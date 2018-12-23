//
//  Car.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/27.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "Car.h"

/*
 
 先要搞清楚属性和成员变量的关系：
 
    这个链接讲的很好： https://blog.csdn.net/addychen/article/details/39525681
 
 */



/*
    @synthesize 的使用
 
 As mentioned earlier, the default behavior for a writeable property is to use an instance variable called _propertyName.
 
 If you wish to use a different name for the instance variable, you need to direct the compiler to synthesize the variable using the following syntax in your implementation:
 
 @implementation YourClass
 @synthesize propertyName = instanceVariableName;
 ...
 @end
 
 For example:
 
 @interface YourClass : NSObject
 @property(nonatomic,copy)NSString *firstName;
 @end
 
 @implementation YourClass
 @synthesize firstName = customFirstName;
 ...
 @end
 
In this case, the property will still be called firstName, and be accessible through firstName and setFirstName: accessor methods or dot syntax, but it will be backed by an instance variable called customFirstName.
 
 
 Important: If you use @synthesize without specifying an instance variable name, like this:
 @synthesize firstName;
 the instance variable will bear the same name as the property.
 In this example, the instance variable will also be called firstName, without an underscore.
 
 
 
 iOS 6 之后 LLVM 编译器引入property autosynthesis，即属性自动合成。换句话说，就是编译器会为每个 @property 添加 @synthesize ，如以下形式：
 
 @synthesize propertyName = _propertyName;
 
 这行代码会创造一个带下划线前缀的实例变量名，同时使用这个属性生成getter 和 setter 方法。
 
 使用@synthesize 只有一个目的——给实例变量起个别名，或者说为同一个变量添加两个名字。
 
 如果要阻止自动合成，记得使用 @dynamic 。经典的使用场景是你知道已经在某处实现了getter/setter 方法，而编译器不知道的情况。
 (此处我的理解是为了防止编译器使用自动合成生成新的setter／getter 会覆盖已经存在的旧的 setter／getter)
 
 
 1.@synthesize 的作用:是为属性添加一个实例变量名，或者说别名。同时会为该属性生成 setter/getter 方法（在你自己没有实现setter/getter方法的情况下）。
 2.禁止@synthesize:如果某属性已经在某处实现了自己的 setter/getter ,可以使用 @dynamic 来阻止 @synthesize 自动生成新的 setter/getter 覆盖。
 3.内存管理：@synthesize 和 ARC 无关。
 4.使用：一般情况下无需对属性添加 @synthesize ，但一些特殊情形仍然需要，例如protocol中声明的属性。
 
 discussion:
 
 @property之后就自动的生成了get 与 set方法？
 那样的话@synthesize是不是写不写都一样呢？
 
 答案： 1. 现在不用写了，除非你要同时重写setter和getter，只重写一个也是不用写的。（我觉得应该是这样的： 如果同时重写了setter和getter方法，那么编译器就不会自动插入@synthesize propertyName = _propertyName; 这样的话，就不存在名称为_propertyName的成员变量，所以在同时重写某个属性的setter和getter方法时，需要为其加上@synthesize，不然无法获取到成员变量）
 
       2.
 
 
 
 

 */


@implementation Car
@synthesize name = carName;//这句代码的意思是，将@property自动生成的_name 起个别名carName
@synthesize brand;//如果@synthesize后只有属性名，没有别名，那么就会把@property 自动生成的成员变量的名称_brand 修改成 brand ,_brand将不再可用。等同于               @synthesize brand = brand;

//同时重写本类的name属性的setter 和getter方法, 那么除非加上@synthesize name = _name;否则_name不再可用
- (void)setName:(NSString *)name{
    if (carName != name) {
        carName = name;
    }
}

-(NSString *)name{
    return carName;
}

//只重写brand的getter方法
-(NSString *)brand{
    return brand;
}

//只重写country的setter方法
-(void)setCountry:(NSString *)country{
    if (_country != country) {
        _country = country;
    }
}



-(NSString *)description{
    return [NSString stringWithFormat:@"%@=======%@======%@",self.name,self.brand,self.country];
}

@end
