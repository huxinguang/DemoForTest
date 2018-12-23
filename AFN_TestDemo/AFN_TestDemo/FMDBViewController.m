//
//  FMDBViewController.m
//  AFN_TestDemo
//
//  Created by huxinguang on 2018/5/29.
//  Copyright © 2018年 huxinguang. All rights reserved.
//

#import "FMDBViewController.h"
#import "FMDB.h"
#import "FMDBMigrationManager.h"

@interface FMDBViewController (){
    FMDatabase *_db;
}
@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"path" forState:UIControlStateNormal];
    btn.frame =  CGRectMake(20, 90, kScreenWidth-20*2, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(pathAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"create_table" forState:UIControlStateNormal];
    btn0.frame =  CGRectMake(20, 90+40, kScreenWidth-20*2, 30);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(createTable) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"insert" forState:UIControlStateNormal];
    btn2.frame =  CGRectMake(20, 90+40*2, kScreenWidth-20*2, 30);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(insertAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"select" forState:UIControlStateNormal];
    btn1.frame =  CGRectMake(20, 90+40*3, kScreenWidth-20*2, 30);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"delete" forState:UIControlStateNormal];
    btn3.frame =  CGRectMake(20, 90+40*4, kScreenWidth-20*2, 30);
    btn3.backgroundColor = [UIColor redColor];
    [btn3 addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setTitle:@"update" forState:UIControlStateNormal];
    btn4.frame =  CGRectMake(20, 90+40*5, kScreenWidth-20*2, 30);
    btn4.backgroundColor = [UIColor redColor];
    [btn4 addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn5 setTitle:@"migrate" forState:UIControlStateNormal];
    btn5.frame =  CGRectMake(20, 90+40*6, kScreenWidth-20*2, 30);
    btn5.backgroundColor = [UIColor redColor];
    [btn5 addTarget:self action:@selector(migrateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
}

- (void)pathAction{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [document stringByAppendingPathComponent:@"default.db"];
    NSLog(@"path = %@",path);
    _db = [FMDatabase databaseWithPath:path];
    //第一次创建必须打开，不然在路径下看不到default.db
    if (![_db open]) {
        NSLog(@"数据库打开失败！");
    }
    [_db close];
    
}

- (void)createTable{
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [document stringByAppendingPathComponent:@"default.db"];
    NSLog(@"path = %@",path);
    _db = [FMDatabase databaseWithPath:path];
    if (![_db open]) {
        NSLog(@"数据库打开失败");
    }else{
        BOOL createTable = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS 'tb_user' (id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL, age integer NOT NULL, gender text NOT NULL);"];
        if (!createTable) {
            NSLog(@"创建user表失败");
        }
    }
    
}

- (void)insertAction{
    
    NSArray *names = @[@"jack",@"tom",@"jerry",@"tomcat"];
    NSArray *ages = @[@14,@16,@18,@20];
    NSArray *genders = @[@"male",@"female",@"female",@"male"];
    
    [self createTable];
    
//    if ([_db executeUpdate:@"INSERT INTO tb_user(name, age, gender) VALUES(?,?,?);", @"jack",18,@"male"]) {
//        NSLog(@"")
//    }
    
    for (int i = 0; i < names.count; i++) {
        [_db executeUpdateWithFormat:@"INSERT INTO tb_user(name, age, gender) VALUES(%@,%d,%@)",names[i],[ages[i] intValue],genders[i]];
    }

    [_db close];
    
}

- (void)selectAction{
    [self createTable];
    
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM tb_user WHERE gender = 'male'"];
    while ([resultSet next]) {
        int user_id = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        int age = [resultSet intForColumn:@"age"];
        NSString *gender = [resultSet stringForColumn:@"gender"];
        NSLog(@"user_id = %d, name = %@, age = %d, gender = %@", user_id,name,age,gender);
    }
    
    [_db close];
}

- (void)deleteAction{
    [self createTable];
    [_db executeUpdate:@"DELETE FROM tb_user WHERE age > 16;"];
    [_db close];
}

- (void)updateAction{
    [self createTable];
    [_db executeUpdate:@"UPDATE tb_user SET age = ? WHERE name = ?;",@22,@"tom"];//不能直接用数字22
    [_db close];
    
}


//数据库迁移方式1 ： 添加sql文件的方式进行记录版本和升级操作。
- (void)migrateAction{
    
    [self createTable];
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [document stringByAppendingPathComponent:@"default.db"];
    
    //将数据库与我们的FMDBMigrationManager关联起来
    //path是要升级的数据库的地址
    //[NSBundle mainBundle]是保存数据库升级文件的位置,所谓升级文件,就是一些sql文件,在里面写入一些对数据库操作的语句
    /*
     添加字段：
     alter table 表名 add 字段名 类型
     删除字段：
     由于sqlite 字段操作不支持drop（表操作可以drop），可以按照2_UserTable.sql中的那种形式，先根据原始表创建临时表（只选择需要的字段），然后把原始表删除，再把临时表名称改成原始表名称
     */
    //FMDBMigrationManager 将会根据创建时给入的NSBundle自行寻找sql文件,对比版本号进行操作
    FMDBMigrationManager *manager = [FMDBMigrationManager managerWithDatabaseAtPath:path migrationsBundle:[NSBundle mainBundle]];
    BOOL resultState=NO;
    NSError * error=nil;
    if (!manager.hasMigrationsTable) {
        //执行完该语句,再去我们的数据库中查看,会发现多了一个表 schema_migrations, 这个表就是用来存储版本号的
        resultState=[manager createMigrationsTable:&error];
    }
    //此时如果还没有添加升级文件,所以执行完这段代码数据库并没有什么变化。
    /*
     对于数据库升级，FMDBMigrationManager提供了两种升级方式：
     1. 添加sql文件，sql文件里包含数据库迁移的一些sql语句（比如工程文件里的1_UserTable.sql和2_UserTable.sql）
     2. 添加遵循FMDBMigrating协议的 Objective-C 类， 在协议方法 - (BOOL)migrateDatabase:(FMDatabase *)database error:(out NSError *__autoreleasing *)error 中，可使用[database executeUpdate:@"sql 语句"]的形式来执行迁移（比如工程文件的MigrationOne类）
     
     Note that instances of FMDBMigrationManager are initialized with a migrationsBundle. This bundle is scanned for migration files using the approach detailed in the implementation section. For a typical iOS app, it would be common to use the main application bundle.
     
     注意: FMDBMigrationManager会自动扫描bundle中的迁移文件（包括sql 和 自定义的遵循FMDBMigrating的Objective-C类）
     */
    
    resultState=[manager migrateDatabaseToVersion:UINT64_MAX progress:nil error:&error];
    
//    [_db close];
    
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
