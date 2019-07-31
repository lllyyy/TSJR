//
//  TSJRTradingOrderDetailVC.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/14.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "JCLKitList.h"
#import "JCLTradingOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSJRTradingOrderDetailVC : JCLKitList
@property (nonatomic, weak) UITableView *table;
@property (nonatomic,strong) JCLTradingOrderModel *tradingmodel;
@end

NS_ASSUME_NONNULL_END
