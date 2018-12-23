//
//  SynthesizeViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/27.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "SynthesizeDynamicViewController.h"
#import "Car.h"
#import "SubCar.h"
#import "BlackPerson.h"
#import "Robot.h"
#import "WhitePerson.h"



@interface SynthesizeDynamicViewController ()

@end

@implementation SynthesizeDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"synthesizeOne" forState:UIControlStateNormal];
    btn.frame =  CGRectMake(20, 90, kScreenWidth-20*2, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(synthesizeTestOne) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"dynamicOne" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(20, 90+40, kScreenWidth-20*2, 30);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(dynamicTestOne) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"dynamicTwo" forState:UIControlStateNormal];
    btn1.frame =  CGRectMake(20, 90+40*2, kScreenWidth-20*2, 30);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(dynamicTestTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"instanceVariable" forState:UIControlStateNormal];
    btn2.frame =  CGRectMake(20, 90+40*3, kScreenWidth-20*2, 30);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(instanceVariable) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
//
//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn1 setTitle:@"copyInitNoSetterButCopy" forState:UIControlStateNormal];
//    btn1.frame =  CGRectMake(20, 90+40+40, kScreenWidth-20*2, 30);
//    btn1.backgroundColor = [UIColor redColor];
//    [btn1 addTarget:self action:@selector(copyInitNoSetterButCopy) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn1];
    
    
    
}

- (void)synthesizeTestOne{

    Car *c = [[Car alloc]init];
    c.name = @"maiteng";
    c.brand = @"Dazhong";
    c.country = @"Germany";
    NSLog(@"%@",c.description);

}

- (void)dynamicTestOne{
    
    BlackPerson *bp = [[BlackPerson alloc]init];
    bp.name = @"jack";//会报错
    Robot *r = [[Robot alloc]init];
    r.name = @"xxxx";
    bp.robot = r;
    NSLog(@"%@",bp.robot.name);
    
}

- (void)dynamicTestTwo{
    WhitePerson *wp = [[WhitePerson alloc]init];
    Robot *r = [[Robot alloc]init];
    r.name = @"www";
    wp.robot = r;
    NSLog(@"%@",wp.robot.name);
    
}

- (void)instanceVariable{
    /*
     1.成员变量的作用范围:
     @public:在任何地方都能直接访问对象的成员变量
     @private:只能在当前类的对象方法中直接访问,如果子类要访问需要调用父类的get/set方法
     @protected:可以在当前类及其子类对象方法中直接访问(系统默认下是用它来修饰的)
     @package:在同一个包下就可以直接访问，比如说在同一个框架
     
     */
    
    SubCar *sc = [[SubCar alloc]init];
    sc->color = @"red"; //@public
//    sc->speed = 100; //@protected
//    sc->age = 5; //@private
    NSString *color = sc->color;
    NSLog(@"%@",color);
    [sc run];
    
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
