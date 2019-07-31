//
//  JCLMarketDefine.h
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/2/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#ifndef JCLMarketDefine_h
#define JCLMarketDefine_h

#include <stdio.h>

#import "JCLHttpsObj.h"
#import "JCLMarketDataObj.h"
#import "JCLStockDataObj.h"

#define JCLMarketURL @"http://192.168.0.200:4181/" // 金策略行情模块url地址切换
#define JCLSelfURL @"http://47.100.108.27/self-select-stock/"

#define JCLAuthURL @"http://47.100.108.27/mobile-auth/auth.do?"
#define JCLWebURL @"http://47.100.108.27/nljj-cms/userinfo/"
#define JCLOpenURL @"http://47.100.108.27/nljj-cms/userinfoData/"

#define JCLRandom [NSString stringWithFormat:@"&r=%u",arc4random_uniform(1000000)]

#define SeverDate @"webDate" // 存放服务器时间

// 市场入口
#define JCL_Market_Main_Industry			 32   // 行业板块
#define JCL_Market_Main_Idea			     33   // 概念板块
#define JCL_Market_Main_Region		     	 31   // 地域板块
#define JCL_Market_Main_RoseDrop		      6   // 涨跌幅
#define JCL_Market_Main_Deal		          0   // 换手率, 成交额
#define JCL_Market_Main_Plate	            200   // 某个板块下的

// 板块入口
#define JCL_Market_DYBK	            100   // 地域板块
#define JCL_Market_HYBK	            200   // 行业板块
#define JCL_Market_GNBK	            300   // 概念板块

// 市场排序字段
#define JCL_Market_Sort_RoseDrop			14   // 涨跌幅
#define JCL_Market_Sort_Turnover		36 // 换手率
#define JCL_Market_Sort_Deal	        10 // 成交额

// 市场信息字段
#define JCL_Market_Info_Code			0   // 市场代码
#define JCL_Market_Info_Title			1   // 市场标题
#define JCL_Market_Info_Current			6   // 市场现价
#define JCL_Market_Info_Open	     	3   // 市场开盘价
#define JCL_Market_Info_Close			2   // 市场昨收
#define JCL_Market_Info_Height		4   // 市场最高价
#define JCL_Market_Info_Low	        5   // 市场最低价
#define JCL_Market_Info_TotalHands  9   // 市场总手
#define JCL_Market_Info_Deal			10   // 市场总金额
#define JCL_Market_Info_Turnover		36   // 市场换手率

#define JCL_Market_ZLJLC     145   // 主力净流出
#define JCL_Market_ZLJLR	 146   // 主力净流入
#define JCL_Market_ZLJLC3    147   // 主力净流出
#define JCL_Market_ZLJLR3    148   // 主力净流入
#define JCL_Market_ZLJLC5	 149   // 主力净流出
#define JCL_Market_ZLJLR5    150   // 主力净流入

//#define JCL_Order	    1   // 升序
//#define JCL_Drop		1   // 降序

#endif /* JCLMarketDefine_h */
