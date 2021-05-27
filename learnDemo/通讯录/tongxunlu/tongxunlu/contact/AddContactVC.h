//
//  AddContactVC.h
//  tongxunlu
//
//  Created by  huangyikun on 2020/5/28.
//  Copyright © 2020  huangyikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactModel.h"

NS_ASSUME_NONNULL_BEGIN

@class AddContactDelegate;
@protocol AddContactDelegate <NSObject>

@optional
- (void)addFinish : (ContactModel *)model;

@end

@interface AddContactVC : UIViewController

@property(nonatomic , weak) id<AddContactDelegate> delegate;
//@property(nonatomic , weak) AddContactDelegate *delegate;

@end

NS_ASSUME_NONNULL_END
