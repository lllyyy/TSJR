//
//  JCLTradSelectList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/14.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradSelectList.h"
#import "JCLTradSelectCell.h"
#import "JCLTradeRecordViewController.h"
#import "JCLSocketObj.h"
@interface JCLTradSelectList ()
@end

@implementation JCLTradSelectList
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.hidden = YES;
    self.table.y = 0, self.table.height = self.listH;
    [self.vals addObjectsFromArray:@[@"当日成交", @"历史成交"]];


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.vals.count; }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return [JCLKitObj JCLHeight:44]; }
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    JCLTradSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLTradSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.text.text = self.vals[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBar.selectedViewController;
    JCLTradeRecordViewController *record = [[JCLTradeRecordViewController alloc]init];
    record.kind = indexPath.row==0?TradeToday:TradeHistory;
    [nav pushViewController:record animated:YES];
    
}
@end
