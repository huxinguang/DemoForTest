//
//  MRC_Person.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/27.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "MRC_Person.h"

@implementation MRC_Person

-(void)setName:(NSString *)name{
    if (_name != name) {
        [_name release];
        _name = [name copy];
    }
}

@end
