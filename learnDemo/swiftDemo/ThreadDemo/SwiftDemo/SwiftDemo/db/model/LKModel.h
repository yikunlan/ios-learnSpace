//
//  LKModel.h
//  SwiftDemo
//
//  Created by Yk Huang on 2020/8/12.
//  Copyright © 2020  huangyikun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface LKModel : NSObject

@property(copy,nonatomic)NSString *name;
@property(assign,nonatomic)NSInteger age;

@end

NS_ASSUME_NONNULL_END
