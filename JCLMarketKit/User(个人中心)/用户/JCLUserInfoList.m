//
//  JCLUserList.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/6.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserInfoList.h"
#import "JCLTableInfoCell.h"
#import "JCLUserInputList.h"
#import "JCLUserSubmit.h"

@interface JCLUserInfoList ()
@end

@implementation JCLUserInfoList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.middle.title = @"个人资料";
  
    self.titles = @[@"头像", @"昵称", @"简介"];
    [self.vals addObjectsFromArray:@[avatar(), name(),  intro()]];

//    JCLUserSubmit *footer = [[JCLUserSubmit alloc]init];
//    footer.submit.title = @"完成";
//    [footer.submit tapActionBlock:^{
//        [self.view endEditing:YES];
//        NSString *val = self.img.length ? self.img : self.vals[0];
//        if (!val.length) { [JCLFramework JCLProgressHUD:@"请选择图片"]; return; }
//        if (![self.vals[1] length]) { [JCLFramework JCLProgressHUD:@"请输入昵称"]; return; }
//        if (![self.vals[2] length]) { [JCLFramework JCLProgressHUD:@"请输入简介"]; return; }
//        NSString *url = [NSString stringWithFormat:@"%@setPersonal?phone=%@&truename=%@&profile=%@&avatar=%@", JCLWebURL,
//                         [JCLUserData getUserInfo].username,
//                         [self.vals[1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                         [self.vals[2] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
//                         val];
//        [JCLHttpsObj JCLGetJson:url success:^(id obj) {
//            if([obj[@"code"] isEqualToString:@"0"]){
//                NSString *username = [JCLUserData getUserInfo].username;
//                NSString *password = [JCLUserData getUserInfo].password;
//                NSString *online = [JCLUserData getUserInfo].online;
//                JCLUserData *data = [JCLUserData mj_objectWithKeyValues:obj[@"content"]];
//                data.username = username;
//                data.password = password;
//                data.online = online;
//                [JCLUserData saveUserInfo:data];
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//            [JCLFramework showSuccess:obj[@"message"]];
//        } failure:^(NSError *error) { [JCLFramework showErrorHud:@"网络超时"]; }];
//    }];
//    footer.height = 0.16*JCLHEIGHT;
//    self.table.tableFooterView = footer;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.titles.count; }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *val = self.titles[indexPath.row];
    if ([val isEqualToString:@"头像"]){
        return 0.072*JCLHEIGHT+0.009*JCLHEIGHT + 20;
    } else {
        return 0.072*JCLHEIGHT;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLTableInfoCell *cell = [JCLTableInfoCell cellWithTable:tableView];
    NSString *val = self.titles[indexPath.row];
    cell.title.text = val;

    cell.text.text = self.vals[indexPath.row];
    cell.valActionBlock = ^(NSString *val){
        [self.vals replaceObjectAtIndex:indexPath.row withObject:val];
    };
    cell.isRight = YES;
    
    if ([val isEqualToString:@"头像"]) {
        cell.isPhone = YES;
        if (self.phone) {
            cell.phone.image = self.phone;
        } else {
            [JCLFramework JCLWebImage:cell.phone icon:avatar()];
        }
    }
    [cell.text setEnabled:NO];
    if (indexPath.row == 0) {
        cell.lineH = 0.009*JCLHEIGHT;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *val = self.titles[indexPath.row];
    if ([val isEqualToString:@"头像"]){ [self showPhoneAction]; }
    else if ([val isEqualToString:@"简介"]) {
        JCLUserInputList *list = [[JCLUserInputList alloc]init];
        list.name = val;
        list.isMore = YES;
        list.text = self.vals[indexPath.row];
        list.popActionBlock = ^(NSString *val){
            [self.vals replaceObjectAtIndex:indexPath.row withObject:val];
            [self.table reloadData];
        };
        [self.navigationController pushViewController:list animated:YES];
    } else {
        JCLUserInputList *list = [[JCLUserInputList alloc]init];
        list.name = val;
        list.text = self.vals[indexPath.row];
        list.popActionBlock = ^(NSString *val){
            [self.vals replaceObjectAtIndex:indexPath.row withObject:val];
            [self.table reloadData];
        };
        [self.navigationController pushViewController:list animated:YES];
    }
}
@end
