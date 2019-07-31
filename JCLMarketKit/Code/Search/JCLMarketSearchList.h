//
//  QuotationSearch.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/20.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import "YSTableList.h"

@interface JCLMarketSearchList : YSTableList
@property (nonatomic, copy) void (^popActionBlock)(NSArray *infos);
@property(nonatomic,assign)BOOL isPop;
@property(nonatomic,assign)BOOL historical;
@end
