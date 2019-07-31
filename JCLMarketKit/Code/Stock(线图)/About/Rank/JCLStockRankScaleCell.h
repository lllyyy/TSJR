//
//  JCLStockRankScaleCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/14.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockRankScaleCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) NSArray *keyArr;
@property (nonatomic, strong) NSArray *valArr;
@end
