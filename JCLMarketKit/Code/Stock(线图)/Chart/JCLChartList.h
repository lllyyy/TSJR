//
//  StockChartMenu.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/17/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLKLineChart.h"
// K线
@interface JCLChartList : UIView
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *decimal;
-(void)setNeedData;

@property (nonatomic, copy) void (^longActionBlock)(BOOL isHave, NSArray *obj);
@end
