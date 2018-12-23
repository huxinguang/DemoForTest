//
//  NSKeyedArichiverViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/30.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "NSKeyedArichiverViewController.h"
#import "ArichiverModel.h"

@interface NSKeyedArichiverViewController ()

@end

@implementation NSKeyedArichiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"NSKeyedArchiver" forState:UIControlStateNormal];
    btn.frame =  CGRectMake(20, 90, kScreenWidth-20*2, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(NSKeyedArchiverAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"NSKeyedUnarchiver" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(20, 90+40, kScreenWidth-20*2, 30);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(NSKeyedUnarchiverAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
}

- (void)NSKeyedArchiverAction{
    /*
     
     */
    ArichiverModel *am = [[ArichiverModel alloc]init];
    am.name = @"jack";
    am.age = 18;
    am.gender = GenderMale;
    am.family = @[@"rose",@"jerry",@"tom"];
    am.married = YES;
    NSLog(@"%@",[self getPath]);
    [NSKeyedArchiver archiveRootObject:am toFile:[self getPath]];
}

- (void)NSKeyedUnarchiverAction{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getPath]]) {
        ArichiverModel *am = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getPath]];
        NSLog(@"%@",am.description);
    }
    
}

- (NSString *)getPath{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [document stringByAppendingPathComponent:@"ArichiverModel"];
    return path;
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
