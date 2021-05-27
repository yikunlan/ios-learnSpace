//
//  LKModel.m
//  SwiftDemo
//
//  Created by Yk Huang on 2020/8/12.
//  Copyright © 2020  huangyikun. All rights reserved.
//

#import "LKModel.h"

@implementation LKModel

///如果不设置名称的话，就会用model的名称作为表名，也就是：LKModel作为表名
+ (NSString *)getTableName {
    return @"LKTestTable";
}

//+ (void)dbDidCreateTable:(LKDBHelper *)helper tableName:(NSString *)tableName {
//
//}
//
//+ (void)dbDidAlterTable:(LKDBHelper *)helper tableName:(NSString *)tableName addColumns:(NSArray *)columns {
//
//}
//
//+ (BOOL)dbWillInsert:(NSObject *)entity {
//
//}
//+ (void)dbDidInserted:(NSObject *)entity result:(BOOL)result {
//
//}
//
//+ (BOOL)dbWillUpdate:(NSObject *)entity {
//
//}
//+ (void)dbDidUpdated:(NSObject *)entity result:(BOOL)result {
//
//}
//
//+ (BOOL)dbWillDelete:(NSObject *)entity {
//
//}
//+ (void)dbDidDeleted:(NSObject *)entity result:(BOOL)result {
//
//}
//
//+ (void)dbDidSeleted:(NSObject *)entity {
//
//}

@end
