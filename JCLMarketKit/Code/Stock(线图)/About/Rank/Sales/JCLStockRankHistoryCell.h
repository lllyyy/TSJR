//
//  JCLStockRankHistoryCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockRankHistoryCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style;
@property(nonatomic, weak) UILabel *info;
@property(nonatomic, strong) NSArray *rangeArr;
@property(nonatomic, strong) NSArray *scaleArr;
@end
