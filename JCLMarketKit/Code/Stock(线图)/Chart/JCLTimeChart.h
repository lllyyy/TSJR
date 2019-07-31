//
//  JCLTimeChart.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/6/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLKLineChart.h"

@interface JCLTimeChart : UIView
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) NSString *close;
@property (nonatomic, strong) NSString *decimal;
@property (nonatomic, strong) NSArray *times;

@property (nonatomic, copy) void (^longActionBlock)(BOOL isHave, NSArray *obj);
@end
