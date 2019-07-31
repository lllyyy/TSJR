//
//  TSJRRealTimeMarket.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/4/9.
//  Copyright © 2019 卢杨. All rights reserved.
//
//实时行情
#import "MMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSJRRealTimeMarket : MMBaseModel
@property(nonatomic, copy) NSString *symbol;// 股票代码
@property(nonatomic, copy) NSString *open ;//   double    开盘价
@property(nonatomic, copy) NSString *high ;//  double    最高价
@property(nonatomic, copy) NSString *low  ;//  double    最低价
@property(nonatomic, copy) NSString *close ;//   double    收盘价
@property(nonatomic, copy) NSString *preClose  ;//  double    前一交易日收盘价
@property(nonatomic, copy) NSString *latestPrice ;//   double    最新价
@property(nonatomic, copy) NSString *latestTime ;//   long    最新成交时间
@property(nonatomic, copy) NSString *latestSize ;//   integer    最新成交数量
@property(nonatomic, copy) NSString *askPrice  ;//  double    卖盘价
@property(nonatomic, copy) NSString *askSize  ;//  long    卖盘数量
@property(nonatomic, copy) NSString *bidPrice  ;//  double    买盘价
@property(nonatomic, copy) NSString *bidSize  ;//  long    买盘数量
@property(nonatomic, copy) NSString *volume  ;//  long    成交量
@property(nonatomic, copy) NSString *status  ;//  short    交易状态
@property(nonatomic, copy) NSString *cn_name;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *avgPrice  ;//
@property(nonatomic, copy) NSString *price;//
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *percent;
@end

NS_ASSUME_NONNULL_END
