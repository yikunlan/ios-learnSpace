//
//  LoginVC.m
//  tongxunlu
//
//  Created by  huangyikun on 2020/5/25.
//  Copyright © 2020  huangyikun. All rights reserved.
//

#import "LoginVC.h"
#import "SVProgressHUD.h"
#import "ContactVC.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *tfUsername;
@property (weak, nonatomic) IBOutlet UITextField *tfPwd;
@property (weak, nonatomic) IBOutlet UIButton *tbnSubmit;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    [_tfUsername addTarget:self action:@selector(checkCanSubmit) forControlEvents:UIControlEventEditingChanged];
    [_tfPwd addTarget:self action:@selector(checkCanSubmit) forControlEvents:UIControlEventEditingChanged];
    
    [self.tbnSubmit addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self checkCanSubmit];
    
}

- (void)checkCanSubmit{
    if(self.tfUsername.text.length > 0 && self.tfPwd.text.length > 0){
        self.tbnSubmit.enabled = true;
    }else{
        self.tbnSubmit.enabled = false;
    }
}

- (void)login{
    

    if([self.tfUsername.text isEqualToString:@"q"] && [self.tfPwd.text isEqualToString:@"1"]){
          [self performSegueWithIdentifier:@"loginSuccess" sender:nil];
      }else{
          [SVProgressHUD showErrorWithStatus:@"用户名或者密码错误"];
      }
    
    
//    [SVProgressHUD show];
//    self.tbnSubmit.enabled = false;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [SVProgressHUD dismiss];
//        self.tbnSubmit.enabled = true;
//        if([self.tfUsername.text isEqualToString:@"q"] && [self.tfPwd.text isEqualToString:@"1"]){
//              [self performSegueWithIdentifier:@"loginSuccess" sender:nil];
//          }else{
//              [SVProgressHUD showErrorWithStatus:@"用户名或者密码错误"];
//          }
//    });
}


/// Segue当调用：[self performSegueWithIdentifier:@"loginSuccess" sender:nil]的时候，就会回调这个方法，通过这个返回的segue可以拿到目前controller和目标controller
/// @param segue <#segue description#>
/// @param sender <#sender description#>
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //源vc，就是当前的vc
//    LoginVC *logcinVc = segue.sourceViewController;
    
    //目标vc
    ContactVC *contactVc =  segue.destinationViewController;
    contactVc.userName = self.tfUsername.text;
}

@end
