//
//  JCLChartScale.h
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/3/9.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JCLChartScaleStyle) {
    JCLChartScaleBoxV,
    JCLChartScaleLineV,
    JCLChartScaleBoxH,
    JCLChartScaleLineH,
};

@interface JCLChartScale : UIView
@property (nonatomic, assign) JCLChartScaleStyle style;

@property (nonatomic, strong) NSArray *idxArr;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) NSUInteger alignment;
@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) NSArray *textCols; // 对应的色值数据
@end
