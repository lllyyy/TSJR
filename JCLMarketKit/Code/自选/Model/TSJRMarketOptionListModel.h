//
//  TSJRMarketOptionListModel.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/19.
//  Copyright © 2019 卢杨. All rights reserved.
//
//自选列表
#import "MMBaseModel.h"
#import "TSJRHourTradingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSJRMarketOptionListModel : MMBaseModel
@property(nonatomic, copy) NSString *askPrice;
@property(nonatomic, copy) NSString *askSize;
@property(nonatomic, copy) NSString *bidPrice;
@property(nonatomic, copy) NSString *bidSize;
@property(nonatomic, copy) NSString *close;
@property(nonatomic, copy) NSString *high;
@property(nonatomic, strong) TSJRHourTradingModel *hourTrading;
@property(nonatomic, copy) NSString *latestPrice;
@property(nonatomic, copy) NSString *latestTime;
@property(nonatomic, copy) NSString *low;
@property(nonatomic, copy) NSString *open;
@property(nonatomic, copy) NSString *preClose;
@property(nonatomic, copy) NSString *status;
@property(nonatomic, copy) NSString *symbol;
@property(nonatomic, copy) NSString *volume;
@property(nonatomic, copy) NSString *cn_name;
@property(nonatomic, copy) NSString *price;
 @property(nonatomic, copy) NSString *prevclose;

@property(nonatomic, copy) NSString *percent;//跌涨幅
@end

NS_ASSUME_NONNULL_END
