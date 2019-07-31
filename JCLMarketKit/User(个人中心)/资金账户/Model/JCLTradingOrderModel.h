//
//  JCLTradingOrderModel.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/3.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "MMBaseModel.h"
#import "TSJRMarketOptionListModel.h"
NS_ASSUME_NONNULL_BEGIN
//订单模型
@interface JCLTradingOrderModel : MMBaseModel
@property (nonatomic, copy) NSString *account;//交易账户
@property (nonatomic, copy) NSString *action;
@property (nonatomic, copy) NSString *avgFillPrice;//交易账户
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *commission;//交易账户
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *discount;//交易账户
@property (nonatomic, copy) NSString *filledQuantity;
@property (nonatomic, copy) NSString *limitPrice;
@property (nonatomic, copy) NSString *idd;
@property (nonatomic, copy) NSString *latestTime;
@property (nonatomic, copy) NSString *localSymbol;
@property (nonatomic, copy) NSString *market;
@property (nonatomic, copy) NSString *openTime;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *orderType;
@property (nonatomic, copy) NSString *originSymbol;
@property (nonatomic, copy) NSString *outsideRth;//盘前盘后outsideRth    false    是否允许盘前、盘后
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *realizedPnl;
@property (nonatomic, copy) NSString *secType;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *stockId;
@property (nonatomic, copy) NSString *symbol;//股票代码
@property (nonatomic, copy) NSString *timeInForce;
@property (nonatomic, copy) NSString *totalQuantity;
@property(nonatomic,strong) TSJRMarketOptionListModel* stock;
-(NSString *)statusStr;
@end

NS_ASSUME_NONNULL_END
