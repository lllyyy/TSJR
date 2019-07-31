//
//  XLDStockNavigation.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/25.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLDStockNavigation : UIView
@property (nonatomic, weak) UILabel *textLab;
@property (nonatomic, weak) UILabel *priceLab;
@property (nonatomic, weak) UILabel *rangeLab;
@property (nonatomic, weak) UILabel *scaleLab;
@property (nonatomic, weak) UILabel *numberLab;
@property (nonatomic, weak) UILabel *moneyLab;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, copy) void (^dissActionBlock)();
@end
