//
//  JCLSetupMain.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/10/11.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradMain.h"
#import "JCLTradMainHeader.h"
#import "JCLTradBuySell.h"
#import "JCLBaseMenu.h"
#import "JCLTradPositList.h"
#import "JCLTradEntrustList.h"

#import "JCLTradList.h"
#import "JCLTradMain.h"
#import "JCLTradDealList.h"

@interface JCLTradMain ()
@property (nonatomic, weak) JCLTradMainHeader *header;
@end

@implementation JCLTradMain
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navi.middle.title = @"交易";
    
    CGFloat y = 0;
    if (self.isMain) {
        JCLTradBuySell *trad = [[JCLTradBuySell alloc]init]; [self.view addSubview:trad];
        trad.frame = CGRectMake(0, JCLNAVI, JCLWIDTH, 0.44*JCLHEIGHT);
        trad.money.text = [NSString stringWithFormat:@"订单金额: %@", @"--"];
        trad.remain.text = [NSString stringWithFormat:@"购买力: %@", @"--"];
        trad.buyVol.text = [NSString stringWithFormat:@"现金可买: %@", @"--"];
        trad.sellVol.text = [NSString stringWithFormat:@"持仓可卖: %@", @"--"];
        y = trad.maxY;
    } else {
        self.navi.left.img = @"";
        JCLTradMainHeader *header = [[JCLTradMainHeader alloc]init];
        [self.view addSubview:header];
        header.frame = CGRectMake(0, JCLNAVI, JCLWIDTH, 0.46*JCLHEIGHT);
        header.assets.text = [NSString stringWithFormat:@"资产净值(人民币)\n %@", @"--"];
        NSMutableAttributedString *assets = [[NSMutableAttributedString alloc]initWithString:header.assets.text];
        [assets addAttribute:NSForegroundColorAttributeName
                       value:JCLRISERGB
                       range:NSMakeRange(10, header.assets.text.length-10)];
        [assets addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:[JCLKitObj JCLSize:16]]
                       range:NSMakeRange(10, header.assets.text.length-10)];
        header.assets.attributedText = assets;
        
        header.marketVal.text = [NSString stringWithFormat:@"证券市值\n %@", @"--"];
        header.cash.text = [NSString stringWithFormat:@"现金\n %@", @"--"];
        header.arrears.text = [NSString stringWithFormat:@"欠款金额\n %@", @"--"];
        header.frozen.text = [NSString stringWithFormat:@"冻结资金\n %@", @"--"];
        header.draw.text = [NSString stringWithFormat:@"可提金额\n %@", @"--"];
        
        header.bar.idx = 44;
        header.bar.icons = @[@"交易", @"交易历史"];
        header.bar.hisIcons = @[@"交易", @"交易历史"];
        header.bar.vals = @[@"交易", @"交易历史"];
        header.bar.actionBlock = ^(NSInteger idx){
            switch (idx) {
                case 0:{
                    JCLTradMain *list = [[JCLTradMain alloc]init];
                    list.isMain = YES;
                    [self.navigationController pushViewController:list animated:YES];
                } break;
                case 1: {
                    JCLTradDealList *list = [[JCLTradDealList alloc]init];
                    list.isHis = YES;
                    [self.navigationController pushViewController:list animated:YES];
                } break;
                default: break;
            }
        };
        y = header.maxY;
    }
    CGFloat h = [JCLKitObj JCLHeight:44];
    self.menu.frame = CGRectMake(0, y, JCLWIDTH, h);
    self.menu.isLine = YES;
    self.menu.arr = @[@"持仓", @"今日订单"];
    self.scroll.frame = CGRectMake(0, self.menu.maxY, JCLWIDTH, JCLSCROLL);
    self.scroll.contentSize = CGSizeMake(self.scroll.width * self.menu.arr.count, 0);
    [self.scroll setDelaysContentTouches:NO];
    [self.scroll setCanCancelContentTouches:NO];
    self.listH = JCLHEIGHT;
    [self InitTableList:[[JCLTradPositList alloc]init] idx:0];
    
    JCLTradEntrustList *deal = [[JCLTradEntrustList alloc]init];
    deal.listH = self.listH-self.menu.maxY;
    deal.view.frame = CGRectMake(JCLWIDTH, 0, JCLWIDTH, deal.listH);
    [self.scroll addSubview:deal.view];
}
@end

