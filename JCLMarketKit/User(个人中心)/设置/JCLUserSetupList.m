//
//  JCLUserSetupList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserSetupList.h"
#import "JCLTableInfoCell.h"
#import "JCLUserSetupFooter.h"
#import "JCLUserAboutList.h"
#import "JCLUserEMailList.h"

@implementation JCLUserSetupList
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navi.middle.title = @"设置";

    self.titles = @[@"账户与安全", @"关于"];
    JCLUserSetupFooter *footer = [[JCLUserSetupFooter alloc]init];
    footer.signOut.title = @"安全退出";
    [footer.signOut tapActionBlock:^{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"您是否要退出账号."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  NSFileManager *manager = [NSFileManager defaultManager];
                                                                  [manager removeItemAtPath:CachesFile(JCLUser) error:NULL];
                                                                  [JCLUserSession removeUser];
                                                                  
                                                                  NSLog(@"name  %@",name());
                                                                  
                                                                  
                                                                  JCLUserLoginList *list = [[JCLUserLoginList alloc] init];
                                                                  [self.navigationController pushViewController:list animated:YES];
                                                              }];
        UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                              }];
        [alert addAction:ac1]; [alert addAction:ac2];
        [self presentViewController:alert animated:YES completion:nil];
    }];

    footer.height = 0.072*JCLHEIGHT;
    self.table.tableFooterView = footer;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.titles.count; }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return 0.072*JCLHEIGHT+0.009*JCLHEIGHT;
    } else {
        return 0.072*JCLHEIGHT;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLTableInfoCell *cell = [JCLTableInfoCell cellWithTable:tableView];
    NSString *val = self.titles[indexPath.row];
    cell.title.text = val;
    [cell.text setEnabled:NO];
    if (indexPath.row == 1) {
        cell.lineH = 0.009*JCLHEIGHT;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *val = self.titles[indexPath.row];
    if ([val isEqualToString:@"账户与安全"]) {
        JCLUserEMailList *list = [[JCLUserEMailList alloc]init];
        [self.navigationController pushViewController:list animated:YES];
    } else {
        JCLUserAboutList *list = [[JCLUserAboutList alloc]init];
        [self.navigationController pushViewController:list animated:YES];
    }
}
@end
