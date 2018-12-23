//
//  RuntimeViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/29.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "RuntimeViewController.h"
#import "TableOne.h"
#import "TableTwo.h"
#import "TableThree.h"
#import "TableFour.h"
#import <objc/runtime.h>
#import "ChildViewController.h"

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"objc_msgSend" forState:UIControlStateNormal];
    btn.frame =  CGRectMake(20, 90, kScreenWidth-20*2, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(objcMsgSendAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"methodForSelector" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(20, 90+40, kScreenWidth-20*2, 30);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(methodForSelectorAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"resolveInstanceMethod" forState:UIControlStateNormal];
    btn1.frame =  CGRectMake(20, 90+40*2, kScreenWidth-20*2, 30);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(resolveInstanceMethodAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"resolveClassMethod" forState:UIControlStateNormal];
    btn2.frame =  CGRectMake(20, 90+40*3, kScreenWidth-20*2, 30);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(resolveClassMethodAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"forwardingTargetForSelector" forState:UIControlStateNormal];
    btn3.frame =  CGRectMake(20, 90+40*4, kScreenWidth-20*2, 30);
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(forwardingTargetForSelectorAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setTitle:@"forwardInvocation" forState:UIControlStateNormal];
    btn4.frame =  CGRectMake(20, 90+40*5, kScreenWidth-20*2, 30);
    btn4.backgroundColor = [UIColor redColor];
    [btn4 addTarget:self action:@selector(forwardInvocationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn5 setTitle:@"swizzle" forState:UIControlStateNormal];
    btn5.frame =  CGRectMake(20, 90+40*5, kScreenWidth-20*2, 30);
    btn5.backgroundColor = [UIColor redColor];
    [btn5 addTarget:self action:@selector(swizzleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    
    
    

}

- (void)objcMsgSendAction{
    
#warning *********objc_msgSend方法的调用是由编译器来生成的，不能自己手动调用********
    
    /*
     Sends a message with a simple return value to an instance of a class.
     
     id objc_msgSend(id self, SEL op, ...);
     
     self
     A pointer that points to the instance of the class that is to receive the message.
     
     op
     The selector of the method that handles the message.
     
     ...
     A variable argument list containing the arguments to the method.
     
     
     Return Value
     The return value of the method.
     
     Discussion
     When it encounters a method call, the compiler generates a call to one of the functions objc_msgSend, objc_msgSend_stret, objc_msgSendSuper, or objc_msgSendSuper_stret. Messages sent to an object’s superclass (using the super keyword) are sent using objc_msgSendSuper; other messages are sent using objc_msgSend. Methods that have data structures as return values are sent using objc_msgSendSuper_stret and objc_msgSend_stret.
     
     
     Note: The compiler generates calls to the messaging function. You should never call it directly in the code you write.
     
     
     self和op这两个参数也被称为Hidden Arguments（隐藏参数），原因：
     
     They’re said to be “hidden” because they aren’t declared in the source code that defines the method. They’re inserted into the implementation when the code is compiled.
     
     self参数很有用处，正是有了self参数，runtime才能在方法的定义中访问类的实例变量的信息。
     
     */
    
    
}

- (void)methodForSelectorAction{
    
    /*
     
     Instance Method
     
     Locates and returns the address of the receiver’s implementation of a method so it can be called as a function.
     
     - (IMP)methodForSelector:(SEL)aSelector;
     
     aSelector
     A Selector that identifies the method for which to return the implementation address. The selector must be a valid and non-NULL. If in doubt, use the respondsToSelector: method to check before passing the selector to methodForSelector:.
     
     Return Value
     The address of the receiver’s implementation of the aSelector.
     
     Discussion
     If the receiver is an instance, aSelector should refer to an instance method; if the receiver is a class, it should refer to a class method.
     
     */
    
    //当某个方法被连续调用多次，如何规避在动态绑定的过程中频繁的消息转发带来的开销？(具体说明见我总结的文档)
    
    /*
      说明文档的具体实现：
     
     假定需要创建 1000个 Table 类的实例对象，然后将这1000个实例对象的filled属性值全部设置为YES.
     
     */
    
    NSMutableArray *targetList = [[NSMutableArray alloc]initWithCapacity:1000];
    for (int i = 0; i < 1000; i++) {
        TableOne *tb = [[TableOne alloc]init];
        [targetList addObject:tb];
    }
    
    void (*setter)(id, SEL, BOOL);
    
    for (int i = 0; i<targetList.count;i++) {
        setter = (void (*)(id, SEL, BOOL))[targetList[i]
                                           methodForSelector:@selector(setFilled:)];
        setter(targetList[i], @selector(setFilled:), YES);
    }
    
//    for (int i=0; i < targetList.count; i++) {
//        TableOne *tb = (TableOne *)targetList[i];
//        NSLog(@"%d",tb.filled);
//    }
    
}


- (void)resolveInstanceMethodAction{
    /*
     Type Method
     
     Dynamically provides an implementation for a given selector for an instance method.
     
     + (BOOL)resolveInstanceMethod:(SEL)sel;
     
     sel
     The name of a selector to resolve.
     
     Return Value
     YES if the method was found and added to the receiver, otherwise NO.
     
     */
    
    //用法1： 动态添加实例方法
    
    TableTwo *tb = [[TableTwo alloc]init];
    [tb performSelector:@selector(resolveInstanceMethodDynamically)];
//    [tb performSelector:@selector(resolveThisMethodDynamically) withObject:nil];
//    [tb performSelector:@selector(resolveThisMethodDynamically) withObject:nil afterDelay:3];

    //用法2： 劫持方法（替换原有方法的实现）
    
//    待完成
//    HijackViewController *hvc = [[HijackViewController alloc]init];
//    [self.navigationController pushViewController:hvc animated:YES];
    

}


- (void)resolveClassMethodAction{
    
    /*
     Type Method
     
     Dynamically provides an implementation for a given selector for a class method.

     + (BOOL)resolveClassMethod:(SEL)sel;
     
     Parameters
     sel
     The name of a selector to resolve.
     
     Return Value
     YES if the method was found and added to the receiver, otherwise NO.
     
     */
    

    //如果方法带参数，方法后面要加 :
    id result = [TableTwo performSelector:@selector(resolveClassMethodDynamically:) withObject:@"123"];
    
    NSLog(@"%@",result);
    
    
}


-(void)forwardingTargetForSelectorAction{
    
    TableThree *tb = [[TableThree alloc]init];
    [tb performSelector:@selector(notExistInstanceMethod)];
    
    
    
}


- (void)forwardInvocationAction{
    
    TableFour *tb = [[TableFour alloc]init];
    [tb performSelector:@selector(test:) withObject:@"123"];
    
//    BOOL rtTest = [tb respondsToSelector:@selector(test)];
    
}

- (void)swizzleAction{
    ChildViewController *cvc = [[ChildViewController alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
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
