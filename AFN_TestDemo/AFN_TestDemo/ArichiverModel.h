//
//  ArichiverModel.h
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/30.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,Gender) {
    GenderMale,
    GenderFemale
};

@interface ArichiverModel : NSObject<NSCoding>
@property (nonatomic, copy)NSString *name;
@property (nonatomic, assign)int age;
@property (nonatomic, assign)Gender gender;
@property (nonatomic, strong)NSArray *family;
@property (nonatomic, assign)BOOL married;

@end
