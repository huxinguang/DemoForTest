//
//  ViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/16.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "PersonModel.h"
#import "QSThreadSafeMutableArray.h"
#import "ThreadViewController.h"
#import "NetworkViewController.h"
#import "CopyViewController.h"
#import "SynthesizeDynamicViewController.h"
#import "RuntimeViewController.h"
#import "MJExtensionViewController.h"
#import "SDWebImageViewController.h"
#import "CategoryViewController.h"
#import "ConstViewController.h"
#import "TableViewController.h"
#import "ProtocalViewController.h"
#import "PNGJPEGViewController.h"
#import "FMDBViewController.h"
#import "NSKeyedArichiverViewController.h"
#import "WebViewController.h"
#import "TestViewController.h"

@interface ViewController ()


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    //*************************************** 内部类别测试 *********************************************
    PersonModel *pm = [[PersonModel alloc]init];
//    pm.gender
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"多线程" forState:UIControlStateNormal];
    btn.frame =  CGRectMake(30, 100, 80, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(threadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"网络请求" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(120, 100, 80, 40);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(networkAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"Copy测试" forState:UIControlStateNormal];
    btn1.frame =  CGRectMake(210, 100, 80, 40);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"Runtime" forState:UIControlStateNormal];
    btn2.frame =  CGRectMake(30, 150, 80, 40);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(runtimeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"MJExtension" forState:UIControlStateNormal];
    btn3.frame =  CGRectMake(120, 150, 120, 40);
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(mjExtensionAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setTitle:@"SDWebImage" forState:UIControlStateNormal];
    btn4.frame =  CGRectMake(250, 150, 120, 40);
    btn4.backgroundColor = [UIColor redColor];
    [btn4 addTarget:self action:@selector(sdWebImageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn5 setTitle:@"@synthesize@dynamic" forState:UIControlStateNormal];
    btn5.frame =  CGRectMake(30, 200, 200, 40);
    btn5.backgroundColor = [UIColor redColor];
    [btn5 addTarget:self action:@selector(synthesizeDynamicAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn6 setTitle:@"categoryAddProperty" forState:UIControlStateNormal];
    btn6.frame =  CGRectMake(30, 250, 200, 40);
    btn6.backgroundColor = [UIColor redColor];
    [btn6 addTarget:self action:@selector(categoryAddPropertyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn7 setTitle:@"const" forState:UIControlStateNormal];
    btn7.frame =  CGRectMake(240, 250, 80, 40);
    btn7.backgroundColor = [UIColor redColor];
    [btn7 addTarget:self action:@selector(constAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn7];
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn8 setTitle:@"tableView" forState:UIControlStateNormal];
    btn8.frame =  CGRectMake(30, 300, 80, 40);
    btn8.backgroundColor = [UIColor redColor];
    [btn8 addTarget:self action:@selector(tableViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn8];
    
    UIButton *btn9 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn9 setTitle:@"conformsToProtocol" forState:UIControlStateNormal];
    btn9.frame =  CGRectMake(120, 300, 200, 40);
    btn9.backgroundColor = [UIColor redColor];
    [btn9 addTarget:self action:@selector(conformsToProtocolAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn9];
    
    UIButton *btn10 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn10 setTitle:@"PNG/JPEG" forState:UIControlStateNormal];
    btn10.frame =  CGRectMake(30, 350, 100, 40);
    btn10.backgroundColor = [UIColor redColor];
    [btn10 addTarget:self action:@selector(PNGJPEGAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn10];
    
    UIButton *btn11 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn11 setTitle:@"FMDB" forState:UIControlStateNormal];
    btn11.frame =  CGRectMake(150, 350, 100, 40);
    btn11.backgroundColor = [UIColor redColor];
    [btn11 addTarget:self action:@selector(FMDBAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn11];
    
    UIButton *btn12 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn12 setTitle:@"NSKeyedArichiver" forState:UIControlStateNormal];
    btn12.frame =  CGRectMake(30, 400, 150, 40);
    btn12.backgroundColor = [UIColor redColor];
    [btn12 addTarget:self action:@selector(NSKeyedArichiverAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn12];
    
    UIButton *btn13 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn13 setTitle:@"WebView" forState:UIControlStateNormal];
    btn13.frame =  CGRectMake(200, 400, 150, 40);
    btn13.backgroundColor = [UIColor redColor];
    [btn13 addTarget:self action:@selector(webViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn13];
    
    UIButton *btn14 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn14 setTitle:@"UITextField" forState:UIControlStateNormal];
    btn14.frame =  CGRectMake(30, 450, 100, 40);
    btn14.backgroundColor = [UIColor redColor];
    [btn14 addTarget:self action:@selector(textFieldAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn14];
    
    
    
    
}




- (void)threadAction{
    ThreadViewController *tvc = [[ThreadViewController alloc]init];
    [self.navigationController pushViewController:tvc animated:YES];
}

- (void)networkAction{
    NetworkViewController *nvc = [[NetworkViewController alloc]init];
    [self.navigationController pushViewController:nvc animated:YES];
    
}

- (void)copyAction{
    CopyViewController *cvc = [[CopyViewController alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
}

- (void)runtimeAction{
    RuntimeViewController *rvc = [[RuntimeViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
    
}

- (void)mjExtensionAction{
    MJExtensionViewController *mvc = [[MJExtensionViewController alloc]init];
    [self.navigationController pushViewController:mvc animated:YES];
    
}

- (void)sdWebImageAction{
    SDWebImageViewController *svc = [[SDWebImageViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)synthesizeDynamicAction{
    SynthesizeDynamicViewController *svc = [[SynthesizeDynamicViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
    
}

- (void)categoryAddPropertyAction{
    
    CategoryViewController *cvc = [[CategoryViewController alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
}

- (void)constAction{
    
    ConstViewController *cvc = [[ConstViewController alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
}

- (void)tableViewAction{
    TableViewController *tvc = [[TableViewController alloc]init];
    [self.navigationController pushViewController:tvc animated:YES];

}

- (void)conformsToProtocolAction{
    ProtocalViewController *pvc = [[ProtocalViewController alloc]init];
    [self.navigationController pushViewController:pvc animated:YES];
}

- (void)PNGJPEGAction{
    
    PNGJPEGViewController *pvc = [[PNGJPEGViewController alloc]init];
    [self.navigationController pushViewController:pvc animated:YES];
}

- (void)FMDBAction{
    
    FMDBViewController *fvc = [[FMDBViewController alloc]init];
    [self.navigationController pushViewController:fvc animated:YES];
}

- (void)NSKeyedArichiverAction{
    
     NSKeyedArichiverViewController *nvc = [[NSKeyedArichiverViewController alloc]init];
    [self.navigationController pushViewController:nvc animated:YES];
}

- (void)webViewAction{
    WebViewController *wvc = [[WebViewController alloc]init];
    [self.navigationController pushViewController:wvc animated:YES];
}

- (void)textFieldAction{
    TestViewController *wvc = [[TestViewController alloc]init];
    [self.navigationController pushViewController:wvc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
