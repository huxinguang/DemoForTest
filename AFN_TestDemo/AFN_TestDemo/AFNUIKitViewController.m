//
//  AFNButtonViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/9.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "AFNUIKitViewController.h"

@interface AFNUIKitViewController ()

@end

@implementation AFNUIKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    //********************   UIButton+AFNetworking  *********************
    
    UIButton *afnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    afnBtn.frame = CGRectMake(10, 100, 60, 60);
//    [afnBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:@"http://172.20.10.5:8080/uploads/apple-touch-icon-120x120.png"]];
//    [afnBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:@"http://172.20.10.5:8080/uploads/apple-touch-icon-120x120.png"] placeholderImage:[UIImage imageNamed:@""]];
    
    //可以自定义缓存策略
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.20.10.5:8080/uploads/apple-touch-icon-120x120.png"] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:1];
    __weak UIButton *weakBtn = afnBtn;
    [afnBtn setImageForState:UIControlStateNormal withURLRequest:request placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        //If the image was returned from cache, the response parameter will be `nil`.
        if (!response) {
            NSLog(@"image was returned from cache");
        }else{
            NSLog(@"image was returned from sever");
        }
        [weakBtn setImage:image forState:UIControlStateNormal];
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"button 获取图片失败");
    }];
    
    
    [afnBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:afnBtn];
    
    //********************   UIImageView+AFNetworking  *********************
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 200, 266, 150)];
//    [imageView setImageWithURL:[NSURL URLWithString:@"http://172.20.10.5:8080/uploads/1524380607207.jpg"]];
//    [imageView setImageWithURL:[NSURL URLWithString:@"http://172.20.10.5:8080/uploads/1524380607207.jpg"] placeholderImage:[UIImage imageNamed:@""]];
    
    //可以自定义缓存策略
    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.20.10.5:8080/uploads/1524380607207.jpg"] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:1];
    
    __weak UIImageView *weakImgView = imageView;
    [imageView setImageWithURLRequest:request1 placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        
        //If the image was returned from cache, the response parameter will be `nil`.
        if (!response) {
            NSLog(@"image was returned from cache");
        }else{
            NSLog(@"image was returned from sever");
        }
        [weakImgView setImage:image];
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"imageview 获取图片失败");
    }];
    
    
    [self.view addSubview:imageView];
    
    

}



- (void)btnAction{
    
    //********************   UIProgressView+AFNetworking  *********************
    
    UIProgressView *progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(10, 400, kScreenWidth-10*2, 10);
    progressView.progressTintColor = [UIColor blueColor];
    progressView.trackTintColor = [UIColor lightGrayColor];
    [self.view addSubview:progressView];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.20.10.5:8080/uploads/20180509.mp4"]];
    //这个task 不是在downloadTaskWithRequest内部resume, 需要在外部[task resume]
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"########### %f",downloadProgress.fractionCompleted);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *homeDir = NSHomeDirectory();
        NSLog(@"homeDir = %@",homeDir);
        
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //上面docPath对应的文件夹也就是document文件夹系统已经创建好了，下面我们要在此文件夹下再创建一个video文件夹
        NSString *destinationDir = [docPath stringByAppendingPathComponent:@"video"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        /*
         - (BOOL)fileExistsAtPath:(NSString *)path;
         
         Returns a Boolean value that indicates whether a file or directory exists at a specified path
         
         path
         The path of the file or directory. If path begins with a tilde (~), it must first be expanded with stringByExpandingTildeInPath; otherwise, this method returns NO.
         
         */
        
        if (![fileManager fileExistsAtPath:destinationDir]) {
            /*
             
             - (BOOL)createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary<NSFileAttributeKey, id> *)attributes error:(NSError * _Nullable *)error;
             
             
             createIntermediates
             
             If YES, this method creates any non-existent parent directories as part of creating the directory in path. If NO, this method fails if any of the intermediate parent directories does not exist. This method also fails if any of the intermediate path elements corresponds to a file and not a directory.
             
             如果createIntermediates参数为yes，则此方法会根据第一个参数path来创建对应的文件夹（可以是多级文件夹）。 如果为NO，则如果任何中间父目录不存在，则此方法失败。 如果任何中间路径元素对应于文件而不是目录，则此方法也会失败。

             */
            [fileManager createDirectoryAtPath:destinationDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSString *fileFullPath = [destinationDir stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"fileFullPath = %@",fileFullPath);
        
        return [NSURL fileURLWithPath:fileFullPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"filePath = %@",filePath.absoluteString);
    }];
    
    /*
     NSURLSessionTask objects are always created in a suspended state and must be sent the -resume message before they will execute.
     */
    [task resume];
    
    [progressView setProgressWithDownloadProgressOfTask:task animated:YES];
    
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
