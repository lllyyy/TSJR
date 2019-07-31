//
//  JCLTradeRecordViewController.h
//  JCLFutures
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSTableList.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, TradeKind) {
    TradeToday,
    TradeHistory,
};
@interface JCLTradeRecordViewController : YSTableList
@property(nonatomic,assign)TradeKind kind;
@end

NS_ASSUME_NONNULL_END
