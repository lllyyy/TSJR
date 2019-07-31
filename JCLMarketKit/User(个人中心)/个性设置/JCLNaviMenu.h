//
//  HQMarketHeader.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/8/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLNaviMenu : UIView
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, copy) void (^menuActionBlock)(UIButton *sender);
-(void)menuAction:(UIButton *)sender;

@property (nonatomic, assign) BOOL isLine;
@end
