//
//  TestViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/7/12.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2-200/2, 100, 200, 40)];
    tf.borderStyle=UITextBorderStyleRoundedRect;
    tf.returnKeyType = UIReturnKeyDone;
    tf.keyboardType = UIKeyboardTypeDefault;
//    tf.keyboardType = UIKeyboardTypeASCIICapable;
//    tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    tf.keyboardType = UIKeyboardTypeURL;
//    tf.keyboardType = UIKeyboardTypeNumberPad;
//    tf.keyboardType = UIKeyboardTypePhonePad;
//    tf.keyboardType = UIKeyboardTypeNamePhonePad;
//    tf.keyboardType = UIKeyboardTypeEmailAddress;
//    tf.keyboardType = UIKeyboardTypeDecimalPad;
//    tf.keyboardType = UIKeyboardTypeTwitter;
//    tf.keyboardType = UIKeyboardTypeWebSearch;
//    tf.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    
    
    
    tf.keyboardAppearance = UIKeyboardAppearanceDefault;
    [self.view addSubview:tf];
    
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
