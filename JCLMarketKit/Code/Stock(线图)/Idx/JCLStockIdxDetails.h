//
//  JCLStockIdxCell.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/20.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLNaviMenu.h"
#import "JCLTimeChart.h"

@interface JCLStockIdxDetails : UIView
@property (nonatomic, weak) UILabel *code;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UILabel *range;
@property (nonatomic, weak) UILabel *scale;
@property (nonatomic, weak) UILabel *vol;
@property (nonatomic, weak) UILabel *rise;
@property (nonatomic, weak) UILabel *flat;
@property (nonatomic, weak) UILabel *fall;
@property (nonatomic, weak) UIButton *action;
@property (nonatomic, assign) BOOL isDetails;
@property (nonatomic, strong) JCLNaviMenu *menu;
@property (nonatomic, strong) JCLTimeChart *time;
@end
