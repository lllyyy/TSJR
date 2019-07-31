//
//  QuotationSearchCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/20.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLMarketSearchCell : UITableViewCell
+ (instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *code;
@property (nonatomic, weak) UIButton *option;
@property (nonatomic, copy) void (^addActionBlock)(UIButton *sender);
@end
