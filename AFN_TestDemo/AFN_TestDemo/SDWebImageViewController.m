//
//  SDWebImageViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/2.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "SDWebImageViewController.h"

@interface SDWebImageViewController (){
    UIImageView *_imgView;
}

@end

@implementation SDWebImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"SDWebImageSampleOne" forState:UIControlStateNormal];
    btn.frame =  CGRectMake(20, 90, kScreenWidth-20*2, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(sdWebImageSampleOne) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-250/2, 150, 250, 166)];
    _imgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_imgView];
    
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"SDWebImageSampleTwo" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(20, 150+166 + 30, kScreenWidth-20*2, 30);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(sdWebImageSampleTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
}

- (void)sdWebImageSampleOne{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"id":@"1"};
    [manager GET:@"http://172.20.10.5:8080/skyocean/testSDWebImageOne/" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *response = (NSDictionary *)responseObject;
            if ([[response objectForKey:@"code"] intValue] == 0) {
                NSDictionary *data = [response objectForKey:@"data"];
                NSString *urlString = [data objectForKey:@"imgUrl"];
//                [_imgView sd_setImageWithURL:[NSURL URLWithString:urlString]];
//                [_imgView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                [_imgView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRefreshCached];
               
                
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    
}

- (void)sdWebImageSampleTwo{
    
    //测试304 Not Modified （由于我自己写的java后台并未配置304的处理逻辑，所以这里的返回值是200）
    
//    URLSession current behavior will return 200 status code when the server respond 304 and URLCache hit. But this is not a standard behavior and we just add a check
    
    NSString *str = @"http://172.20.10.5:8080/uploads/1524380607198.jpg";//是上面sdWebImageSampleOne方法里网络请求的结果
    [_imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRefreshCached];
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
