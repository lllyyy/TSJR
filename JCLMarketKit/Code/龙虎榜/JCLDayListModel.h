//
//  JCLDayList.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/13.
//   Copyright © 2017年 邢昭俊. All rights reserved.
//  每日上榜模型

#import <Foundation/Foundation.h>

@interface JCLDayListModel : NSObject
@property (nonatomic,strong) NSString *stock_name;
@property (nonatomic,strong) NSString *stock_code;
@property (nonatomic,strong) NSString *setcode;
//净买入额
@property (nonatomic,assign) float amount_buy_net;
//成交量
@property (nonatomic,assign) float volume;
//涨跌幅
@property (nonatomic,assign) float cp;
//换手率
@property (nonatomic,assign) float ch;
//成交额
@property (nonatomic,assign) float amount;
//上榜原因
@property (nonatomic,strong) NSString *reason;
//时间
@property (nonatomic,strong) NSString *ondate;

@end
