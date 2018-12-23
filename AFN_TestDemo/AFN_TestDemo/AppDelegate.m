//
//  AppDelegate.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/16.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"


#import "RSAUtil.h"
#import "SecurityUtil.h"
#import "GTUtil.h"

static NSString * const rsaPublicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCgVkvDZKRYp7oCdogcLMkrsJE8DLVsa/IwJIqIagQRC4zPGHkbE9ywAd68qKlAj/pgbelB6Pj5hGOeJ9gOFLJsyoGg5DOzM+g4o03eGiJG49F5WZFzQ6s0gIF+6wrC647Mwny2rLUqWnUOhJwW1bbmgzfXrhojdy2B234pSCP/JwIDAQAB";
static NSString * const rsaPrivateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKBWS8NkpFinugJ2iBwsySuwkTwMtWxr8jAkiohqBBELjM8YeRsT3LAB3ryoqUCP+mBt6UHo+PmEY54n2A4UsmzKgaDkM7Mz6DijTd4aIkbj0XlZkXNDqzSAgX7rCsLrjszCfLastSpadQ6EnBbVtuaDN9euGiN3LYHbfilII/8nAgMBAAECgYEAhne5NJaMKnoISxaDkjWRRZ3gP99crCBfzjZnJH7dCDqKjgi1UJs4wzfeSJSe1bGqRwMG1CsB26lHLpW14iFDfRv+sDdMFcIt38QBhKQXoIC/cu/R9ZQWXfqcV4PrvtmkfUzUUZ4AwkyCuaCI7/fb+kIryCtttzuGEjF0jMHNdgECQQDNxoIhmY7XhIwg5uKz2VJ3RC8yuOFvC81IWKE5L/ZfGefReukh7M7hi0U/YwqDtKE8yEo/NOFnJJ91n1J2d+onAkEAx3iopDksbnG4wBUkwvUjF5wsIuuHefAbQxXGCYQBFeE90or+JLxd9oHmlHh6jMebSa1kET5/AKm3ICozC0ljAQJAAUJSr4PyBM2R0e23u2P8BjDLnSLWdkh7NBMewWvStRhCe9ylqoh5Z5XjkZS4jr+/MNEE60gWjPwDYcPczE7FhwJAcADJOMU9tJo4ceqtZKb+2GABzG3R+V8f/7A3LdqoPV/nNdSD1Z7LaAISteVccrYV9O3eVWxxJa8mO3JWjQzdAQJBAIBdIPRXAKdz9xbODamDCwhZ8rcaLUYyi+plqySRsPKn0/5/ApJbNKrVlvt+8XTlBPTEd9EQ8L+4Bk+zMjx7foE=";


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navi;
    self.window.backgroundColor = [UIColor redColor];
    [self.window makeKeyAndVisible];
    
    /*
     rsa+aes加密思想：
     
     一、
     
     1. 将aes的密钥用rsa公钥加密，放在HttpHeader中，发送请求时传到服务端
     2. 在拼接请求参数时，将请求参数用1中的aes的密钥加密
     3. 服务器接收到请求后，先用rsa私钥解密HttpHeader的内容，得到aes的密钥
     4. 用aes密钥来解密客户端请求的参数。
     
     二、
     
     
     
     */
    
    
    //rsa加解密
//    NSString *aesKey = [[GTSecurityUtil shareInstance] arcRandon16String];
//    NSLog(@"%@",aesKey);
//    NSString *rsaEncrypedAndBase64EncodedString = [RSAUtil encryptString:aesKey publicKey:rsaPublicKey];
//    NSLog(@"%@",rsaEncrypedAndBase64EncodedString);
//    NSString *rsaDecryptedString = [RSAUtil decryptString:rsaEncrypedAndBase64EncodedString privateKey:rsaPrivateKey];
//    NSLog(@"%@",rsaDecryptedString);
    
    //aes加解密
//    NSString *aesKey = [[GTSecurityUtil shareInstance] arcRandon16String];
//    NSLog(@"%@",aesKey);
    NSString *paramaterString = @"helloworld";
    NSString *aesKey = @"GMFOBKENHJCPIADL";
    NSLog(@"aesKey的字节长度为： %d",[self convertToByte:aesKey]);
    NSString *aesEncryptedAndBase64EncodedString = [SecurityUtil encryptStringUsingAES:paramaterString aesKey:aesKey];
    NSLog(@"aesEncryptedAndBase64EncodedString = %@",aesEncryptedAndBase64EncodedString);
    NSString *aesDecryptedString = [SecurityUtil decryptStringUsingAES:aesEncryptedAndBase64EncodedString aesKey:aesKey];
    NSLog(@"aesDecryptedString = %@",aesDecryptedString);
    
    
    //base64编解码
//    NSString *originalString = @"ahadhdajkk";
//    NSString *originalString = rsaPublicKey;
//    NSString *base64EncodeString = [SecurityUtil encodeBase64String:originalString];
//    NSLog(@"base64EncodeString = %@",base64EncodeString);
//    NSString *base64DecodeString = [SecurityUtil decodeBase64String:base64EncodeString];
//    NSLog(@"base64DecodeString = %@",base64DecodeString);
    

    //三目运算符测试
//    NSString *str = @"123";
//    NSString *b = str?:@"444";
//    NSLog(@"%@",b);
    
//    __weak typeof (self) weakSelf1 = self;
//    __strong typeof (weakSelf1) strongSelf1 = weakSelf1;
//
//    __weak __typeof (self) weakSelf2 = self;
//    __strong __typeof (weakSelf2) strongSelf2 = weakSelf2;
    
//    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//
//    }];
    
    
//    MJPropertyTypeInt = @"fdkkdf";
    
//    NSDictionary *dic = @{};
//    NSLog(@"%@",dic[@"123"]);
    
//    NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow: - (60 * 60 * 24 * 7)];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    formatter.dateFormat = @"yyyy-MM-dd";
//    NSString *dateStr = [formatter stringFromDate:expirationDate];
//    NSLog(@"%@",dateStr);
    
//    [self clickButton];
    NSLog(@"%ld",sizeof(char));
    NSLog(@"%ld",sizeof(short int));
    NSLog(@"%ld",sizeof(int));
    NSLog(@"%ld",sizeof(float));
    NSLog(@"%ld",sizeof(double));
    NSLog(@"%ld",sizeof(long));
    NSLog(@"%ld",sizeof(long long));
    NSLog(@"%ld",sizeof(unsigned int));
    
    /**/
    NSLog(@"%ld",sizeof(char *));
    NSLog(@"%ld",sizeof(NSString *));
    

    return YES;
}

-(void)clickButton
{
    dispatch_sync(dispatch_get_main_queue(),^(void){
        NSLog(@"Hello");
    });
}

- (void)autoReleasePoolTest{
    
    @autoreleasepool{
        for (int i = 0; i<100; i++) {
            
            UIImage *img = [UIImage imageWithContentsOfFile:@""];
        }
        
    }
}

- (int)convertToByte:(NSString*)str {
    int strlength = 0;
    char* p = (char*)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
