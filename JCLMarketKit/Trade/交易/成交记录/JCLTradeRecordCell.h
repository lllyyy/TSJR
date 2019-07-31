//
//  JCLTradeRecordCell.h
//  JCLFutures
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCLTradeRecordCell : UITableViewCell

@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *trade_direction;
@property(nonatomic,strong)UILabel *trade_price;
@property(nonatomic,strong)UILabel *trade_number;
@property(nonatomic,strong)UILabel *trade_fee;
@property(nonatomic,strong)UILabel *trade_kind;
@property(nonatomic,strong)UILabel *trade_time;

@end

NS_ASSUME_NONNULL_END
