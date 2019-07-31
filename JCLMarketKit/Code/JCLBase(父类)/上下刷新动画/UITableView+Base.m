//
//  UITableView+Extension.m
//  常用类的封装
//
//  Created by 刘虎超 on 2017/6/7.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "UITableView+Base.h"
@implementation UITableView (Base)
#pragma mark 带动画的
-(void)JCLHeaderGifBlock:(void (^)(void))block{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{ block(); }];
    NSMutableArray *imgs = [[NSMutableArray alloc]init];
    for (NSInteger i=1;i<31;i++){ [imgs addObject:[UIImage imageNamed:[NSString stringWithFormat:@"tu%zd.png",i]]]; }
    [header setImages:imgs forState:MJRefreshStateIdle];
    [header setImages:imgs forState:MJRefreshStatePulling];
    [header setImages:imgs forState:MJRefreshStateRefreshing];
    //header.mj_h=75; header.labelLeftInset=-10;
    header.stateLabel.hidden = YES; header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header=header;
}

-(void)JCLFooterGifBlock:(void (^)(void))block {
    MJRefreshAutoGifFooter *footer =  [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{ block(); }];
    NSMutableArray *imgs = [[NSMutableArray alloc]init];
    for (NSInteger i=1;i<31;i++){ [imgs addObject:[UIImage imageNamed:[NSString stringWithFormat:@"tu%zd.png",i]]]; }
    [footer setImages:imgs forState:MJRefreshStateIdle];
    [footer setImages:imgs forState:MJRefreshStatePulling];
    [footer setImages:imgs forState:MJRefreshStateRefreshing];
    footer.refreshingTitleHidden = YES;
    self.mj_footer=footer;
}

#pragma mark 不带动画的
-(void)JCLHeaderBlock:(void (^)(void))block{
    MJRefreshNormalHeader *header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{ block(); }];
    self.mj_header=header;
}

-(void)JCLFooterBlock:(void (^)(void))block{
    MJRefreshBackNormalFooter *footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{ block(); }];
    self.mj_footer=footer;
}
@end
