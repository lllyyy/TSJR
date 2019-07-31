//
//  JCLResearchVC.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/29.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "JCLResearchVC.h"
#import "LHCMenuView.h"
#import "JCLLimitVC.h"
#import "JCLNewStockVC.h"
#import "JCLAuctionVC.h"
#import "JCLStockMain.h"
@interface JCLResearchVC ()
{
    JCLLimitVC *_limitVC;
    JCLNewStockVC *_stockVC;
    JCLAuctionVC *_auctionVC;
    NSInteger _idx;
}

@end

@implementation JCLResearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.middle.title=@"数据研究";
    [self setupChildVes];
    [self drawMenuView];
    __weak JCLResearchVC *weakSelf=self;
    _limitVC.action = ^(NSArray *array) {
        [weakSelf pushVC:array];
    };
    
    _auctionVC.AuctionAction = ^(NSArray *array) {
        [weakSelf pushVC:array];
    };
    
    _stockVC.PushList = ^(NSArray *array) {
         [weakSelf pushVC:array];
    };
}

- (void)timerActionRelodata{
    if(_idx==0){
    [_limitVC    loadData];
    }else if(_idx==2){
    [_auctionVC  loadData];
    }else{
    [_stockVC    loadData];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate.shareAppDelegate.timerAtionBlock = ^() {
         [self timerActionRelodata];
     };
    [_limitVC    loadData];
    [_auctionVC  loadData];
    [_stockVC    loadData];
}

- (void)pushVC:(NSArray *)array{
    JCLStockMain *stockVC=[[JCLStockMain alloc]init];
    stockVC.arr=array;
    [self.navigationController pushViewController:stockVC animated:YES];
}

//初始化子控制器
- (void)setupChildVes
{
    _limitVC=[[JCLLimitVC alloc]init];
    _stockVC=[[JCLNewStockVC alloc]init];
    _auctionVC=[[JCLAuctionVC alloc]init];
    [self ViewForVC:_limitVC];
    [self ViewForVC:_stockVC];
    [self ViewForVC:_auctionVC];
    _limitVC.view.hidden=NO;
}

- (void)ViewForVC:(JCLBaseVC *)vc{
    vc.view.frame=CGRectMake(0, 64+[LHCObject height:40], JCLWIDTH, JCLHEIGHT-64-[LHCObject height:40]);
  //  vc.navi.left.image=@"";
    vc.navi.hidden=YES;
    vc.view.hidden=YES;
    [self.view addSubview:vc.view];
}

//数据研究父控制器的MenuView
- (void)drawMenuView{
    LHCMenuView *menuView=[LHCMenuView MenuViewTitleArray:@[@"涨停捉妖",@"次新擒牛",@"集合竞价"] SelectLineHeight:0 SelectLineColor:[UIColor redColor] Selectidx:0 Blcok:^(UIButton *btn) {
        _limitVC.view.hidden=YES;
        _stockVC.view.hidden=YES;
        _auctionVC.view.hidden=YES;
        _idx=btn.tag;
        switch (btn.tag) {
            case 0:
            _limitVC.view.hidden=NO;
            break;
            case 1:
            _stockVC.view.hidden=NO;
            break;
            
          default:
            _auctionVC.view.hidden=NO;
            break;
        }
    }];
    menuView.isBgImg = YES;
    menuView.backgroundColor = [UIColor whiteColor];
    menuView.frame   = CGRectMake(0, 64, 0.75*JCLWIDTH, [LHCObject height:40]);
    [self.view addSubview:menuView];
    
    UIView *line = [LHCObject LHCView:self.view backgroundColor:JCLRGB(220, 220, 220)];
    line.frame   = CGRectMake(menuView.maxX, menuView.maxY-1, 0.25*JCLWIDTH, 1);
    line.alpha   = 0.6;
}
@end
