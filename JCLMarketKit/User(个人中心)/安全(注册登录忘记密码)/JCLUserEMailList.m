//
//  JCLUserEMailList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/28.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserEMailList.h"
#import "JCLUserSubmit.h"
#import "JCLTableInfoCell.h"
#import "JCLUserInputList.h"
#import "TSJRSwitchAccountVC.h"
@interface JCLUserEMailList ()

@end

@implementation JCLUserEMailList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.middle.title = @"账号与安全";
    self.titles = @[ @"手机号",@"邮箱号",@"修改密码",@"切换交易账户"];
    [self.vals addObjectsFromArray:@[@"", @"", name()]];

//    JCLUserSubmit *footer = [[JCLUserSubmit alloc]init];
//    footer.submit.title = @"完成";
//    [footer.submit tapActionBlock:^{
//        [self.view endEditing:YES];
//        if (![self.vals[0] length]) { [JCLFramework JCLProgressHUD:@"请输入邮箱"]; return; }
//        if (![self.vals[1] length]) { [JCLFramework JCLProgressHUD:@"请输入修改登录密码"]; return; }
////        NSString *val = self.img.length ? self.img : self.vals[0];
////        NSString *url = [NSString stringWithFormat:@"%@setPersonal?phone=%@&truename=%@&profile=%@&avatar=%@", JCLWebURL,
////                         [JCLUserData getUserInfo].username, self.vals[1], self.vals[2], val];
////        [JCLHttpsObj JCLGetJson:url success:^(id obj) {
////            if([obj[@"code"] isEqualToNumber:@(0)]){
////                NSString *name = [JCLUserData getUserInfo].username, *word = [JCLUserData getUserInfo].password;
////                JCLUserData *data = [JCLUserData mj_objectWithKeyValues:obj[@"userInfo"]];
////                data.username = name; data.password = word;
////                [JCLUserData saveUserInfo:data];
////            }
////            [JCLFramework JCLProgressHUD:obj[@"message"]];
////        } failure:^(NSError *error) { [JCLFramework JCLProgressHUD:@"网络超时"]; }];
//    }];
//    footer.height = 0.16*JCLHEIGHT;
//    self.table.tableFooterView = footer;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.titles.count; }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 0.072*JCLHEIGHT;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLTableInfoCell *cell = [JCLTableInfoCell cellWithTable:tableView];
    NSString *val = self.titles[indexPath.row];
    cell.title.text = val;
    // cell.text.placeholder = self.texts[indexPath.row];
   // cell.text.text = self.vals[indexPath.row];
   
    if (indexPath.row == 0) {
         cell.unit.text= [NSString stringWithFormat:@"%@****%@",[user().uPhone substringToIndex:3],[user().uPhone substringFromIndex:user().uPhone.length - 4] ];;
        cell.unit.textColor = [UIColor whiteColor];
    }else if (indexPath.row == 1){
        cell.unit.text= [NSString stringWithFormat:@"%@",user().email];
        cell.unit.textColor = [UIColor whiteColor];
    }
     
    cell.valActionBlock = ^(NSString *val){
        [self.vals replaceObjectAtIndex:indexPath.row withObject:val];
    };
    cell.isRight = YES;
    
    [cell.text setEnabled:NO];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *val = self.titles[indexPath.row];
    if ([val isEqualToString:@"切换交易账户"]) {
//        JCLUserInputList *list = [[JCLUserInputList alloc]init];
//        list.name = val;
//        list.popActionBlock = ^(NSString *val){
//            [self.vals replaceObjectAtIndex:indexPath.row withObject:val];
//            [self.table reloadData];
//        };
        TSJRSwitchAccountVC *vc = [[TSJRSwitchAccountVC alloc]init];
       [self.navigationController pushViewController:vc animated:YES];
    } else {
        JCLUserInputList *list = [[JCLUserInputList alloc]init];
        list.name = val;
        list.popActionBlock = ^(NSString *val){
            [self.vals replaceObjectAtIndex:indexPath.row withObject:val];
            [self.table reloadData];
        };
        [self.navigationController pushViewController:list animated:YES];
    }
}
@end
