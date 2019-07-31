//
//  TSJRMarketHeaderModel.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/4/18.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "MMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSJRMarketHeaderModel : MMBaseModel
@property (nonatomic, copy) NSString *change;
@property (nonatomic, copy) NSString *market;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *percent;
@property (nonatomic, copy) NSString *sname;
@property (nonatomic, copy) NSString *symbol;
@end

NS_ASSUME_NONNULL_END
