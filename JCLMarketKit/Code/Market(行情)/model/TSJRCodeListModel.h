//
//  TSJRCodeListModel.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/4/22.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "MMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSJRCodeListModel : MMBaseModel
@property (nonatomic, copy) NSString *change;
@property (nonatomic, copy) NSString *cn_name;
@property (nonatomic, copy) NSString *high;
@property (nonatomic, copy) NSString *high52;
@property (nonatomic, copy) NSString *low;
@property (nonatomic, copy) NSString *low52;
@property (nonatomic, copy) NSString *open;
@property (nonatomic, copy) NSString *pe;
@property (nonatomic, copy) NSString *percent;
@property (nonatomic, copy) NSString *pre_change;
@property (nonatomic, copy) NSString *pre_percent;
@property (nonatomic, copy) NSString *prevclose;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, copy) NSString *totalShare;
@property (nonatomic, copy) NSString *totalVolume;
 
@end

NS_ASSUME_NONNULL_END
