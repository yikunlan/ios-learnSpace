//
//  FMDBManager.m
//  SwiftDemo
//
//  Created by  huangyikun on 2020/7/16.
//  Copyright © 2020  huangyikun. All rights reserved.
//

#import "FMDBManager.h"
#import <FMDB.h>

NSString *const kDBName = @"swiftDemo.sqlite";

@interface FMDBManager()

@property(strong, nonatomic) FMDatabase *db;

@end

@implementation FMDBManager
    
//- (FMDatabase *)db {
//    if (_db) {
//        return _db;
//    }
//    //获取数据库文件的路径
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
//    NSString *path = [docPath stringByAppendingPathComponent:kDBName];
//    
//    if (path) {
//        //1、创建数据库对象
//        _db = [FMDatabase databaseWithPath:path];
//        //2、打开数据库
//        if ([_db open]) {
//            // do something
//            return _db;
//        } else {
//            NSLog(@"数据库打开失败");
//            return nil;
//        }
//    } else {
//        NSLog(@"数据库打开失败,获取不到path");
//        return nil;
//    }
//}
//
//- (void)crateTable {
//    /***NSString *createTableSqlString = @"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL)";
//    [db executeUpdate:createTableSqlString];
//     */
//    NSString *crateTableSqlString = @"CREATE TABLE IF NOT EXITS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL)";
//    
//    [self.db executeUpdate:crateTableSqlString];
//}
//
//- (void)insert2DB {
//    // 写入数据 - 不确定的参数用？来占位
//    NSString *sql = @"insert into t_student (name, age) values (?, ?)";
//    NSString *name = [NSString stringWithFormat:@"韩雪 - %d",arc4random()];
//    NSNumber *age = [NSNumber numberWithInt:arc4random_uniform(100)];
//    [self.db executeUpdate:sql, name, age];
//}
//
//- (void)del {
//    // 删除数据
//    NSString *sql = @"delete from t_student where id = ?";
//    [self.db executeUpdate:sql, [NSNumber numberWithInt:1]];
//}
//
//- (void)update {
//    // 更改数据
//    NSString *sql = @"update t_student set name = '齐天大圣'  where id = ?";
//    [self.db executeUpdate:sql, [NSNumber numberWithInt:2]];
//}
//
//- (void)query {
//    // 4.查询
//    NSString *sql = @"select id, name, age FROM t_student";
//    FMResultSet *rs = [self.db executeQuery:sql];
//    while ([rs next]) {
//        int id = [rs intForColumnIndex:0];
//        NSString *name = [rs stringForColumnIndex:1];
//        int age = [rs intForColumnIndex:2];
////        Student *student = [[Student alloc] init];
////        student.name = name;
////        student.age = age;
////        [students addObject:student];
//    }
//}

@end
