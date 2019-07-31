//
//  TSJRHourTradingModel.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/4/23.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "MMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSJRHourTradingModel : MMBaseModel
@property(nonatomic, copy) NSString *latestPrice;
@property(nonatomic, copy) NSString *latestTime;
@property(nonatomic, copy) NSString *preClose;
@property(nonatomic, copy) NSString *tag;
@property(nonatomic, copy) NSString *timestamp;
@property(nonatomic, copy) NSString *volume;
@end

NS_ASSUME_NONNULL_END
