//
//  Car.h
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/27.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject{
    @public
    NSString *color;
    @protected
    int speed;
    @private
    int age;
    
}

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *brand;
@property (nonatomic,copy)NSString *country;

@end
