//
//  NetworkViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/26.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "NetworkViewController.h"
#import "PersonModel.h"
#import "QSThreadSafeMutableArray.h"
#import "ThreadViewController.h"
#import "AFNUIKitViewController.h"


@interface NetworkViewController ()<NSURLSessionDelegate>{
    UIActivityIndicatorView *_indicatorView;
}

@end

@implementation NetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"GET" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(20, 100, kScreenWidth-20*2, 30);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(getAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"POST" forState:UIControlStateNormal];
    btn1.frame =  CGRectMake(20, 100+40, kScreenWidth-20*2, 30);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(postAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setTitle:@"LocalhostGET" forState:UIControlStateNormal];
    btn4.frame =  CGRectMake(20, 100+40*2, kScreenWidth-20*2, 30);
    btn4.backgroundColor = [UIColor redColor];
    [btn4 addTarget:self action:@selector(localhostGetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn5 setTitle:@"LocalhostPOST" forState:UIControlStateNormal];
    btn5.frame =  CGRectMake(20, 100+40*3, kScreenWidth-20*2, 30);
    btn5.backgroundColor = [UIColor redColor];
    [btn5 addTarget:self action:@selector(localhostPostAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn6 setTitle:@"LocalhostSingleFileUpload" forState:UIControlStateNormal];
    btn6.frame =  CGRectMake(20, 100+40*4, kScreenWidth-20*2, 30);
    btn6.backgroundColor = [UIColor redColor];
    [btn6 addTarget:self action:@selector(localhostSingleFileUploadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn7 setTitle:@"LocalhostFilesUpload" forState:UIControlStateNormal];
    btn7.frame =  CGRectMake(20, 100+40*5, kScreenWidth-20*2, 30);
    btn7.backgroundColor = [UIColor redColor];
    [btn7 addTarget:self action:@selector(localhostFilesUploadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn7];
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn8 setTitle:@"UIKit+AFNetworking" forState:UIControlStateNormal];
    btn8.frame =  CGRectMake(20, 100+40*6, kScreenWidth-20*2, 30);
    btn8.backgroundColor = [UIColor redColor];
    [btn8 addTarget:self action:@selector(afnUIKitTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn8];
    
    UIButton *btn9 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn9 setTitle:@"NSURLSessionTask" forState:UIControlStateNormal];
    btn9.frame =  CGRectMake(20, 100+40*7, kScreenWidth-20*2, 30);
    btn9.backgroundColor = [UIColor redColor];
    [btn9 addTarget:self action:@selector(nsUrlSessionTaskTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn9];
    
    
    
    _indicatorView  = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicatorView.center = self.view.center;
    [self.view addSubview:_indicatorView];
    [self.view bringSubviewToFront:_indicatorView];
    
}

- (void)getAction{
    
    /*    http://yjl.skyocean.com/tyapi/Public/skyocean/?service=User.Login&time=1524054772830&uname=15116997355&password=111111&bid=2&cid=6e6110129de4f3abab47b17e73f47aba&devicetoken=DEA362823EF6D402249B087A5495319AFC5014769CF84CBCEA9232638A5CE5EA
     */
    
    /*
     虽然将所有参数拼接起来成类似上面的url的形式作为URLString参数值，然后parameters传nil,这样GET请求也能成功请求，但不建议这么做。
     */
    NSDictionary *paramaterDic = [NSDictionary dictionaryWithObjectsAndKeys:@"User.Login",@"service",@"1524054772830",@"time",@"15116997355",@"uname",@"111111",@"password",@"2",@"bid",@"6e6110129de4f3abab47b17e73f47aba",@"cid",@"DEA362823EF6D402249B087A5495319AFC5014769CF84CBCEA9232638A5CE5EA",@"devicetoken", nil];
    /*
     *[AFHTTPSessionManager manager]获取的是AFHTTPSessionManager的实例对象，manager方法每次都会创建一个新的实例，并不是单例方法
     */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manager GET:@"http://yjl.skyocean.com/tyapi/Public/skyocean/"
      parameters:paramaterDic
        progress:^(NSProgress * _Nonnull downloadProgress){
            
        }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"task.taskIdentifier = %lu",task.taskIdentifier);
             NSLog(@"task.taskDescription = %@",task.taskDescription);
             NSLog(@"task.currentRequest.URL = %@",task.currentRequest.URL);
             NSLog(@"task.originalRequest.URL = %@",task.originalRequest.URL);
             NSLog(@"task.countOfBytesSent = %lld",task.countOfBytesSent);
             NSLog(@"task.countOfBytesReceived = %lld",task.countOfBytesReceived);
             NSLog(@"task.countOfBytesExpectedToSend = %lld",task.countOfBytesExpectedToSend);
             NSLog(@"task.countOfBytesExpectedToReceive = %lld",task.countOfBytesExpectedToReceive);
             NSLog(@"task.state(Running|Suspended|Canceling|Completed) = %ld",task.state);
             NSLog(@"task.priority = %f",task.priority);
             if (@available(iOS 11.0, *)) {
                 NSLog(@"task.earliestBeginDate = %f",[task.earliestBeginDate timeIntervalSince1970] * 1000);
             } else {
                 // Fallback on earlier versions
             }
             NSLog(@"task.response.MIMEType = %@",task.response.MIMEType);
             NSLog(@"task.response.expectedContentLength = %lld",task.response.expectedContentLength);
             NSLog(@"task.response.textEncodingName = %@",task.response.textEncodingName);
             NSLog(@"task.response.suggestedFilename = %@",task.response.suggestedFilename);

             //打印 http状态码 （在这里打印肯定是200）
//             NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//             NSLog(@"********%ld",response.statusCode);
             NSLog(@"%@",responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@",[error localizedDescription]);
         }];
    [_indicatorView setAnimatingWithStateOfTask:task];
}

- (void)postAction{
    /************************字典作为参数**************************/
    NSDictionary *paramaterDic = [NSDictionary dictionaryWithObjectsAndKeys:@"User.Login",@"service",@"1524054772830",@"time",@"15116997355",@"uname",@"111111",@"password",@"2",@"bid",@"6e6110129de4f3abab47b17e73f47aba",@"cid",@"DEA362823EF6D402249B087A5495319AFC5014769CF84CBCEA9232638A5CE5EA",@"devicetoken", nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manager POST:@"http://yjl.skyocean.com/tyapi/Public/skyocean/" parameters:paramaterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    [_indicatorView setAnimatingWithStateOfTask:task];
}

- (void)localhostGetAction{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"id", nil];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.allowsCellularAccess = YES;
    manager.requestSerializer.timeoutInterval = 10;
    
    NSURLSessionDataTask *task = [manager GET:@"http://172.20.10.5:8080/skyocean/testGet/" parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    
    [_indicatorView setAnimatingWithStateOfTask:task];
    
}

- (void)localhostPostAction{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"id", nil];
    //1 . normal POST request
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manager POST:@"http://172.20.10.5:8080/skyocean/testPost/" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    [_indicatorView setAnimatingWithStateOfTask:task];
}

- (void)localhostSingleFileUploadAction{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manager POST:@"http://172.20.10.5:8080/skyocean/testSingleFileUpload/" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *img = [UIImage imageNamed:@"iOS_splash_750x1334"];
        NSData *data = UIImagePNGRepresentation(img);
        //name要与服务端的参数保持一致
        [formData appendPartWithFileData:data name:@"file" fileName:@"xxxxx.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress = %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    [_indicatorView setAnimatingWithStateOfTask:task];
}

- (void)localhostFilesUploadAction{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manager POST:@"http://172.20.10.5:8080/skyocean/testFilesUpload/" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 1; i <= 5; i++) {
            //UIImage设置jpg格式的图片需要name需要加.jpg后缀，不然创建的UIImage对象是nil
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
            NSData *data = UIImageJPEGRepresentation(image, 1);
            //name要与服务端的参数保持一致
            [formData appendPartWithFileData:data name:@"files" fileName:[NSString stringWithFormat:@"%d.jpg",i] mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress = %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    [_indicatorView setAnimatingWithStateOfTask:task];
}

- (void)afnUIKitTest{
    
    AFNUIKitViewController *avc = [[AFNUIKitViewController alloc]init];
    [self.navigationController pushViewController:avc animated:YES];
    
    
}


- (void)nsUrlSessionTaskTest{
    
    /*
     继承关系：
     NSURLSessionDataTask、NSURLSessionDownloadTask、NSURLSessionStreamTask 继承于NSURLSessionTask
     NSURLSessionDataTask虽然继承NSURLSessionTask，但没有添加任何功能;
     NSURLSessionDownloadTask只添加一个- (void)cancelByProducingResumeData:(void (^)(NSData * _Nullable resumeData))completionHandler;方法
     NSURLSessionStreamTask 添加了一些读和写的方法
     
     
     NSURLSessionUploadTask 继承于 NSURLSessionDataTask,但目前并未添加任何功能。
     */
    
    [self sessionDataTask];
    [self sessionDownloadTask];
    [self sessionStreamTask];
    
}

- (void)sessionDataTask{
//    [self sessionUploadTask];
    
//    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:operationQueue];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@""] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:<#(nonnull NSURLRequest *)#>]
//    
}

- (void)sessionStreamTask{
    
    
}

- (void)sessionDownloadTask{
    
    
}

- (void)sessionUploadTask{
    
    
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
