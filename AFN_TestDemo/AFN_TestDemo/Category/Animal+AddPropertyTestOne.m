//
//  Animal+AddPropertyTestOne.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/9.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "Animal+AddPropertyTestOne.h"
#import <objc/runtime.h>

//static const char areaKey;

@implementation Animal (AddPropertyTestOne)

//因为在分类里用@property声明属性时系统并没有添加以“_”开头的成员变量。此时要达到添加的目的可以使用运行时的关联对象。


-(void)setArea:(NSString *)area{
    //OBJC_ASSOCIATION_COPY_NONATOMIC用于保持属性copy的内存管理语义
    
    /*
     void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     
     object
     The source object for the association.
     
     key
     The key for the association.
     
     value
     The value to associate with the key for object. Pass nil to clear an existing association.
     
     policy
     The policy for the association
     
     关联对象可以这样理解：
     1. 把第一个参数看作一个字典
     2. 把第二个参数看成字典里的key
     3. 把第三个参数看成字典里的value
     4. 这个函数的作用： 把第二个参数和第三个参数以键值对的方式存入第一个参数中
     */
    
    
    /*
     objc_setAssociatedObject
     objc_getAssociatedObject
     这两个函数第二个参数key的说明：
     
     从方法声明中可以看出，key的类型为id , 意味着key值必须保证是一个对象级别的唯一常量。一般来说，有以下三种推荐的 key 值：
     
     1. 声明 static char kAssociatedObjectKey; 使用 &kAssociatedObjectKey 作为 key 值;
     2. 声明 static const char kAssociatedObjectKey = '\0'; 使用 &kAssociatedObjectKey 作为 key 值  （'\0'表示ASCII码值为0的字符）
     3. 声明 static void *kAssociatedObjectKey = &kAssociatedObjectKey; 使用 kAssociatedObjectKey 作为 key 值；
     4. 用 @selector(getterMethodName) 作为key值,
     
     SDWebImage 用的是第1种方式，第1种方式kAssociatedObjectKey的默认值就是'\0'，（可以将光标停在kAssociatedObjectKey，即可看出默认值）跟第二种方式是一样的
     MJExtension 用的是第2种方式
     AFNetworking 用的是第4种方式
     
     */
    

    /*
     第三个参数传入nil 则可以移除已有的关联
     
     还有一种移除关联的方法：
     void objc_removeAssociatedObjects(id object);
     但不建议使用此方法移除关联，因为此方法移除的是所有的关联，这样的话，别的开发人员为此对象添加了关联对象也会一并移除。
     
     可通过将objc_setAssociatedObject第三个参数传入nil的形式来移除单个的关联

     */
    

//    objc_setAssociatedObject(self, &areaKey, area, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, @selector(area), area, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)area{
    /*
     id objc_getAssociatedObject(id object, const void *key);
     
     这个函数可以这样理解：
     就是用key去object这个“字典”取出之前通过objc_setAssociatedObject(...)函数存入object里的值。
    
     */
    return objc_getAssociatedObject(self, @selector(area));//这里第二个参数也可以改为_cmd,最好用_cmd,这里用@selector(area)是为了和上面objc_setAssociatedObject里面的key保持一致
}

@end
