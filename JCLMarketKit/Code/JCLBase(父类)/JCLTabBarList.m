//
//  TabBarController.m
//  RuiXueTuan
//
//  Created by 邢昭俊 on 14-6-14.
//  Copyright (c) 2014年 邢昭俊. All rights reserved.
//

#import "JCLTabBarList.h"

#pragma mark 1.JCLNaviBarList
@implementation JCLNaviBarList
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) { viewController.hidesBottomBarWhenPushed = YES; }
    [super pushViewController:viewController animated:animated];
}
@end

#pragma mark 2.JCLTabBar
@implementation JCLTabBar
-(instancetype)init{
    if (self = [super init]){ self.alpha = 1; self.barTintColor = [JCLColorObj JCLBgCol]; } return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger index = 0;
    
    for (UIView *tabBar in self.subviews) {
        if (![tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        for (UILabel *label in tabBar.subviews) {
            if (![label isKindOfClass:[UILabel class]]) continue;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:11];
            if ([self.items indexOfObject:self.selectedItem] == index) {
                label.textColor = JCL_SelText_COL;
            } else {
                label.textColor = JCL_Text_COL;
            }
            label.width = self.height;
//            label.height = self.height * 0.4;
        }
        index++;
    }
}
@end

#import "JCLMarketOptionList.h"
#import "JCLMarketMain.h"
#import "JCLMarketList.h"

#import "JCLUserList.h"
#import "JCLTradMain.h"
#import "JCLTradOpenList.h"
#import "JCLTradeList.h"
#import "TSJRNewVC.h"
#import "JCLTradingMainVC.h"
@interface JCLTabBarList ()<UITabBarControllerDelegate>
@end

@implementation JCLTabBarList
- (void)viewDidLoad {
    [super viewDidLoad];
  
     TSJRNewVC *list = [[TSJRNewVC alloc]init];
     [self setupChildList:list text:@"资讯" img:@"自选_n" selImg:@"自选_s"];
    
    
    JCLMarketOptionList *list1 = [[JCLMarketOptionList alloc] init];
    [self setupChildList:list1 text:@"自选" img:@"自选_n" selImg:@"自选_s"];

    JCLMarketMain *market = [[JCLMarketMain alloc] init];
    [self setupChildList:market text:@"行情" img:@"行情_n" selImg:@"行情_s"];
    
    JCLTradingMainVC *trad = [[JCLTradingMainVC alloc] init];
    [self setupChildList:trad text:@"交易" img:@"交易_n" selImg:@"交易_s"];
    
//    JCLTradeList *trad = [[JCLTradeList alloc] init];
//    [self setupChildList:trad text:@"交易" img:@"交易_n" selImg:@"交易_s"];
    
//    NSString *trade = PreRead(isTrade);
//    if ([trade isEqualToString:@"44"]) {
//
    
//
//    } else {
//
//        JCLTradOpenList *tradA = [[JCLTradOpenList alloc] init];
//        [self setupChildList:tradA text:@"资讯" img:@"交易_n" selImg:@"交易_s"];
// 

    
     JCLTradOpenList *open = [[JCLTradOpenList alloc] init];
//    [self setupChildList:open text:@"开户" img:@"交易_n" selImg:@"交易_s"];
    
    JCLUserList *user = [[JCLUserList alloc] init];
    [self setupChildList:user text:@"我的" img:@"我的_n" selImg:@"我的_s"];
    
    self.delegate = self;
    JCLTabBar *tabBar = [[JCLTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    bg.backgroundColor = JCL_Cell_COL;
    [self.tabBar insertSubview:bg atIndex:0];
    
    
    
}

- (void)setupChildList:(UIViewController *)list text:(NSString *)text img:(NSString *)img selImg:(NSString *)selImg{
    list.title = text;
    list.tabBarItem.image = [UIImage imageNamed:img];
    list.tabBarItem.selectedImage = [[UIImage imageNamed:selImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:JCLRGB(197, 171, 112) forKey:NSForegroundColorAttributeName];
    [list.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    
    JCLNaviBarList *navigation = [[JCLNaviBarList alloc] initWithRootViewController:list];
    [self addChildViewController:navigation];
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"%lu",(unsigned long)tabBarController.selectedIndex);
    if ([viewController.tabBarItem.title isEqualToString:@"交易"]){
        
        if (name().length == 0){
          
            [self.selectedViewController pushViewController:[[JCLUserLoginList alloc]init] animated:YES];
             return NO;
        };
        return YES;
    }

    return YES;
    
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{ [self.tabBar setNeedsLayout]; }
@end
