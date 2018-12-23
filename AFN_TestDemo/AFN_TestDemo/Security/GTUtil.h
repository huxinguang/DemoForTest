//
//  GTUtil.h
//  GameTreasure
//
//  Created by kunpan on 16/3/25.
//  Copyright © 2016年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTUtil : NSObject

// 去空格
+(NSString*)trimString:(NSString*)str;

+(NSString*) urlEnocdeUtf8:(NSString*) string;


// 获取手机的identifier
+(NSString *)getDeviceIdentifier;

// 随机生成16位随机数
+(NSString *)arcRandon16String;


@end

// ==================加密util管理=======================//
@interface GTSecurityUtil : NSObject

+(id)shareInstance;

-(NSString *)arcRandon16String;
-(NSString *)getSecurityString;

-(NSString *)encryptStringUsingAES:(NSString *)paramsString;

@end

