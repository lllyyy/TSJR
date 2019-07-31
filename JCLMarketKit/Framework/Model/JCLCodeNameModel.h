//
//  JCLCodeNameModel.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/12.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "MMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JCLCodeNameModel : MMBaseModel
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *symbol;
@end

NS_ASSUME_NONNULL_END
