//
//  ArichiverModel.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/30.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "ArichiverModel.h"

@implementation ArichiverModel


//归档的时候调用
- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInt:self.age forKey:@"age"];
    [coder encodeInt:self.gender forKey:@"gender"];
    [coder encodeObject:self.family forKey:@"family"];
    [coder encodeBool:self.married forKey:@"married"];
}

//解归档的时候调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntForKey:@"age"];
        self.gender = [aDecoder decodeIntForKey:@"gender"];
        self.family = [aDecoder decodeObjectForKey:@"family"];
        self.married = [aDecoder decodeBoolForKey:@"married"];
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"name = %@, age = %d,gender = %ld, family = %@, married = %d",self.name,self.age,self.gender,self.family,self.married];
}


@end
