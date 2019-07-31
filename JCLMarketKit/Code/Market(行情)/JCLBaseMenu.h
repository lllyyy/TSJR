//
//  JCLBaseMenu.h
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/3/28.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLKitModel.h"

typedef NS_ENUM(NSInteger, JCLBaseMenuStyle) {
    MenuStyleNormal = 0,  // 菜单类型
    MenuStyleIdxLine,
    MenuStyleBGLine,
};

@interface JCLBaseMenu : UIView
@property(nonatomic, assign) JCLBaseMenuStyle style;

@property(nonatomic, strong) NSArray *arr;
@property(nonatomic, strong) UIColor *color;
@property(nonatomic, assign) CGFloat size;
@property(nonatomic, assign) BOOL isLCR;
@property(nonatomic, assign) NSInteger idx;

@property (nonatomic, weak) UIView *idxLine; // 下标线
@property (nonatomic, weak) UIView *bgLine;

@property (nonatomic, assign) BOOL isLine; // 是否有分割线

@property(nonatomic, assign) BOOL isAction;
@property (nonatomic, weak) JCLKitModel *select;
@property (nonatomic, assign) NSInteger hisIdx;
@property(nonatomic, copy) void (^tapActionBlock)(NSInteger idx);
@end
