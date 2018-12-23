//
//  InvocationTarget.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/10.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "InvocationTarget.h"

@implementation InvocationTarget

+ (instancetype)shareTarget{
    static InvocationTarget *target = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        target = [[InvocationTarget alloc]init];
    });
    return target;
}

-(void)test:(NSString *)str{
    
    NSLog(@"%@",str);
}


@end
