//
//  JCLOrderMainVC.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/27.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "JCLOrderMainVC.h"
#import "CAPSPageMenu.h"
#import "JCLTradingOrderVC.h"
@interface JCLOrderMainVC ()<CAPSPageMenuDelegate>
@property (nonatomic) CAPSPageMenu *pageMenu;
@end

@implementation JCLOrderMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navi.middle.title = @"订单";
    self.navi.bg.backgroundColor = RGB(55, 61, 93);
    self.view.backgroundColor = JCL_Bg_COL;
    NSMutableArray *controllerArray = [NSMutableArray array];
    JCLTradingOrderVC *vc = [[JCLTradingOrderVC alloc]init];
    vc.title = @"待成交";
    
    JCLTradingOrderVC *vcA = [[JCLTradingOrderVC alloc]init];
    vcA.title = @"已成交";
    
    JCLTradingOrderVC *vcB = [[JCLTradingOrderVC alloc]init];
    vcB.title = @"已撤销";
    
    controllerArray = @[vc,vcA, vcB].mutableCopy;
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: JCL_Cell_COL,
                                 CAPSPageMenuOptionViewBackgroundColor: JCL_Cell_COL,
                                 CAPSPageMenuOptionSelectionIndicatorColor: JCL_SelText_COL,
                                 CAPSPageMenuOptionBottomMenuHairlineColor:  JCL_Bg_COL,
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor: JCL_SelText_COL,
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor: JCLAccountRGB,
                                 CAPSPageMenuOptionMenuItemFont:[UIFont systemFontOfSize:14],
                                 CAPSPageMenuOptionMenuHeight: @(45.0),
                                 CAPSPageMenuOptionMenuItemWidth: @(kScreenWidth / 3),
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl:@(YES),
                                 // CAPSPageMenuOptionCenterMenuItems: @(YES)
                                 };
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, JCLNAVI, self.view.frame.size.width, self.view.frame.size.height-JCLNAVI) options:parameters];
    
     _pageMenu.delegate = self;
    [self.view addSubview:_pageMenu.view];
//    [self performSelector:@selector(addVC) withObject:nil afterDelay:0.1];
}
- (void)addVC {
    [self addChildViewController: _pageMenu.controllerArray[0]];
}
- (void)willMoveToPage:(UIViewController *)controller index:(NSInteger)index {
    
//    [self addChildViewController:controller];
}

- (void)didMoveToPage:(UIViewController *)controller index:(NSInteger)index {
//    [self addChildViewController:controller];
}
@end
