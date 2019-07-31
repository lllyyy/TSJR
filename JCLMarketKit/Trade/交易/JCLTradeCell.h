//
//  JCLTradeCell.h
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/8.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLTradeCell : UITableViewCell
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, assign) NSInteger idx;
@property (nonatomic, assign) NSInteger orderIndex;
@property (nonatomic, weak) UILabel *lab1;
@property (nonatomic, weak) UILabel *lab2;
@property (nonatomic, weak) UILabel *lab3;
@property (nonatomic, weak) UILabel *lab4;
@property (nonatomic, weak) UILabel *lab5;
@property (nonatomic, weak) UILabel *lab6;
@end
