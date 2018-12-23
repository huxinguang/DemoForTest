//
//  ProtocalViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/16.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "ProtocalViewController.h"
#import "Robot.h"

@interface ProtocalViewController ()

@end

@implementation ProtocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"conformsToProtocol" forState:UIControlStateNormal];
    btn.frame =  CGRectMake(20, 90, kScreenWidth-20*2, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(conformsToProtocolAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"respondsToSelector" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(20, 90+40, kScreenWidth-20*2, 30);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(respondsToSelectorAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];

}

- (void)conformsToProtocolAction{
    /*
     Returns a Boolean value that indicates whether the receiver conforms to a given protocol.
     
     This method works identically to the conformsToProtocol: class method declared in NSObject. It’s provided as a convenience so that you don’t need to get the class object to find out whether an instance can respond to a given set of messages.
     */
    
    Robot *rob = [[Robot alloc]init];
    if ([rob conformsToProtocol:@protocol(ProtocalFileTest)]) {
        NSLog(@"conforms to a given protocol   YES");
        [rob testProtocolFunctionOne];
        [rob testProtocolFunctionTwo];
    }else{
        NSLog(@"conforms to a given protocol   NO");
    }
    
    /*
     结论：conformsToProtocol方法只判断对象有没有遵循Protocol,不管对象所在的类的实现中有没有实现protocol里的方法，不论是@required还是@optional
     */
    
}

- (void)respondsToSelectorAction{
    Robot *rob = [[Robot alloc]init];
    if ([rob respondsToSelector:@selector(testProtocolFunctionOne)]) {
        NSLog(@"respondsTo  testProtocolFunctionOne  YES");
    }else{
        NSLog(@"respondsTo  testProtocolFunctionOne  NO");
    }
    
    if ([rob respondsToSelector:@selector(testProtocolFunctionTwo)]) {
        NSLog(@"respondsTo  testProtocolFunctionTwo  YES");
    }else{
        NSLog(@"respondsTo  testProtocolFunctionTwo  NO");
    }
    
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
