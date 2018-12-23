

//
//  GTUtil.m
//  GameTreasure
//
//  Created by kunpan on 16/3/25.
//  Copyright © 2016年 __MyCompanyName__. All rights reserved.
//

#import "GTUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import "SecurityUtil.h"

@implementation GTUtil

// 随机生成16位随机数
+(NSString *)arcRandon16String
{
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstufwsyz";
    
    // Get the characters into a C array for efficient shuffling
    NSUInteger numberOfCharacters = 16;//[alphabet length];
    unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
    [alphabet getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];
    
    // Perform a Fisher-Yates shuffle
    for (NSUInteger i = 0; i < 16; ++i) {
        NSInteger j = (arc4random_uniform(numberOfCharacters - i) + i); // (arc4random() % [alphabet length]);//
        unichar c = characters[i];
        characters[i] = characters[j];
        characters[j] = c;
    }
    
    // Turn the result back into a string
    NSString *result = [NSString stringWithCharacters:characters length:numberOfCharacters];
    return result;
}

@end

// ==================加密util管理=======================//
@implementation GTSecurityUtil
{
    NSString * _randomKeyForAES;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        _randomKeyForAES = @"";
    }
    return self;
}

+(id)shareInstance
{
    static dispatch_once_t onceToken;
    static GTSecurityUtil * util = nil;
    dispatch_once(&onceToken, ^{
        util = [[GTSecurityUtil alloc] init];
    });
    return util;
}

-(NSString *)arcRandon16String
{
    NSString * result = @"";
     @synchronized(self)
    {
        NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstufwsyz";
        // Get the characters into a C array for efficient shuffling
        NSUInteger numberOfCharacters = 16;//[alphabet length];
        unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
        [alphabet getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];
        
        // Perform a Fisher-Yates shuffle
        for (NSUInteger i = 0; i < 16; ++i) {
            NSInteger j = (arc4random_uniform(numberOfCharacters - i) + i); // (arc4random() % [alphabet length]);//
            unichar c = characters[i];
            characters[i] = characters[j];
            characters[j] = c;
        }
        
        // Turn the result back into a string
         result = [NSString stringWithCharacters:characters length:numberOfCharacters];
        _randomKeyForAES = result;
    }
    return result;
}

-(NSString *)getSecurityString
{
    return _randomKeyForAES;
}

-(NSString *)encryptStringUsingAES:(NSString *)paramsString
{
    NSString * aesString = @"";
    @synchronized(self)
    {
        aesString = [SecurityUtil encryptStringUsingAES:paramsString aesKey:_randomKeyForAES];
    }
    return aesString;
}

@end


