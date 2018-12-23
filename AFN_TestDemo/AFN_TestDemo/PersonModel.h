//
//  PersonModel.h
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/4/20.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    PropertyValueAssignmentCallSetter,
    PropertyValueAssignmentNoCallSetter,
    PropertyValueAssignmentNoCallSetterButCopy
} PropertyValueAssignmentType;

@interface PersonModel : NSObject
@property (nonatomic, copy)NSString *firstName;
@property (nonatomic, strong)NSString *lastName;
@property (nonatomic, copy)NSArray *courses;

- (id)initWithFirstName:(NSString *)fName lastName:(NSString *)lName courses:(NSArray *)courses assignmentType:(PropertyValueAssignmentType)type;

@end
