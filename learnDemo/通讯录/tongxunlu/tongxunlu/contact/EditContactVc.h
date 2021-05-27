//
//  EditContactVc.h
//  tongxunlu
//
//  Created by  huangyikun on 2020/6/8.
//  Copyright © 2020  huangyikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface EditContactVc : UIViewController

@property (strong,nonatomic)ContactModel *model;

//第一种block
typedef void (^EditModel) (ContactModel *);
@property (copy,nonatomic)EditModel editBlock;
- (void)editModel:(EditModel)block;

//第二种block
@property(copy,nonatomic)void (^test222)(ContactModel *model);

@end

NS_ASSUME_NONNULL_END
