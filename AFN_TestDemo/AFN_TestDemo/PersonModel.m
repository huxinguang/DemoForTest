//
//  PersonModel.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/20.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "PersonModel.h"

#warning ********anonymous category*********
/*
 官方文档：https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html#//apple_ref/doc/uid/TP40011210-CH6-SW3
 
 ************* 匿名类别 *************

 A class extension bears some similarity to a category, but it can only be added to a class for which you have the source code at compile time (the class is compiled at the same time as the class extension).
 The syntax to declare a class extension is similar to the syntax for a category, and looks like this:
 
 @interface ClassName ()
 @end
 
 Because no name is given in the parentheses（括号）, class extensions are often referred to as anonymous categories（）.
 
 Unlike regular categories, a class extension can add its own properties and instance variables to a class. If you declare a property in a class extension, like this:
 
 @interface XYZPerson ()
 @property NSObject *extraProperty;
 @end
 
 
 the compiler will automatically synthesize the relevant accessor methods, as well as an instance variable, inside the primary class implementation.
 
 If you add any methods in a class extension, these must be implemented in the primary implementation for the class.
 
 It’s also possible to use a class extension to add custom instance variables. These are declared inside braces in the class extension interface:
 
 @interface XYZPerson () {
 id _someCustomInstanceVariable;
 }
 ...
 @end
 
 
 Class extensions are often used to extend the public interface with additional private methods or properties for use within the implementation of the class itself. It’s common, for example, to define a property as readonly in the interface, but as readwrite in a class extension declared above the implementation, in order that the internal methods of the class can change the property value directly.
 
 As an example, the XYZPerson class might add a property called uniqueIdentifier, designed to keep track of information like a Social Security Number in the US.
 
 It usually requires a large amount of paperwork to have a unique identifier assigned to an individual in the real world, so the XYZPerson class interface might declare this property as readonly, and provide some method that requests an identifier be assigned, like this:
 
 @interface XYZPerson : NSObject
 ...
 @property (readonly) NSString *uniqueIdentifier;
 - (void)assignUniqueIdentifier;
 @end
 This means that it’s not possible for the uniqueIdentifier to be set directly by another object. If a person doesn’t already have one, a request must be made to assign an identifier by calling the assignUniqueIdentifier method.
 
 In order for the XYZPerson class to be able to change the property internally, it makes sense to redeclare the property in a class extension that’s defined at the top of the implementation file for the class:
 
 @interface XYZPerson ()
 @property (readwrite) NSString *uniqueIdentifier;
 @end
 
 @implementation XYZPerson
 ...
 @end
 
 This means that the compiler will now also synthesize a setter method, so any method inside the XYZPerson implementation will be able to set the property directly using either the setter or dot syntax.
 By declaring the class extension inside the source code file for the XYZPerson implementation, the information stays private to the XYZPerson class. If another type of object tries to set the property, the compiler will generate an error.
 
 ************ 注 意 ************
 
 Note: By adding the class extension shown above, redeclaring the uniqueIdentifier property as a readwrite property, a setUniqueIdentifier: method will exist at runtime on every XYZPerson object, regardless of whether other source code files were aware of the class extension or not.
 The compiler will complain if code in one of those other source code files attempts to call a private method or set a readonly property, but it’s possible to avoid compiler errors and leverage dynamic runtime features to call those methods in other ways, such as by using one of the performSelector:... methods offered by NSObject. You should avoid a class hierarchy or design where this is necessary; instead, the primary class interface should always define the correct “public” interactions.
 If you intend to make “private” methods or properties available to select other classes, such as related classes within a framework, you can declare the class extension in a separate header file and import it in the source files that need it. It’s not uncommon to have two header files for a class, for example, such as XYZPerson.h and XYZPersonPrivate.h. When you release the framework, you only release the public XYZPerson.h header file.

 */



@interface PersonModel ()
@property (nonatomic, copy)NSString *gender;
@end

@implementation PersonModel

- (id)initWithFirstName:(NSString *)fName lastName:(NSString *)lName courses:(NSArray *)courses assignmentType:(PropertyValueAssignmentType)type{
    if (self = [super init]) {
        switch (type) {
            case PropertyValueAssignmentNoCallSetter:
                _firstName = fName;
                _lastName = lName;
                _courses = courses;
                break;
            case PropertyValueAssignmentNoCallSetterButCopy:
                _firstName = [fName copy];
                _lastName = lName;
                _courses = [courses copy];
                break;
            default:
                //在初始化方法中,最好通过成员变量来读写数据(赋值的时候要要保持属性的内存管理语义，即如果用copy修饰的属性，就应该在赋值时copy一下)，原因： 52个有效方法之第7条
                self.firstName = fName;
                self.lastName = lName;
                self.courses = courses;
                break;
        }
        
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"firstName = %@\n lastName = %@\n courses = %@\n",_firstName,_lastName,_courses];
}


@end
