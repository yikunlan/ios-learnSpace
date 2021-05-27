//
//  AddContactVC.m
//  tongxunlu
//
//  Created by  huangyikun on 2020/5/28.
//  Copyright © 2020  huangyikun. All rights reserved.
//

#import "AddContactVC.h"

@interface AddContactVC ()
@property (weak, nonatomic) IBOutlet UITextField *tfUser;
@property (weak, nonatomic) IBOutlet UITextField *tfNum;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
- (IBAction)addContact:(id)sender;

@end

@implementation AddContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tfUser addTarget:self action:@selector(checkCanAdd) forControlEvents:UIControlEventEditingChanged];
    [_tfNum addTarget:self action:@selector(checkCanAdd) forControlEvents:UIControlEventEditingChanged];
    
    NSLog(@"%@",self.delegate);
    
}

- (void)checkCanAdd{
    if(_tfNum.text.length > 0 && _tfUser.text.length > 0){
        _btnAdd.enabled = true;
    }else{
        _btnAdd.enabled = false;
    }
}


- (IBAction)addContact:(id)sender {
    
    //判断代理方法是否能够响应
    if([self.delegate respondsToSelector:@selector(addFinish:)]){
        if(_tfNum.text.length > 0 && _tfUser.text.length > 0){
            ContactModel *model = [[ContactModel alloc] init];
            model.name = self.tfUser.text;
            model.number = self.tfNum.text;
            
            [self.delegate addFinish:model];
            [self.navigationController popViewControllerAnimated:true];
        }
    }
}
@end
