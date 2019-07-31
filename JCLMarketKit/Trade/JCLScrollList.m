//
//  JCLScrollList.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/9/27.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLScrollList.h"

@interface JCLScrollList ()<UIScrollViewDelegate>
@end

@implementation JCLScrollList
-(void)viewDidLoad {
    [super viewDidLoad];
    
    JCLNaviMenu *menu = [[JCLNaviMenu alloc]init]; [self.view addSubview:menu];
    menu.menuActionBlock = ^(UIButton *senser){
        CGPoint offSet = self.scroll.contentOffset;
        offSet.x = senser.tag * self.scroll.width;
        [self.scroll setContentOffset:offSet animated:YES];
    };
    self.menu = menu;
    
    UIScrollView *scroll = [[UIScrollView alloc]init]; [self.view addSubview:scroll];
    scroll.pagingEnabled = YES; scroll.delegate = self;
    self.scroll = scroll;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger idx = scrollView.contentOffset.x / scrollView.width;
    [self.menu menuAction:self.menu.scroll.subviews[idx]];
}

-(void)InitTableList:(YSTableList *)list idx:(NSInteger)idx{
    list.listH = self.listH-self.menu.maxY;
    list.view.frame = CGRectMake(JCLWIDTH*idx, 0, JCLWIDTH, list.listH);
    [self.scroll addSubview:list.view];
}

-(void)InitScrollList:(JCLScrollList *)list idx:(NSInteger)idx{
    list.listH = JCLSCROLL-self.menu.maxY;
    list.view.frame = CGRectMake(JCLWIDTH*idx, 0, JCLWIDTH, list.listH);
    [self.scroll addSubview:list.view];
}
@end
