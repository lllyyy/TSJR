//
//  JCLOptionalCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLMarketOptionCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style;

@property (nonatomic, weak) UILabel *name;
@property (nonatomic, weak) UILabel *code;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UILabel *riseFall;
@end
