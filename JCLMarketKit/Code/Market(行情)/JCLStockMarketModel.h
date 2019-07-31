//
//  JCLStockMarketModel.h
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/2/22.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLStockMarketModel : NSObject
@property (nonatomic, copy) NSString *code; // 市场代码
@property (nonatomic, copy) NSString *title; // 市场标题
@property (nonatomic, copy) NSString *current; // 市场现价
@property (nonatomic, copy) NSString *open; // 市场开盘价
@property (nonatomic, copy) NSString *close; // 市场昨收
@property (nonatomic, copy) NSString *height; // 市场最高价
@property (nonatomic, copy) NSString *low; // 市场最低价


@property (nonatomic, copy) NSString *range; // 市场涨跌
@property (nonatomic, copy) NSString *scale; // 市场涨跌幅


@property (nonatomic, copy) NSString *rise; // 市场上涨家数
@property (nonatomic, copy) NSString *flat; // 市场平盘家数
@property (nonatomic, copy) NSString *fall; // 市场下跌家数
@end
