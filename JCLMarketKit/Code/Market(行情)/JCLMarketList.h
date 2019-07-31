//
//  JCLStockMarketList.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/9/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "YSTableList.h"
#import "JCLMarketInfoList.h"

typedef NS_ENUM(NSInteger, JCLMarketListStyle) {
    MarketQuotesList = 0, 
    MarketCapitalList
};

@interface JCLMarketList : YSTableList
@property (nonatomic, assign) JCLMarketListStyle style;

@property (nonatomic, copy) void (^idxActionBlock)(NSArray *arr);
@property (nonatomic, copy) void (^moreActionBlock)(MoreQuotatType style, NSString *text, NSString *main, NSString *sort);
@property (nonatomic, copy) void (^plateActionBlock)(NSArray *arr, QuotatPlateType style);
@property (nonatomic, copy) void (^cellActionBlock)(NSArray *arr);
@end
