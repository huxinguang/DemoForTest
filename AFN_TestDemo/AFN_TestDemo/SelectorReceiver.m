//
//  SelectorReceiver.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/10.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "SelectorReceiver.h"

@implementation SelectorReceiver

+(instancetype)shareReceiver{
    static SelectorReceiver *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[SelectorReceiver alloc]init];
    });
    
    return shareInstance;
}


- (void)notExistInstanceMethod{
    NSLog(@"forwardingTargetForSelector转发方法成功");
}



@end
