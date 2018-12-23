//
//  Book.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/2.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "Book.h"
#import "MJExtension.h"

@implementation Book

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"publisher"]) {
        if (oldValue == nil) return @"";
    }else if (property.type.typeClass == [NSDate class]){
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt dateFromString:oldValue];
    }
    return oldValue;
}

@end
