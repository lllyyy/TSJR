//
//  SecondViewController.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/5/4.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockMain.h"
#import "JCLStockList.h"
#import "JCLMarketSearchList.h"
#import "XLDStockHorizontal.h"
#import "JCLStockAboutDetailsList.h"
#import "JCLStockMsgModel.h"
#import "TSJRRealTimeMarket.h"
#import "JCLMarketInfoList.h"
#import "JCLKLineChart.h"
#import "JCLStockMsgDetail.h"
@interface JCLStockMain ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) JCLStockList *list;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, assign) NSInteger page;
@end

@implementation JCLStockMain
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.table removeFromSuperview];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.scroll = [JCLKitObj JCLScroll:self.view page:YES delegate:self];
    self.scroll.frame = self.view.bounds;
    
    NSLog(@"arrarrarr %@",self.arr);
    TSJRRealTimeMarket *mstockM = (TSJRRealTimeMarket *)self.arr;
    self.symbol = mstockM.symbol;
    
    NSLog(@"cn_namecn_name %@",mstockM.cn_name);
//    if ([mstockM.symbol isEqualToString:@".DJI"]) {
//        self.code = @"道琼斯";
//    }else if ([mstockM.symbol isEqualToString:@".IXIC"]){
//        self.code = @"纳斯达克";
//    }else if ([mstockM.symbol isEqualToString:@".INX"]){
//        self.code = @"标普指数";
//    }else{
//        self.code =[NSString stringWithFormat:@"%@",[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:mstockM.symbol]];
//    }
    
    
    CGFloat wh = 43;
  
    UIButton *retu = [JCLKitObj JCLButton:self.view img:@"" size:12 target:self action:@selector(retuAction)];
    retu.frame = CGRectMake(10, JCLSTATUS, wh, wh);
 
    self.page = 0 ;
//    self.page = [JCLMarketObj JCLStockIdx:self.arr[1]];
    [self InitList];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.list viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    NSNotificationCenter *not = [NSNotificationCenter defaultCenter];
    [not addObserver:self selector:@selector(pushNot:) name:KLinePushNot object:nil];
}

-(void)retuAction{ [self.navigationController popViewControllerAnimated:YES]; }
-(void)searchAction{  }
-(void)leftAction{ self.page--; [self InitList]; }
-(void)rightAction{ self.page++; [self InitList]; }
-(void)InitList{
    [JCLMarketObj JCLStockClear];
//    NSArray *stockArr = [JCLMarketObj JCLMarketInfos:self.code][self.page];
//    self.code = [NSString stringWithFormat:@"%@%@", stockArr[1], stockArr[2]];
    [self.list.view removeFromSuperview];
    JCLStockList *list = [[JCLStockList alloc]init];
//    list.arr = @[stockArr[3], self.code];
    list.arr = self.arr;

    list.switchActionBlock = ^(){
        XLDStockHorizontal *vc = [[XLDStockHorizontal alloc]init];
        
        vc.code = self.symbol;
        [self.navigationController pushViewController:vc animated:YES];
    };
    list.dealActionBlock = ^(){
        [AppDelegate shareAppDelegate].main.tabbar.selectedIndex = 3;
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    

    list.optionActionBlock = ^(){
        if (userId().length == 0){ JCLLOGIN; return; };
    };
    
    [self.scroll addSubview:list.view];
    list.view.frame = CGRectMake(0, 0, JCLWIDTH,New_Device? JCLHEIGHT - 34:JCLHEIGHT);

//    list.view.frame = CGRectMake(self.page*JCLWIDTH, 0, JCLWIDTH, self.scroll.height);
    self.list = list;
//    [self.scroll setContentOffset:CGPointMake(self.page*JCLWIDTH, 0) animated:YES];
}

-(void)pushNot:(NSNotification*)sender{
    self.list.isReload = YES;
    XLDStockHorizontal *vc = [[XLDStockHorizontal alloc]init];
    vc.code = self.symbol;
    [self.navigationController pushViewController:vc animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KLinePushNot object:nil];
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSInteger page = (scrollView.contentOffset.x-0.5*JCLWIDTH)/JCLWIDTH;
//    if (self.page > page) {
//        self.page--;
//    } else {
//        self.page++;
//    }
//    [self InitList];
//}
@end
