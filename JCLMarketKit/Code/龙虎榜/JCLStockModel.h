//
//  JCLStockModel.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/13.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//  龙虎榜个股排名

#import <Foundation/Foundation.h>

@interface JCLStockModel : NSObject
@property (nonatomic,strong) NSString *stock_name;
@property (nonatomic,strong) NSString *stock_code;
@property (nonatomic,strong) NSString *setcode;
@property (nonatomic,assign) float amount_net_buy;
//上榜次数
@property (nonatomic,assign) int times;
@property (nonatomic,assign) int times_buy ;
@property (nonatomic,strong) NSString *company_name;
@end

@interface JCLRankModel : NSObject
@property (nonatomic,assign) int times_buy ;
@property (nonatomic,strong) NSString *company_id;
@property (nonatomic,strong) NSString *company_name;
@end
