//
//  TSJRBuyingSellingVC.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/15.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "YSTableList.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSJRBuyingSellingVC : YSTableList
@property (nonatomic,strong) NSString *str;
@property (nonatomic,strong) NSString *action;//交易方向 BUY/SELL
@property (nonatomic,strong) NSString *limitPrice;//限价，当 order_type 为LMT,STP,STP_LMT时该参数必需
@property (nonatomic,strong) NSString *orderType;//订单类型. MKT（市价单）, LMT（限价单）, STP(止损单), STP_LMT(止损限价单), TRAIL(跟踪止损单)
@property (nonatomic,strong) NSString *secType;//合约类型(STK 股票 OPT 美股期权 WAR 港股窝轮 IOPT 港股牛熊证)
@property (nonatomic,strong) NSString *symbol;// 股票代码 如：AAPL
@property (nonatomic,strong) NSString *totalQuantity;//订单数量(港股，沪港通，窝轮，牛熊证有最小数量限制)
@property (nonatomic,strong) NSString *countCode;//数量
@property (nonatomic,strong) NSString *orderID;// 
@end

NS_ASSUME_NONNULL_END
