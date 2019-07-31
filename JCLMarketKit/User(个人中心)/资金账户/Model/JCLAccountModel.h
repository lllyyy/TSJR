//
//  JCLAccountModel.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/26.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "MMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JCLAccountModel : MMBaseModel
@property (nonatomic, copy) NSString *account;//交易账户
@property (nonatomic, copy) NSString *netLiquidation; // 净清算值
@property (nonatomic, copy) NSString *netLiquidationUncertainty; // 不确定的净清算值
@property (nonatomic, copy) NSString *accruedCash;//净累计利息
@property (nonatomic, copy) NSString *accruedDividend ;//  净累计分红
@property (nonatomic, copy) NSString *availableFunds ;// 可用资金(可用于交易)
@property (nonatomic, copy) NSString *buyingPower  ;//   购买力
@property (nonatomic, copy) NSString *capability ;//   RegTMargin    账户类型，保证金RegTMargin现金Cash
@property (nonatomic, copy) NSString *cashBalance ;//     现金
@property (nonatomic, copy) NSString *cashValue ;//    证券账户金额+期货账户金额
@property (nonatomic, copy) NSString *currency  ;//    USD    货币
@property (nonatomic, copy) NSString *cushion ;//  当前保证金缓存
@property (nonatomic, copy) NSString *dayTradesRemaining ;//     -1    剩余日内交易次数，-1表示无限制
@property (nonatomic, copy) NSString *dayTradesRemainingT1  ;//    -1    剩余日内交易次数T+1
@property (nonatomic, copy) NSString *dayTradesRemainingT2  ;//    -1    剩余日内交易次数T+2
@property (nonatomic, copy) NSString *dayTradesRemainingT3  ;//    -1    剩余日内交易次数T+3
@property (nonatomic, copy) NSString *dayTradesRemainingT4  ;//    -1    剩余日内交易次数T+4
@property (nonatomic, copy) NSString *equityWithLoan    ;//      含借贷值股权
@property (nonatomic, copy) NSString *excessLiquidity  ;// 必须维持的缓冲保证金的数额，日内风险数值（App）
@property (nonatomic, copy) NSString *grossPositionValue    ;//   持仓市值
@property (nonatomic, copy) NSString *marginReq;
@property (nonatomic, copy) NSString *maintMarginReq ;//      维持保证金要求
@property (nonatomic, copy) NSString *regTEquity   ;//      RegT资产
@property (nonatomic, copy) NSString *regTMargin   ;//    RegT保证金
@property (nonatomic, copy) NSString *SMA    ;//     特殊备忘录账户，隔夜风险数值（App）
@property (nonatomic, copy) NSString *stockMarketValue   ;//     股票市值
@property (nonatomic, copy) NSString *realizedPnl   ;//      实际盈亏
@property (nonatomic, copy) NSString *unrealizedPnL    ;//      浮动盈亏
@property (nonatomic, copy) NSString *prevRealizedPnl    ;//      前一日实际盈亏
@property (nonatomic, copy) NSString *prevUnrealizedPnl    ;//     前一日浮动盈亏
@property (nonatomic, copy) NSString *settledCash    ;//      结算利息
@property (nonatomic, copy) NSString *previousEquityWithLoanValue   ;//      前一天的ELV
@property (nonatomic, copy) NSString *segments  ;//     字段参考下面说明
@property (nonatomic, copy) NSString *marketValues  ;//      市场的市值，含义参考下面说明
@end

NS_ASSUME_NONNULL_END
