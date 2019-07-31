//
//  TSJRNewModel.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/21.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "MMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSJRNewModel : MMBaseModel
@property (nonatomic, copy) NSString *author;//"author": "新浪财经",
@property (nonatomic, copy) NSString *title;//"title",
@property (nonatomic, copy) NSString *url;//
@property (nonatomic, copy) NSString *timestamp;//"时间
@property (nonatomic, copy) NSString *docid;
@property (nonatomic, copy) NSArray *thumbs;
@property (nonatomic, copy) NSString *type;//过滤专题 = 14;

@end

NS_ASSUME_NONNULL_END
