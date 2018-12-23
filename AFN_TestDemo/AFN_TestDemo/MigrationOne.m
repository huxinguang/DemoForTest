//
//  Migration.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/29.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "MigrationOne.h"

@implementation MigrationOne

- (NSString *)name{
    return @"UserTable";
}

- (uint64_t)version{
    return 3;
}

- (BOOL)migrateDatabase:(FMDatabase *)database error:(out NSError *__autoreleasing *)error{
    if ([database open]) {
        [database executeUpdate:@"ALTER TABLE tb_user ADD description text"];
    }
    return YES;
}


@end
