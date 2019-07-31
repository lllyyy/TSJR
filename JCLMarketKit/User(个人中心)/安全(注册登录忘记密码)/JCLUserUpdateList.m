//
//  JCLUserUpdateList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserUpdateList.h"
#import "JCLUserSubmit.h"
#import "JCLTableInfoCell.h"
#import "JCLUserForgetList.h"

@interface JCLUserUpdateList ()
@end

@implementation JCLUserUpdateList
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.middle.title = @"账户与安全";
    self.titles = @[@"", @"原密码", @"", @"新密码", @"确认新密码"];
    self.texts = @[@"", @"请输入原密码", @"", @"6-20位组合密码", @"重复输入6-20位组合密码"];
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.vals addObject:@""];
    }];
    JCLUserSubmit *footer = [[JCLUserSubmit alloc]init];
    footer.submit.title = @"确认修改";
    [footer.submit tapActionBlock:^{
        [self.view endEditing:YES];
        if (![self.vals[1] length]) { [JCLFramework JCLProgressHUD:@"请输入手机号"]; return; }
        if (![self.vals[3] length]) { [JCLFramework JCLProgressHUD:@"请输入验证码"]; return; }
        if (![self.vals[4] length]) { [JCLFramework JCLProgressHUD:@"请输入密码"]; return; }
        if (![self.vals[5] length]) { [JCLFramework JCLProgressHUD:@"请重复输入密码"]; return; }
        if (![self.vals[5] isEqualToString:self.vals[4]]) { [JCLFramework JCLProgressHUD:@"密码输入错误"]; return; }
    }];
    footer.height = 0.134*JCLHEIGHT;
    self.table.tableFooterView = footer;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.titles.count; }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) { return 18; }
    if (indexPath.row == 2) { return 0.06*JCLHEIGHT; }
    return 0.074*JCLHEIGHT;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLTableInfoCell *cell = [JCLTableInfoCell cellWithTable:tableView];
    NSString *val = self.titles[indexPath.row];
    cell.text.placeholder = self.texts[indexPath.row];
    cell.text.text = self.vals[indexPath.row];
    cell.valActionBlock = ^(NSString *val){
        [self.vals replaceObjectAtIndex:indexPath.row withObject:val];
    };
    cell.title.text = val;
    
    if (indexPath.row == 0 || indexPath.row == 2) { cell.bg.backgroundColor = [UIColor clearColor]; [cell.text setEnabled:NO]; }
    if (indexPath.row == 2) {
        cell.text.text = @"忘记登录密码"; cell.text.textColor = JCL_SelText_COL; cell.text.textAlignment = 2;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 2) return;
    JCLUserForgetList *list = [[JCLUserForgetList alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}
@end
