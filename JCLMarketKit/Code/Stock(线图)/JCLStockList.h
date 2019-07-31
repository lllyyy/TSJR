//
//  StockController.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/11/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "YSTableList.h"
#import "JCLStockMsgModel.h"
#import "JCLKLineChart.h"
//K线页面
@interface JCLStockList : YSTableList
@property(nonatomic, strong) NSArray *arr;

@property(nonatomic, copy) void (^switchActionBlock)();
@property(nonatomic, copy) void (^dealActionBlock)();
@property(nonatomic, copy) void (^optionActionBlock)();
@property(nonatomic, copy) void (^popActionBlock)();

@property (nonatomic, assign) BOOL isReload;
@end
