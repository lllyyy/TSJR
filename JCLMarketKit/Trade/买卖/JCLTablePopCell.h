//
//  JCLStockRankDateCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/18.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLTablePopCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style;
@property(nonatomic, weak) UIView *bg;
@property(nonatomic, weak) UILabel *time;
@property(nonatomic, weak) UIButton *icon;
@end
