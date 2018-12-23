//
//  PNGJPEGViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/22.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "PNGJPEGViewController.h"

@interface PNGJPEGViewController ()

@end

@implementation PNGJPEGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     PNGs can have an alpha channel, JPEGs cannot. PNGs have lossless compression, JPEGs allow you to choose a quality of anywhere between 0 and 100%. So if you need the alpha channel – how transparent each pixel is – you are stuck with PNG. But if you don’t need a pixel-perfect rendition of your image then you can go with the perceptually optimized JPEG which basically omits information you don’t see anyway. For most kinds of images you can go with around 60-70% of quality without any visual artifacts spoiling the visual fidelity. If you have “sharp pixels”, like for text you might want to go higher, for photos you can choose a lower setting.
     */
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 756/2, 454/2)];
    imageView.image = [UIImage imageNamed:@"6"];
    [self.view addSubview:imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100 + 454/2 + 50, 533/2, 300/2)];
    imageView1.image = [UIImage imageNamed:@"5.jpg"];
    [self.view addSubview:imageView1];
    
    
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
