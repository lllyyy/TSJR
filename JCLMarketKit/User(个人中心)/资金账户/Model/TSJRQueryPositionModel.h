//
//  TSJRQueryPositionModel.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/14.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "MMBaseModel.h"
#import "TSJRMarketOptionListModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface TSJRQueryPositionModel : MMBaseModel
@property (nonatomic, copy) NSString *account;//交易账户
@property (nonatomic, copy) NSString *averageCost;    // 平均成本
@property (nonatomic, copy) NSString *currency  ;// 交易货币USD/HKD/CNH
@property (nonatomic, copy) NSString *expiry  ;//   期权过期日
@property (nonatomic, copy) NSString *latestPrice ;//    最新价格
@property (nonatomic, copy) NSString *multiplier  ;//  每手数量持仓
@property (nonatomic, copy) NSString *originSymbol ;//   期权标识
@property (nonatomic, copy) NSString *marketValue ;//   期权标识
@property (nonatomic, copy) NSString *position  ;//   持仓数量
@property (nonatomic, copy) NSString *preClose ;//  收盘价
@property (nonatomic, copy) NSString *right   ;//    期权方向
@property (nonatomic, copy) NSString *secType ;//  交易类型
@property (nonatomic, copy) NSString *strike ;//    期权底层价格
@property (nonatomic, copy) NSString *symbol ;//   股票代码
@property (nonatomic, copy) NSString *unrealizedPnl ;//  浮动盈亏
//@property (nonatomic, copy) NSString *name ;//

@property(nonatomic,strong) TSJRMarketOptionListModel* stock;
@end

NS_ASSUME_NONNULL_END
