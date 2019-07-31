//
//  JCLAStockRangeCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLAStockRangeCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style;
@property(nonatomic, strong) NSArray *arr;
@property(nonatomic, strong) NSArray *keyArr;
@end
