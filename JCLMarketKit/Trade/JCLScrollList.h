//
//  JCLScrollList.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/9/27.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLKitList.h"
#import "JCLNaviMenu.h"
#import "YSTableList.h"

@interface JCLScrollList : JCLKitList
@property (nonatomic, weak) JCLNaviMenu *menu;
@property (nonatomic, weak) UIScrollView *scroll;

-(void)InitScrollList:(JCLScrollList *)list idx:(NSInteger)idx;
-(void)InitTableList:(YSTableList *)list idx:(NSInteger)idx;
@end
