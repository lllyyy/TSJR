//
//  JCLAccountOverviewVC.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/18.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "YSTableList.h"
#import "JCLAccountModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JCLSimulationAccountVC : YSTableList
@property (nonatomic,strong) JCLAccountModel *accountModel;
@end

NS_ASSUME_NONNULL_END
