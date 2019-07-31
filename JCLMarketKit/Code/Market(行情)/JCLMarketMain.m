//
//  JCLMarketMain.m
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/3/27.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketMain.h"
#import "JCLBaseMenu.h"
#import "JCLMarketList.h"

#import "JCLStockMain.h"
#import "JCLMarketSearchList.h"
#import "JCLMarketInfoList.h"

@interface JCLMarketMain ()
@property (nonatomic, weak) JCLBaseMenu *menu;
@property (nonatomic, weak) JCLMarketList *quotes;
@property (nonatomic, assign) BOOL isMarket;
//消息未读接口
@property (nonatomic,strong) UILabel *msgNumLab;
@end

@implementation JCLMarketMain
-(void)viewDidLoad { [super viewDidLoad]; [self setupNavi]; }

#pragma mark 1.setupNavi
-(void)setupNavi{
    self.navi.middle.title = @"行情";
    self.navi.left.img = @"";
    self.navi.right.img = @"搜索";
    [self.navi.right tapActionBlock:^{
        [self.navigationController pushViewController:[[JCLMarketSearchList alloc]init] animated:YES];
    }];
 
    [self.table removeFromSuperview];
    __weak typeof(self) weakSelf = self;
    self.rightActionBlock = ^(){ [weakSelf.navigationController pushViewController:[[JCLMarketSearchList alloc] init] animated:YES]; };

    [self InitMenu];
    
 

}

#pragma mark 2.InitMenu
-(void)InitMenu{
    //没有意义的view
    JCLBaseMenu *menu = [[JCLBaseMenu alloc]initWithFrame:CGRectMake(0, JCLNAVI, JCLWIDTH, 0)];
    [self.view addSubview:menu];
   // menu.style = MenuStyleBGLine;
 
    menu.isAction = YES;
    menu.arr = @[@""];
    menu.tapActionBlock = ^(NSInteger idx){
        switch (idx) {
            case 0:
                self.isMarket = YES;
                self.quotes = [self InitMarketList:MarketQuotesList]; break;
           
            default: break;
        }
    };
    self.menu = menu;
    
}

//行情列表
#pragma mark 3.InitMarketList
-(JCLMarketList *)InitMarketList:(JCLMarketListStyle)style{
    [self.quotes.view removeFromSuperview];
    //行情列表
    JCLMarketList *list = [[JCLMarketList alloc]init];
    list.style = style;
    list.listH = JCLHEIGHT - JCLTABHEIGHT - self.menu.maxY;
    list.idxActionBlock = ^(NSArray *arr){
         NSLog(@"---------- %@",arr); 
        [self pushStockList:arr];
        
    };
    
//    list.moreActionBlock = ^(MoreQuotatType style, NSString *text, NSString *main, NSString *sort){
//        [self pushMoreList:style text:text main:main sort:sort];
//        
//    };
//    list.plateActionBlock = ^(NSArray *arr, QuotatPlateType style){
//        [self pushPlateList:arr style:style];
//        
//    };
    list.cellActionBlock = ^(NSArray *arr){
        [self pushStockList:arr];
    };
    list.view.frame = CGRectMake(0, self.menu.maxY, JCLWIDTH, list.listH);
    [self.view addSubview:list.view];
    return list;
}

//K线页面
-(void)pushStockList:(NSArray *)arr{
   
    
    JCLStockMain *vc = [[JCLStockMain alloc]init];
    vc.arr = arr;
    NSLog(@"arrarrarr TSJRRealTimeMarket %@",arr);
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushMoreList:(MoreQuotatType)type text:(NSString *)text main:(NSString *)main sort:(NSString *)sort{
    JCLMarketInfoList *vc = [[JCLMarketInfoList alloc]init];
    vc.QuotatType = type; vc.textNav = text; vc.mainType = main; vc.sortType = sort;
    if (!self.isMarket) { vc.isCapital = YES; }
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushPlateList:(NSArray *)arr style:(QuotatPlateType)style{
    JCLMarketInfoList *vc = [[JCLMarketInfoList alloc]init];
    vc.isPlate = YES; vc.plateType = style; vc.array = arr;
    if (!self.isMarket) { vc.isCapital = YES;}
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.quotes viewWillAppear:YES];
}
@end
