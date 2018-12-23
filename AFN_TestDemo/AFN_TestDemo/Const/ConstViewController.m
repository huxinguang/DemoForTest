//
//  ConstViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/12.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "ConstViewController.h"
#import "Constants.h"
#import "ConstTwoViewController.h"

#define ANIMATION_DURATION 0.5

//NSString *const myConst = @"hello";



@interface ConstViewController ()

@end

@implementation ConstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"define" forState:UIControlStateNormal];
    btn.frame =  CGRectMake(20, 90, kScreenWidth-20*2, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(defineTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"const" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(20, 90+40, kScreenWidth-20*2, 30);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(constTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"const1" forState:UIControlStateNormal];
    btn1.frame =  CGRectMake(20, 90+40*2, kScreenWidth-20*2, 30);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(constTest1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"const2" forState:UIControlStateNormal];
    btn2.frame =  CGRectMake(20, 90+40*3, kScreenWidth-20*2, 30);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(constTest2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"extern variable" forState:UIControlStateNormal];
    btn3.frame =  CGRectMake(20, 90+40*4, kScreenWidth-20*2, 30);
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(variableTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
}

- (void)defineTest{
    
    /*
     #define ANIMATION_DURATION 0.3;
     上述的预处理指令会把源代码中的 ANIMATION_DURATION 字符串替换成0.3, 这确实可以实现,但是这样定义出来的变量没有类型信息. 动画的持续播放时间应该是NSTimeInterval类型, 此外预处理过程会把碰到所有的ANIMATION_DURATION一律换成0.3,假设此指令声明在,某个头文件中, 那么所有引入这个头文件的代码, 其ANIMATION_DURATION都会被替换成 0.3。
     那么有一种情况就是：你意图定义一个常量A_CONST作为工程的全局常量，在所有的类中都是用该常量的值，结果某个同事在你写的某个类中也写了某个功能方法，然后在该类中define了一个同名的A_CONST,而且值和你在全局定义的值不同，那么该类中你写的功能方法里使用到的值就会变成你同事定义的值了。
     注：上面这种情况会报警告： 'A_CONST' macro redefined
     
     */
    
    NSLog(@"%f",ANIMATION_DURATION);
}

- (void)constTest{
//    kConstNameOne = @"123";
    NSLog(@"%@",kConstNameOne);
    
}

- (void)constTest1{
    /*
     如果多个.m文件需要用到myConst,可以在每一个.m文件都像下面这样初始化吗?
     　　　　NSString * const myConst = @"hello";
     
     肯定不行,编译时,会报重复定义: duplicate symbol _myConst in: ConstViewController.o and ConstTwoViewController.o
     */
    
}

- (void)constTest2{
    /*
     static修饰全局变量,表明该全局变量只对当前文件可见,比如：
     在ConstTwoViewController.m中生命的全局变量currentFileConst:
     static NSString *const currentFileConst = @"currentFileConst";
     在本文件中就访问不到。
     
     但是如果同样的声明我们放在ConstTwoViewController.h中，那么我们在本文件中#import "ConstTwoViewController.h"
     那么就可以访问currentFileConst了,但一般不这么干，如果想要声明一个在其他文件中也可访问的全局常量，我们就用extern,如果仅在本文件中使用，那么就在当前.m文件中用static
     
     */
//
    
//    NSLog(@"%@",currentFileConst);
}

- (void)variableTest{
    
    kVariableNameOne = @"1332";//全局变量，初始化次数没有限制
    NSLog(@"%@",kVariableNameOne);
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
