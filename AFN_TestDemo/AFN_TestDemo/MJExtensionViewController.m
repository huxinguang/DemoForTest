//
//  MJExtensionViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/2.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "MJExtensionViewController.h"
#import "User.h"
#import "Status.h"
#import "Ad.h"
#import "StatusResult.h"
#import "Student.h"
#import "Dog.h"
#import "Book.h"
#import "NullModel.h"
//

@interface MJExtensionViewController (){
    User *_user;
    Status *_status;
    StatusResult *_statusResult;
    Student *_student;
}
@end

@implementation MJExtensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"MJExtensionSampleOne" forState:UIControlStateNormal];
    btn.frame =  CGRectMake(20, 90, kScreenWidth-20*2, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(mjExtensionSampleOne) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"MJExtensionSampleTwo" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(20, 90+40, kScreenWidth-20*2, 30);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(mjExtensionSampleTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"MJExtensionSampleThree" forState:UIControlStateNormal];
    btn1.frame =  CGRectMake(20, 90+40+40, kScreenWidth-20*2, 30);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(mjExtensionSampleThree) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"MJExtensionSampleFour" forState:UIControlStateNormal];
    btn2.frame =  CGRectMake(20, 90+40+40+40, kScreenWidth-20*2, 30);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(mjExtensionSampleFour) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"MJExtensionSampleFive" forState:UIControlStateNormal];
    btn3.frame =  CGRectMake(20, 90+40+40+40+40, kScreenWidth-20*2, 30);
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(mjExtensionSampleFive) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setTitle:@"MJExtensionSampleSix" forState:UIControlStateNormal];
    btn4.frame =  CGRectMake(20, 90+40+40+40+40+40, kScreenWidth-20*2, 30);
    btn4.backgroundColor = [UIColor redColor];
    [btn4 addTarget:self action:@selector(mjExtensionSampleSix) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn5 setTitle:@"MJExtensionSampleSeven" forState:UIControlStateNormal];
    btn5.frame =  CGRectMake(20, 90+40+40+40+40+40+40, kScreenWidth-20*2, 30);
    btn5.backgroundColor = [UIColor redColor];
    [btn5 addTarget:self action:@selector(mjExtensionSampleSeven) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn6 setTitle:@"MJExtensionSampleEight" forState:UIControlStateNormal];
    btn6.frame =  CGRectMake(20, 90+40+40+40+40+40+40+40, kScreenWidth-20*2, 30);
    btn6.backgroundColor = [UIColor redColor];
    [btn6 addTarget:self action:@selector(mjExtensionSampleEight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn7 setTitle:@"MJExtensionSampleNine" forState:UIControlStateNormal];
    btn7.frame =  CGRectMake(20, 90+40+40+40+40+40+40+40, kScreenWidth-20*2, 30);
    btn7.backgroundColor = [UIColor redColor];
    [btn7 addTarget:self action:@selector(mjExtensionSampleNine) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn7];
    
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn8 setTitle:@"MJExtension_Deal_Null" forState:UIControlStateNormal];
    btn8.frame =  CGRectMake(20, 90+40+40+40+40+40+40+40+40, kScreenWidth-20*2, 30);
    btn8.backgroundColor = [UIColor redColor];
    [btn8 addTarget:self action:@selector(MJExtension_Deal_Null) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn8];
    
    
}

- (void)mjExtensionSampleOne{
    
//    The most simple JSON -> Model【最简单的字典转模型】
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"id":@"1"};
    [manager POST:@"http://172.20.10.5:8080/skyocean/testMJSampleOne/" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *response = (NSDictionary *)responseObject;
            if ([[response objectForKey:@"code"] intValue] == 0) {
                NSDictionary *user = [response objectForKey:@"data"];
                _user = [User mj_objectWithKeyValues:user];
                NSLog(@"name=%@, icon=%@, age=%u, height=%@, money=%@, sex=%d, gay=%d", _user.name, _user.icon, _user.age, _user.height, _user.money, _user.sex, _user.gay);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

- (void)mjExtensionSampleTwo{
    //Model contains model【模型中嵌套模型】
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"id":@"1"};
    [manager POST:@"http://172.20.10.5:8080/skyocean/testMJSampleTwo/" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *response = (NSDictionary *)responseObject;
            if ([[response objectForKey:@"code"] intValue] == 0) {
                NSDictionary *data = [response objectForKey:@"data"];
                _status = [Status mj_objectWithKeyValues:data];
                
                NSString *text = _status.text;
                NSString *name = _status.user.name;
                NSString *icon = _status.user.icon;
                NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
                
                NSString *text2 = _status.retweetedStatus.text;
                NSString *name2 = _status.retweetedStatus.user.name;
                NSString *icon2 = _status.retweetedStatus.user.icon;
                NSLog(@"text2=%@, name2=%@, icon2=%@", text2, name2, icon2);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

- (void)mjExtensionSampleThree{
//    Model contains model-array【模型中有个数组属性，数组里面又要装着其他模型】
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"id":@"1"};
    [manager POST:@"http://172.20.10.5:8080/skyocean/testMJSampleThree/" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *response = (NSDictionary *)responseObject;
            if ([[response objectForKey:@"code"] intValue] == 0) {
                
                NSDictionary *data = [response objectForKey:@"data"];
                
                [StatusResult mj_setupObjectClassInArray:^NSDictionary *{
                    return @{
                             @"statuses":[Status class],
                             @"ads":[Ad class]
                             };
                }];
                
                _statusResult = [StatusResult mj_objectWithKeyValues:data];
                
                // Printing
                NSLog(@"totalNumber=%@", _statusResult.totalNumber);
                // Printing
                for (Status *status in _statusResult.statuses) {
                    NSString *text = status.text;
                    NSString *name = status.user.name;
                    NSString *icon = status.user.icon;
                    NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
                }

                // Printing
                for (Ad *ad in _statusResult.ads) {
                    NSLog(@"image=%@, url=%@", ad.image, ad.url);
                }

            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
}

- (void)mjExtensionSampleFour{
//    Model name - JSON key mapping【模型中的属性名和字典中的key不相同(或者需要多级映射)】
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"id":@"1"};
    [manager POST:@"http://172.20.10.5:8080/skyocean/testMJSampleFour/" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *response = (NSDictionary *)responseObject;
        if ([[response objectForKey:@"code"] intValue] == 0) {

            NSDictionary *data = [response objectForKey:@"data"];
        
            [Student mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"ID":@"id",
                         @"desc":@"description",
                         @"oldName":@"name.oldName",
                         @"nowName":@"name.newName",
                         @"nameChangedTime":@"name.info[1].nameChangedTime",
                         @"bag":@"other.bag"
                         };
            }];
            
            _student = [Student mj_objectWithKeyValues:data];
            
            // Printing
            NSLog(@"ID=%@, desc=%@, oldName=%@, nowName=%@, nameChangedTime=%@",
                  _student.ID, _student.desc, _student.oldName, _student.nowName, _student.nameChangedTime);
            NSLog(@"bagName=%@, bagPrice=%f", _student.bag.name, _student.bag.price);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    
}

- (void)mjExtensionSampleFive{
//    JSON array -> model array【将一个字典数组转成模型数组】
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"id":@"1"};
    [manager POST:@"http://172.20.10.5:8080/skyocean/testMJSampleFive/" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *response = (NSDictionary *)responseObject;
        if ([[response objectForKey:@"code"] intValue] == 0) {
            NSArray *data = (NSArray *)[response objectForKey:@"data"];
            NSArray *userArray = [User mj_objectArrayWithKeyValuesArray:data];
            // Printing
            for (User *user in userArray) {
                NSLog(@"name=%@, icon=%@", user.name, user.icon);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)mjExtensionSampleSix{
//    Model -> JSON【将一个模型转成字典】
    
//    simple situation
    
    User *user = [[User alloc] init];
    user.name = @"Jack";
    user.icon = @"lufy.png";
    
    Status *status = [[Status alloc] init];
    status.user = user;
    status.text = @"Nice mood!";
    
    // Status -> JSON
    NSDictionary *statusDict = status.mj_keyValues;
    NSLog(@"%@", statusDict);
    
    
//    more complex situation
    
    Student *stu = [[Student alloc] init];
    stu.ID = @"123";
    stu.oldName = @"rose";
    stu.nowName = @"jack";
    stu.desc = @"handsome";
    stu.nameChangedTime = @"2018-09-08";
    
    Bag *bag = [[Bag alloc] init];
    bag.name = @"a red bag";
    bag.price = 205;
    stu.bag = bag;
    
    NSDictionary *stuDict = stu.mj_keyValues;
    NSLog(@"%@", stuDict);

    
}

- (void)mjExtensionSampleSeven{
//    Model array -> JSON array【将一个模型数组转成字典数组】
    
    // New model array
    User *user1 = [[User alloc] init];
    user1.name = @"Jack";
    user1.icon = @"lufy.png";
    
    User *user2 = [[User alloc] init];
    user2.name = @"Rose";
    user2.icon = @"nami.png";
    
    NSArray *userArray = @[user1, user2];
    
    // Model array -> JSON array
    NSArray *dictArray = [User mj_keyValuesArrayWithObjectArray:userArray];
    NSLog(@"%@", dictArray);
}

- (void)mjExtensionSampleEight{
//    Camel -> underline【统一转换属性名（比如驼峰转下划线）】
    
    // NSDictionary
    NSDictionary *dict = @{
                           @"nick_name" : @"旺财",
                           @"sale_price" : @"10.5",
                           @"run_speed" : @"100.9"
                           };
    // NSDictionary -> Dog
    Dog *dog = [Dog mj_objectWithKeyValues:dict];
    
    // printing
    NSLog(@"nickName=%@, scalePrice=%@ runSpeed=%@", dog.nickName, dog.salePrice, dog.runSpeed);
}

- (void)mjExtensionSampleNine{
//    NSString -> NSDate, nil -> @""【过滤字典的值（比如字符串日期处理为NSDate、字符串nil处理为@""）】
    
    // NSDictionary
    NSDictionary *dict = @{
                           @"name" : @"5分钟突破iOS开发",
                           @"publishedTime" : @"2011-09-10"
                           };
    // NSDictionary -> Book
    Book *book = [Book mj_objectWithKeyValues:dict];
    
    // printing
    NSLog(@"name=%@, publisher=%@, publishedTime=%@", book.name, book.publisher, book.publishedTime);
    
}

- (void)MJExtension_Deal_Null{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"id":@"1"};
    [manager POST:@"http://172.20.10.5:8080/skyocean/testMJSampleDealNull/" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *response = (NSDictionary *)responseObject;
        if ([[response objectForKey:@"code"] intValue] == 0) {
            
            NSDictionary *data = [response objectForKey:@"data"];
            NullModel *nm = [NullModel mj_objectWithKeyValues:data];
            NSLog(@"%@",nm.description);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
