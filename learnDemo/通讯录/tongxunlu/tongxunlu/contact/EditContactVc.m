//
//  EditContactVc.m
//  tongxunlu
//
//  Created by  huangyikun on 2020/6/8.
//  Copyright © 2020  huangyikun. All rights reserved.
//

#import "EditContactVc.h"

@interface EditContactVc ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
- (IBAction)change:(id)sender;

@end

@implementation EditContactVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

- (void)initData{
    if(self.model){
        [self.userNameTF setText:self.model.name];
        [self.numberTF setText:self.model.number];
    }
    //默认编辑电话号码
    [self.numberTF becomeFirstResponder];
}

- (void)editModel:(EditModel)block{
    self.editBlock = block;
}

- (IBAction)change:(id)sender {
    if(self.userNameTF.text.length>0 && self.numberTF.text.length>0){
        self.model.number = self.numberTF.text;
        self.model.name = self.userNameTF.text;
        [self.navigationController popViewControllerAnimated:true];
        self.test222(self.model);
//        if(self.editBlock){
//            self.editBlock(self.model);
//        }
    }
    
}
@end
