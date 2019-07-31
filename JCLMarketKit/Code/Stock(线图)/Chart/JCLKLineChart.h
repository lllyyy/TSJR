//
//  JCLKLineChart.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/5/26.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KLineGestureNot @"GestureNot"
#define KLineLongNot @"LongNot"
#define KLinePushNot @"PushNot"

typedef enum{
    IdxStyleOfVOL = 0,
    IdxStyleOfCCI,
    IdxStyleOfMACD,
    IdxStyleOfKDJ,
    IdxStyleOfRSI,
    IdxStyleOfPSY,
    IdxStyleOfWR,
    IdxStyleOfASI,
    IdxStyleOfOBV,
    IdxStyleOfROC,
    IdxStyleOfVR,
    IdxStyleOfDMI,
    IdxStyleOfDMA,
    IdxStyleOfFSL,
    
    IdxStyleOfTRIX,
    IdxStyleOfBRAR,
    IdxStyleOfCR,
    IdxStyleOfEMV,
    IdxStyleOfWVAD,
    IdxStyleOfMTM,
    IdxStyleOfBOLL
} JCLKLineIdxStyle;

@interface JCLKLineChart : UIView
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) NSArray *MAArr;
@property (nonatomic, strong) NSArray *idxArr;

@property (nonatomic, strong) NSString *decimal;
@property (nonatomic, assign) BOOL isMinute;

@property(nonatomic, assign) BOOL isScroll; // 是否滚动
@property(nonatomic, assign) BOOL isPage; // 是否分页
@property(nonatomic, assign) BOOL isIdx; // 是否指标
@property(nonatomic, assign) NSInteger drawStyle; // 是否画线

@property (nonatomic, assign) JCLKLineIdxStyle idxStyle;

-(void)needsDisplay;

@property (nonatomic, copy) void (^longActionBlock)(BOOL isHave, NSArray *obj);
@property (nonatomic, copy) void (^pageActionBlock)();
@end
