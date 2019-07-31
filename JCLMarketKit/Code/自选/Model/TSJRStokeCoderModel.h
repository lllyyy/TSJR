//
//  TSJRStokeCoderModel.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/20.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "MMBaseModel.h"
#import "TSJRMarketOptionListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSJRStokeCoderModel : MMBaseModel
@property(nonatomic, copy) NSString *symbol;//代码
@property(nonatomic, copy) NSString *name;//名称
@property(nonatomic, copy) NSString *isexist;//是否收藏 0 没收藏  1 收藏


@property(nonatomic,strong) TSJRMarketOptionListModel* stock;
 
@end

NS_ASSUME_NONNULL_END
