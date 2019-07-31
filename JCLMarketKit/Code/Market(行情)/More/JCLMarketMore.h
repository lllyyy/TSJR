//
//  JCLMarketMore.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/12/7.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "YSTableList.h"

@interface JCLMarketMore : YSTableList
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *main;
@property (nonatomic, copy) NSString *asc;//涨跌排序0降序1升序
@end
