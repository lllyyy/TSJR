//
//  JCLUserList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/16.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserList.h"
#import "JCLUserHeader.h"
#import "JCLTableInfoCell.h"
#import "JCLUserInfoList.h"
#import "JCLUserSetupList.h"
#import "JCLUserInputList.h"
#import "JCLWapList.h"
#import "JCLUserEMailList.h"
#import "MQChatViewManager.h"
#import <MeiQiaSDK/MQManager.h>
#import <MeiQiaSDK/MeiqiaSDK.h>
#import <UMShare/UMShare.h>
#import "JCLAccountOverviewVC.h"
 


@interface JCLUserList ()
@property (nonatomic, weak) JCLUserHeader *header;

@property (nonatomic, strong) NSArray *icons;
@end

@implementation JCLUserList

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSLog(@"avataravatar %@",avatar());
    
    NSLog(@"name() %@",name());
    [JCLFramework JCLWebImage:self.header.icon icon:[JCLUserSession getAvatar].length > 0?[NSString stringWithFormat:@"%@/%@",avatarURL,[JCLUserSession getAvatar]]:avatar()];
    self.header.name.text = [JCLUserSession getname].length > 0 ? [JCLUserSession getname]:name();
    self.header.text.text = [JCLUserSession getintro].length>0  ? [JCLUserSession getintro]:intro();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.middle.title = @"我的";
    self.navi.left.img = @"";
    self.navi.right.img = @"设置";
  
    __weak typeof(self)weakSelf = self;
    self.rightActionBlock = ^(){
        if (name().length == 0){
            JCLLOGIN;
            return;
            
        };
       [weakSelf.navigationController pushViewController:[[JCLUserSetupList alloc]init] animated:YES];
    };
    JCLUserHeader *header = [[JCLUserHeader alloc]init];
    header.height = 0.12*JCLHEIGHT;
    self.header = header;
    [header tapActionBlock:^{
        if (name().length == 0){
            JCLLOGIN;
            return;
         };
        [self.navigationController pushViewController:[[JCLUserInfoList alloc]init] animated:YES];
    }];
    
    self.table.tableHeaderView = header;
    
    self.icons = @[@"我的账户", @"帮助中心", @"意见反馈", @"联系客服",@"ic_Workbench_16",@"home_share"];
    self.texts = @[@"资金账户", @"帮助中心", @"意见反馈", @"联系客服",@"线上咨询",@"分享APP"];
   
    
    [self.texts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.vals addObject:@""];
    }];
    
       
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.texts.count; }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 0.072*JCLHEIGHT +0.009*JCLHEIGHT;
    } else {
        return 0.072*JCLHEIGHT;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLTableInfoCell *cell = [JCLTableInfoCell cellWithTable:tableView];
    NSString *val = self.texts[indexPath.row];
    cell.code.img = self.icons[indexPath.row];
    if (indexPath.row == 0) {
        cell.lineH = 0.009*JCLHEIGHT;
    }
    cell.code.title = val;
    cell.text.enabled = NO;
    cell.code.contentHorizontalAlignment = 1;
    cell.code.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10);
    cell.code.frame = CGRectMake(14, 0, JCLWIDTH, 0.074*JCLHEIGHT-1);
    [cell.code tapActionBlock:^{
        switch (indexPath.row) {
            case 0: {
                if (name().length == 0){
                    JCLLOGIN; return;
                };
                
                [self.navigationController pushViewController:[[JCLAccountOverviewVC alloc]init] animated:YES];
                break;
            } case 1: {
                NSString *url = [NSString stringWithFormat:@"%@pageJump?type=1", JCLWebURL];
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
                } failure:^(NSError *error) {
                    [JCLFramework JCLProgressHUD:@"网络错误请联系管理员"];
                }];
            } break;
            case 2: {
                if (name().length == 0){
                    JCLLOGIN;
                    return;
                };
                JCLUserInputList *list = [[JCLUserInputList alloc]init];
                list.name = val;
                list.text = self.texts[indexPath.row];
                list.isMore = YES;
                list.popActionBlock = ^(NSString *val){
                    [self.vals replaceObjectAtIndex:indexPath.row withObject:val];
                    [self.table reloadData];
                };
                [self.navigationController pushViewController:list animated:YES];
            }
                break;
            case 3:{
                               UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"您是否要联系客服." preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", @"400-855-8896"]]];
                                 }];
                                UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { }];
                                [alert addAction:ac1]; [alert addAction:ac2];
                                 [self presentViewController:alert animated:YES completion:nil];
            }
                break;
            case 4:{
               MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
               MQChatViewStyle *aStyle = [chatViewManager chatViewStyle];
               [aStyle setEnableRoundAvatar:YES];
               [aStyle setEnableOutgoingAvatar:YES]; //不显示用户头像
               [aStyle setEnableIncomingAvatar:YES]; //不显示客服头像
 
               [chatViewManager setClientInfo:@{@"name":name(),@"avatar":avatar()} override:YES];
               [chatViewManager pushMQChatViewControllerInViewController:self];
                
  
            } break;
            case 5:{
        
                NSString *desc = @"天使金融 美股开户，看行情，做交易，更便捷。";
                [JCLKitObj configUSharePlatforms:[NSString stringWithFormat:@"%@" ,@"http://www.angl999.com/tsgjweb/download"] vc:self title:@"我正在使用“天使金融APP”" desc:desc];
              
            } break;
            default:  break;
        }
    }];
    return cell;
}






@end
