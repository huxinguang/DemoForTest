//
//  WebViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/6/4.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *wView;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.wView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.wView.backgroundColor = [UIColor redColor];
    self.wView.delegate = self;
    [self.view addSubview:self.wView];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.20.10.5:8080/uploads/test.html"]];
    [self.wView loadRequest:request];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
    NSString *webTitle = [self.wView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"title = %@",webTitle);
    
    JSContext *context = [self.wView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //js调用oc方法
    __weak typeof(self) weakSelf = self;
    
    context[@"goBack"] = ^() { // 后退（不带参数）
        [weakSelf goBack];
    };
    
    context[@"showAlert"] = ^() { // 提示（带参数）
        NSArray *args = [JSContext currentArguments];
        NSLog(@"%@",args);
        [weakSelf showAlert:args];
    };
    
    
    //oc调用js方法
    
    NSString *textJS = @"callJsAlert('这里是JS中alert弹出的message')";
    [context evaluateScript:textJS];
    

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didFailLoadWithError");
}


- (void)goBack{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
}

- (void)showAlert:(NSArray *)args{
    
//    NSString *str1 = (NSString *)args[0];
//    NSString *str2 = (NSString *)args[1];
    NSString *str1 = [NSString stringWithFormat:@"%@",(NSString *)args[0]];
    NSString *str2 = [NSString stringWithFormat:@"%@",(NSString *)args[1]];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:str1 message:str2 preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了确定");
        }];
        [alert addAction:action2];
        [alert addAction:action3];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
    });
    
    
    
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
