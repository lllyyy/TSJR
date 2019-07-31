//
//  JCLTransactionVC.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/23.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSTableList.h"

//分别对应买入、卖出、撤单、持仓、更多
typedef NS_ENUM(NSInteger,TransactionType){
    BuyType=0,
    SellType,
    KillType,
    PositionType,
    MoreType
};
@interface JCLTradList : YSTableList
@property (nonatomic,assign) TransactionType type;
@property (nonatomic,strong) NSString *codeStr;
@end
