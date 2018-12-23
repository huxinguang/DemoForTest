//
//  Book.h
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/2.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
@property (copy, nonatomic)NSString *name;
@property (strong, nonatomic)NSDate *publishedTime;
@property (copy, nonatomic)NSString *publisher;

@end
