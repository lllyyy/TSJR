//
//  JCLStockRankNotionCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLStockRankModel.h"

@interface JCLStockRankNotionCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style;
@property (nonatomic, strong) NSArray *arr;
@property(nonatomic, copy) void (^tapAction)(NSArray *arr);
@end
