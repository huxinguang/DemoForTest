//
//  CategoryViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/9.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "CategoryViewController.h"
#import "Animal.h"
#import "Animal+AddPropertyTest.h"
#import "Animal+AddPropertyTestOne.h"
#import <objc/runtime.h>

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"printIvars" forState:UIControlStateNormal];
    btn.frame =  CGRectMake(20, 90, kScreenWidth-20*2, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(printIvars) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"printProperties" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(20, 90+40, kScreenWidth-20*2, 30);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(printProperties) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"printMethods" forState:UIControlStateNormal];
    btn1.frame =  CGRectMake(20, 90+40*2, kScreenWidth-20*2, 30);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(printMethods) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"ifCanAccessPropertyAddedByCategory" forState:UIControlStateNormal];
    btn2.frame =  CGRectMake(20, 90+40*3, kScreenWidth-20*2, 30);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(ifCanAccessPropertyAddedByCategory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"useAssociatedObjectToAddPropertyInCategory" forState:UIControlStateNormal];
    btn3.titleLabel.adjustsFontSizeToFitWidth = YES;
    btn3.frame =  CGRectMake(20, 90+40*4, kScreenWidth-20*2, 30);
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(useAssociatedObjectToAddPropertyInCategory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
}

- (void)printIvars{
    unsigned int count = 0;
    Ivar  *ivars = class_copyIvarList([Animal class], &count); //ivars 前有*
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];//ivars 前无*
        NSLog(@"%s",ivar_getName(ivar));
    }
    free(ivars);//需要手动free
    /*
     结论：在category中使用@property为类声明属性，使用class_copyIvarList获取不到，即没有生成相应的成员变量。
     */
}

- (void)printProperties{
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([Animal class], &count); //properties 前有*
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i]; //property 前无*
        NSLog(@"%s",property_getName(property));
    }
    free(properties);//需要手动free
    
    /*
     结论：在category中使用@property为类声明属性，使用class_copyPropertyList也能获取到。
     */
}

- (void)printMethods{
    unsigned int count  = 0;
    Method *methods = class_copyMethodList([Animal class], &count);//methods 前有*
    for (int i = 0; i < count; i++) {
        Method method = methods[i];//method 前无*
        NSLog(@"%s",sel_getName(method_getName(method)));//注意获取方法名的方式，method_getName的返回值是SEL类型
    }
    free(methods);//需要手动free
}

- (void)ifCanAccessPropertyAddedByCategory{
    
    Animal *a = [[Animal alloc]init];
    //编译的时候不会报错，也没有警告（这里没有警告，但在category的.m 文件中会有警告），但运行的时候，调用category添加的属性的setter方法时会报错： -[Animal setAge:]: unrecognized selector sent to instance 0x60000042a980
    a.age = 10;
    
    //编译的时候不会报错，也没有警告（这里没有警告，但在category的.m 文件中会有警告），但运行的时候，调用category添加的属性的getter方法时会报错：-[Animal age]: unrecognized selector sent to instance 0x60800002aa60
    NSLog(@"%d",a.age);
    
    /*
     结论：在category中使用@property为类声明属性时，不会自动为该属性添加setter和getter方法
     
     */
    
}

- (void)useAssociatedObjectToAddPropertyInCategory{
    Animal *a = [[Animal alloc]init];
    a.area = @"China";
    NSLog(@"%@",a.area);
    
    /*
     结论： 可以通过关联属性来为category中添加的属性设置setter/getter方法，但关联属性只能添加setter/getter方法，不能添加带_的成员变量。
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
