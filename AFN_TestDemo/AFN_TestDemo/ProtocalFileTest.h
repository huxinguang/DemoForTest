//
//  ProtocalFileTest.h
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/4.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import <Foundation/Foundation.h>


//创建方式： File -> New File ->Objective C File -> File Type -> Protocol

@protocol ProtocalFileTest <NSObject>

@optional
- (void)testProtocolFunctionOne;

@required
- (void)testProtocolFunctionTwo;



@end
