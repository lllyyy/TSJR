//
//  JCLStockReportCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockReportCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style;

@property(nonatomic, weak) UILabel *title;
@property(nonatomic, weak) UILabel *level;
@property(nonatomic, weak) UILabel *time;
@end
