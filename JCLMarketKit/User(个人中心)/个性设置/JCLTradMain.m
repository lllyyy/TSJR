//
//  JCLSetupMain.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/10/11.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradMain.h"
#import "JCLTradeRiskInfo.h"
#import "JCLBaseMenu.h"
#import "JCLTradCancelList.h"
#import "JCLTradPositList.h"
#import "JCLTradSelectList.h"

@interface JCLTradMain ()
@property (nonatomic, weak) JCLTradeRiskInfo *risk;
@property (nonatomic, weak) JCLTradPositList *buy;
@property (nonatomic, weak) JCLTradPositList *sell;
@property (nonatomic, weak) JCLTradPositList *posit;
@property (nonatomic, weak) JCLTradCancelList *cancel;
@property (nonatomic, weak) JCLTradSelectList *select;
@end

@implementation JCLTradMain
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.middle.title = @"个性设置";
    CGFloat y = 8, h = [JCLKitObj JCLHeight:34];
    self.header.frame = CGRectMake(0, 64, JCLWIDTH, h);
    self.header.arr = @[@"买入", @"卖出", @"撤单", @"持仓", @"查询"];
    self.scroll.frame = CGRectMake(0, self.header.maxY+y, JCLWIDTH, JCLSCROLL);
    self.scroll.contentSize = CGSizeMake(self.scroll.width * self.header.arr.count, 0);
    
    JCLTradPositList *buy = [[JCLTradPositList alloc]init];
    buy.isBuySell = YES;
    buy.isBuy = YES;
    buy.listH = JCLHEIGHT - self.header.maxY;
    [self.scroll addSubview:buy.view];
    buy.view.frame = CGRectMake(0, 0, JCLWIDTH, buy.listH);
    self.buy = buy;
    
    JCLTradPositList *sell = [[JCLTradPositList alloc]init];
    sell.isBuySell = YES;
    sell.listH = JCLHEIGHT - self.header.maxY;
    [self.scroll addSubview:sell.view];
    sell.view.frame = CGRectMake(JCLWIDTH, 0, JCLWIDTH, sell.listH);
    self.sell = sell;
    
    self.listH = JCLHEIGHT;
    [self InitTableList:[[JCLTradCancelList alloc]init] idx:2];
    [self InitTableList:[[JCLTradPositList alloc]init] idx:3];
    [self InitTableList:[[JCLTradSelectList alloc]init] idx:4];
}
@end

