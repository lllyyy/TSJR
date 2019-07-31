//
//  JCLUserAboutList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserAboutList.h"
#import "JCLUserAboutHeader.h"
#import "JCLTableInfoCell.h"
#import "JCLWapList.h"

@interface JCLUserAboutList ()

@end

@implementation JCLUserAboutList
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.middle.title = @"关于";
    
    JCLUserAboutHeader *header = [[JCLUserAboutHeader alloc]init];
    header.icon.image = [UIImage imageNamed:@"AppIcon"];
    header.title.text = @"天使金融";
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    header.number.text = [NSString stringWithFormat:@"版本信息: %@", dic[@"CFBundleShortVersionString"]];
    header.height = 0.36*JCLSCROLL;
    self.table.tableHeaderView = header;
    self.titles = @[@"协议及说明", @"检测新版本"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.titles.count; }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return 0.072*JCLHEIGHT; }
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLTableInfoCell *cell = [JCLTableInfoCell cellWithTable:tableView];
    NSString *val = self.titles[indexPath.row];
    cell.title.text = val;
    [cell.text setEnabled:NO];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *val = self.titles[indexPath.row];
    if ([val isEqualToString:@"协议及说明"]) {
        NSString *url = [NSString stringWithFormat:@"%@pageJump?type=2", JCLWebURL];
        [JCLHttpsObj JCLGetJson:url success:^(id obj) {
            if ([obj[@"code"] isEqualToString:@"0"]) {
                UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                UINavigationController *nav = (UINavigationController *)tabBar.selectedViewController;
                JCLWapList *list = [[JCLWapList alloc]init];
                list.name = val;
                list.url = obj[@"httpUrl"];
                [nav pushViewController:list animated:YES];
            } else {
                [JCLFramework JCLProgressHUD:obj[@"message"]];
            }
        } failure:^(NSError *error) { [JCLFramework JCLProgressHUD:@"网络错误请联系管理员"]; }];
    } else {
        [JCLFramework JCLProgressHUD:@"请静等上线"];
    }
}

@end
