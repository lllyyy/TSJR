//
//  JCLStockDrawStyle.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/8/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#ifndef JCLStockDrawStyle_h
#define JCLStockDrawStyle_h

#include <stdio.h>

typedef NS_ENUM(NSInteger, JCLStockDrawStyle) {
    JCLStockDraw=0,//止盈卖出
    EntrustMeteoriteSell,//止损卖出
    EntrustTimingBuy,//定时买入
    EntrustTimingSell,//定时卖出
    EntrustBrokenBuy,//上破买入
    EntrustBrokenSell,//上破卖出
    EntrustDownBuy,//下破买入
    EntrustDownSell,//下破卖出
    EntrustArriveBug,//到价买入
    EntrustArriveSell,//到价卖出
    
    ModelDown=100,//打压建仓
    ModelLow,//低位建仓
    ModelLift,//拉升建仓
    ModelCallback,//回调买入
    ModelHeight,//拉高出货
    ModelProfit,//回落止盈
    ModelDownSell,//打压出货
    ModelReboundSell,//反弹卖出
    ModelBreakthrough,//突破
    ModelConsolidation,//盘整
    ModelLowAndChaseBuy,//低买或者高买
    ModelHeightAndChaseSell,//高卖或追卖
    
    StrategyBottom=200,//智能抄底策略
    StrategySellTop,//智能卖顶策略
    StrategyGrid,//网格交易策略
    StrategyT0,//T+0 交易策略
    StrategProfit//动态止盈策略
};


#endif /* JCLStockDrawStyle_h */
