//
//  JCLMarketPlateCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/27.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLMarketPlateCell : UITableViewCell
+ (instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, copy) void (^tapActionBlock)(NSInteger idx);
@end
