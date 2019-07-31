//
//  JCLStockTodayCapitalCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockTodayCapitalCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)table style:(UITableViewCellStyle)style;
@property (nonatomic, strong) NSArray *keyCols;
@property (nonatomic, strong) NSArray *keyArr;
@end
