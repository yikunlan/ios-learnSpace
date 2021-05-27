//
//  ContactVC.m
//  tongxunlu
//
//  Created by  huangyikun on 2020/5/27.
//  Copyright © 2020  huangyikun. All rights reserved.
//

#import "ContactVC.h"
#import "AddContactVC.h"
#import "EditContactVc.h"

@interface ContactVC ()<UIActionSheetDelegate,AddContactDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //修改navigation的左边的按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logOut) ];
    self.navigationItem.leftBarButtonItem = item;
    self.title = [NSString stringWithFormat:@"%@的通讯录",self.userName];
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)logOut{
    
    NSLog(@"注销");
        
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要注销吗" message:@"massage2222" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了Cancel");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"随意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了OK");
        }];
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"注消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                //回到上一个界面
                [self.navigationController popViewControllerAnimated:true];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [alertController addAction: destructiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//不管是手动的还是自动的segue都会调用

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *vc = segue.destinationViewController;
    if([vc isKindOfClass: [AddContactVC class]]){
        AddContactVC *add = (AddContactVC *)vc;
        add.delegate = self;
    }else if([vc isKindOfClass:[EditContactVc class]]){
        EditContactVc *edit = (EditContactVc *)vc;
        edit.model = _dataArray[self.tableView.indexPathForSelectedRow.row];
        edit.test222 = ^(ContactModel * _Nonnull model) {
            [self.tableView reloadData];
        };
        [edit editModel:^(ContactModel * model) {
            [self.tableView reloadData];
        }];
    }
}

- (void)addFinish:(ContactModel *)model{
    [self.dataArray addObject:model];
    [self.tableView reloadData];
}

#pragma --mark dataResource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        NSLog(@"cell为空dfdfdf");
    }
//    if(cell){
//        cell = [[UITableViewCell alloc] init];
//    }
    cell.textLabel.text = [self.dataArray[indexPath.row] name];
    cell.detailTextLabel.text = [self.dataArray[indexPath.row] number];
    
    return cell;
}


@end
