//
//  JCLStockRankMarketModel.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLStockRankModel : NSObject
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *amount_buy;
@property (nonatomic, copy) NSString *stock_count;
@property (nonatomic, copy) NSString *proportion_net_buy;
@property (nonatomic, copy) NSString *stocks;

@property (nonatomic, copy) NSString *industry_name;
@property (nonatomic, copy) NSString *theme_name;
@end

//"amount":"9511565751.56",
//"amount_buy":"181377400",
//"stock_count":"2",
//"proportion_net_buy":"1.91",
//"stocks":"000778.sz,000709.sz",
//"industry_name":"钢铁"

//"amount":"5551325313.16",
//"amount_buy":"72652400",
//"stock_count":"1",
//"proportion_net_buy":"1.31",
//"stocks":"002431.sz",
//"theme_name":"土十条"
