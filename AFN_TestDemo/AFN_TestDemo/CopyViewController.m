//
//  CopyViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/26.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "CopyViewController.h"
#import "PersonModel.h"
#import "Animal.h"


typedef NS_OPTIONS(NSUInteger, MyObjectValueOptions) {
    MyObjectValueOptionNew = 0x01,
    MyObjectValueOptionold = 0x02
    
};

@interface CopyViewController ()

@end

@implementation CopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"copyInitNoSetter" forState:UIControlStateNormal];
    btn.frame =  CGRectMake(20, 90, kScreenWidth-20*2, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(copyInitNoSetter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"copyInitSetter" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(20, 90+40, kScreenWidth-20*2, 30);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(copyInitSetter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"copyInitNoSetterButCopy" forState:UIControlStateNormal];
    btn1.frame =  CGRectMake(20, 90+40+40, kScreenWidth-20*2, 30);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(copyInitNoSetterButCopy) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
}



/*
    如何打印内存地址 ？
    NSString *a = @"ok";
     //打印对象的内存地址
     NSLog(@"内存地址1：%p",a);
 */

/*
    浅拷贝：
        浅拷贝就是对内存地址的复制，让目标对象指针和源对象指向同一片内存空间，当内存销毁的时候，指向这片内存的几个指针需要重新定义才可以使用，要不然会成为野指针。
 
    深拷贝：
        深拷贝是指拷贝对象的具体内容，而内存地址是自主分配的，拷贝结束之后，两个对象虽然存的值是相同的，但是内存地址不一样，两个对象也互不影响，互不干涉。
 
 
  使用准则：
      No1：可变对象的copy和mutableCopy方法都是深拷贝（区别完全深拷贝与单层深拷贝） 。
 
 　   No2：不可变对象的copy方法是浅拷贝，mutableCopy方法是深拷贝。
 
 　   No3：copy方法返回的对象都是不可变对象。
 
 */





    
    
/*
 结论：
 为什么要用copy修饰NSString类型的属性：

 copy修饰的属性，在设置属性值时，设置方法不保留新值，而是将其copy。这样做的目的是保护类的封装性。即如果想要修改类的实例的属性值，就必须通过该类的实例对象调用set方法。
 如果用strong来修饰NSString类型的属性，在设置属性值时，设置方法会先保留新值，并释放旧值，然后再将新值设置到属性。这样的话，如果传递给设置方法的新值是NSMutableString类型的实例（比如A），那么在设置完属性后，由于A是可变的，当A的值变化时，对象的属性值也会发生变化，而这种变化很隐蔽，并不会显式的让编程者知道，容易发生不易定位的bug
 */
    

- (void)copyInitNoSetter{
    //在初始化的时候给对象的属性赋值，赋值采用的是_someProperty = someValue的形式，而不是self.someProperty = someValue形式
    NSMutableString *fisrtName = [[NSMutableString alloc]initWithString:@"san"];
    NSMutableString *lastName = [[NSMutableString alloc]initWithString:@"zhang"];
    NSMutableArray *courses = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    PersonModel *pm = [[PersonModel alloc]initWithFirstName:fisrtName lastName:lastName courses:courses assignmentType:PropertyValueAssignmentNoCallSetter];
    NSLog(@"%@",[pm description]);
    [fisrtName appendString:@"xxxx"];
    [lastName appendString:@"yyyy"];
    [courses addObject:@"4"];
    NSLog(@"%@",[pm description]);
    
    /*
     结论：如果类的属性比如NSString、NSArray、NSDictionary等,使用了copy来修饰,那么在类的初始化或类内部给属性赋值的时候，采用的是_someProperty = someValue形式，copy达不到其应有的效果。
     */
    
}

- (void)copyInitSetter{
    //1. 在初始化的时候给对象的属性赋值，赋值采用的是self.someProperty = someValue的形式，而不是_someProperty = someValue形式
    NSMutableString *fisrtName = [[NSMutableString alloc]initWithString:@"san"];
    NSMutableString *lastName = [[NSMutableString alloc]initWithString:@"zhang"];
    NSMutableArray *courses = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    PersonModel *pm1 = [[PersonModel alloc]initWithFirstName:fisrtName lastName:lastName courses:courses assignmentType:PropertyValueAssignmentCallSetter];
    NSLog(@"%@",[pm1 description]);
    [fisrtName appendString:@"xxxx"];
    [lastName appendString:@"yyyy"];
    [courses addObject:@"4"];
    NSLog(@"%@",[pm1 description]);
    
//    //2.不在初始化方法中赋值，而是创建对象后赋值
//    PersonModel *pm2 = [[PersonModel alloc]init];
//    pm2.firstName = fisrtName;
//    pm2.lastName = lastName;
//    pm2.courses = courses;
//    NSLog(@"%@",[pm2 description]);
//    [fisrtName appendString:@"xxxx"];
//    [lastName appendString:@"yyyy"];
//    [courses addObject:@"4"];
//    NSLog(@"%@",[pm2 description]);
    
}

- (void)copyInitNoSetterButCopy{
    //在初始化的时候给对象的属性赋值，赋值采用的是_someProperty = [someValue copy]的形式，
    NSMutableString *fisrtName = [[NSMutableString alloc]initWithString:@"san"];
    NSMutableString *lastName = [[NSMutableString alloc]initWithString:@"zhang"];
    NSMutableArray *courses = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    PersonModel *pm = [[PersonModel alloc]initWithFirstName:fisrtName lastName:lastName courses:courses assignmentType:PropertyValueAssignmentNoCallSetterButCopy];
    NSLog(@"%@",[pm description]);
    [fisrtName appendString:@"xxxx"];
    [lastName appendString:@"yyyy"];
    [courses addObject:@"4"];
    NSLog(@"%@",[pm description]);
    
    /*
     结论： 通过对比上面的两个案例，可以看出，在copy修饰的属性的setter方法中，做了copy操作
     */
}

- (void)setterOfCopyProperty{
    
}

- (void)getterOfCopyProperty{
    
}

- (void)setterOfStrongProperty{
    
}

- (void)getterOfStrongProperty{
    
    
}



- (void)nsstringTest{
    
    
    
}

- (void)nsmutableStringTest{
    
    
}

- (void)copySetterAndNonSetter{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
