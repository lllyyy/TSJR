//
//  JCLTransactionVC.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/23.
//  Copyright © 2017年 刘虎超. All rights reserved.
// 交易控制器

#import "JCLTradList.h"
#import "JCLTradeRiskInfo.h"
#import "JCLBaseMenu.h"
#import "JCLTradCancelList.h"
#import "JCLTradPositList.h"
#import "JCLTradSelectList.h"

@interface JCLTradList ()
@property (nonatomic, weak) JCLTradeRiskInfo *risk;
@property (nonatomic, weak) JCLTradPositList *buy;
@property (nonatomic, weak) JCLTradPositList *sell;
@property (nonatomic, weak) JCLTradPositList *posit;
@property (nonatomic, weak) JCLTradCancelList *cancel;
@property (nonatomic, weak) JCLTradSelectList *select;
@end

@implementation JCLTradList
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.middle.title=@"交易";
    
    JCLTradeRiskInfo *risk = [[JCLTradeRiskInfo alloc]init]; [self.view addSubview:risk];
    risk.frame = CGRectMake(0, JCLNAVI, JCLWIDTH, 0.24*JCLHEIGHT);
    risk.title.text = @"风控信息(折合人民币)";
    risk.zzc.text = [NSString stringWithFormat:@"总资产: %@", @"--"];
    NSMutableAttributedString *zzc = [[NSMutableAttributedString alloc]initWithString:risk.zzc.text];
    [zzc addAttribute:NSForegroundColorAttributeName
                value:JCLRISERGB
                range:NSMakeRange(5, risk.zzc.text.length-5)];
    [zzc addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:[JCLKitObj JCLSize:16]]
                range:NSMakeRange(5, risk.zzc.text.length-5)];
    risk.zzc.attributedText = zzc;
    
    risk.pcx.text = [NSString stringWithFormat:@"平仓线: %@", @"--"];
    risk.yjx.text = [NSString stringWithFormat:@"预警线: %@", @"--"];
    
    risk.yk.text = [NSString stringWithFormat:@"盈亏浮动: %@", @"--"];
    NSMutableAttributedString *yk = [[NSMutableAttributedString alloc]initWithString:risk.yk.text];
    [yk addAttribute:NSForegroundColorAttributeName
               value:JCLRISERGB
               range:NSMakeRange(6, risk.yk.text.length-6)];
    [yk addAttribute:NSFontAttributeName
               value:[UIFont systemFontOfSize:[JCLKitObj JCLSize:16]]
               range:NSMakeRange(6, risk.yk.text.length-6)];
    risk.yk.attributedText = yk;
    
    risk.ye.text = [NSString stringWithFormat:@"%@\n资金余额", @"--"];
    NSMutableAttributedString *ye = [[NSMutableAttributedString alloc]initWithString:risk.ye.text];
    [ye addAttribute:NSForegroundColorAttributeName
               value:JCL_Text_COL
               range:NSMakeRange(0, risk.ye.text.length-5)];
    risk.ye.attributedText = ye;
    
    risk.ky.text = [NSString stringWithFormat:@"%@\n可用资金", @"--"];
    NSMutableAttributedString *ky = [[NSMutableAttributedString alloc]initWithString:risk.ky.text];
    [ky addAttribute:NSForegroundColorAttributeName
               value:JCL_Text_COL
               range:NSMakeRange(0, risk.ky.text.length-5)];
    risk.ky.attributedText = ky;
    
    risk.sz.text = [NSString stringWithFormat:@"%@\n证券市值", @"--"];
    NSMutableAttributedString *sz = [[NSMutableAttributedString alloc]initWithString:risk.sz.text];
    [sz addAttribute:NSForegroundColorAttributeName
               value:JCL_Text_COL
               range:NSMakeRange(0, risk.sz.text.length-5)];
    risk.sz.attributedText = sz;
    self.risk = risk;

    [self InitList];
}

-(void)InitList{
    JCLBaseMenu *menu = [[JCLBaseMenu alloc]init]; [self.view addSubview:menu];
    menu.frame = CGRectMake(0, self.risk.maxY, JCLWIDTH, [JCLKitObj JCLHeight:40]);
    menu.style = MenuStyleBGLine; menu.backgroundColor = JCL_Cell_COL; menu.isAction = YES;
    menu.arr = @[@"买入", @"卖出", @"撤单", @"持仓", @"查询"];
    menu.tapActionBlock = ^(NSInteger idx){
        [self.view endEditing:YES];
        self.buy.view.hidden=YES; self.sell.view.hidden=YES; self.posit.view.hidden=YES; self.cancel.view.hidden=YES; self.select.view.hidden=YES;
        switch (idx) {
            case 0: self.buy.view.hidden = NO; break;
            case 1: self.sell.view.hidden = NO; break;
            case 2: self.cancel.view.hidden = NO; break;
            case 3: self.posit.view.hidden = NO; break;
            case 4: self.select.view.hidden = NO; break;
        }
    };
    
    JCLTradPositList *buy = [[JCLTradPositList alloc]init];
    buy.isBuySell = YES;
    buy.isBuy = YES;
    buy.listH = JCLHEIGHT - menu.maxY;
    [self.view addSubview:buy.view];
    buy.view.frame = CGRectMake(0, menu.maxY, JCLWIDTH, buy.listH);
    self.buy = buy;
    
    JCLTradPositList *sell = [[JCLTradPositList alloc]init];
    sell.isBuySell = YES;
    sell.listH = JCLHEIGHT - menu.maxY;
    [self.view addSubview:sell.view];
    sell.view.frame = CGRectMake(0, menu.maxY, JCLWIDTH, sell.listH);
    self.sell = sell;
    
    JCLTradCancelList *cancel = [[JCLTradCancelList alloc]init];
    cancel.listH = JCLHEIGHT - menu.maxY;
    [self.view addSubview:cancel.view];
    cancel.view.frame = CGRectMake(0, menu.maxY, JCLWIDTH, cancel.listH);
    self.cancel = cancel;
    
    JCLTradPositList *posit = [[JCLTradPositList alloc]init];
    posit.listH = JCLHEIGHT - menu.maxY;
    [self.view addSubview:posit.view];
    posit.view.frame = CGRectMake(0, menu.maxY, JCLWIDTH, posit.listH);
    self.posit = posit;
    
    JCLTradSelectList *select = [[JCLTradSelectList alloc]init];
    select.listH = JCLHEIGHT - menu.maxY;
    select.view.frame=CGRectMake(0, menu.maxY, JCLWIDTH, select.listH);
    [self.view addSubview:select.view];
    self.select = select;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate.shareAppDelegate.timerAtionBlock = ^(NSTimer *timer) {
        
    };
}
@end
