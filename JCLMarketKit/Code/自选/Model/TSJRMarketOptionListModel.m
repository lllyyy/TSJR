//
//  TSJRMarketOptionListModel.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/19.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRMarketOptionListModel.h"

@implementation TSJRMarketOptionListModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"hourTrading" : [TSJRHourTradingModel class],
             };
}

@end
