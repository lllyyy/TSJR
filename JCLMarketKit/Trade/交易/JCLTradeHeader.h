//
//  JCLTradeHeader.h
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/8.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLTradeSub1.h"
#import "JCLTradeSub2.h"
#import "JCLTradeSub3.h"
#import "JCLBarList.h"
typedef void(^TradeBlock)(NSDictionary *dic);
@interface JCLTradeHeader : UIView
@property (nonatomic, weak) UILabel *quan;
@property (nonatomic, weak) UILabel *usable;
@property (nonatomic, weak) UILabel *use;

@property (nonatomic, weak) JCLTradeSub1 *sub1;
@property (nonatomic, weak) JCLTradeSub2 *sub21;
@property (nonatomic, weak) JCLTradeSub2 *sub22;

@property (nonatomic, weak) JCLTradeSub3 *sub31;
@property (nonatomic, weak) JCLTradeSub3 *sub32;
@property (nonatomic, weak) JCLTradeSub3 *sub33;
@property(nonatomic,copy)TradeBlock block;
@property (nonatomic, weak) UIButton *order1;
@property (nonatomic, weak) UIButton *order2;
@property (nonatomic, weak) UIButton *order3;
@property (nonatomic, weak) UIButton *order4;

@property (nonatomic, weak) JCLBarList *bar;
@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSString *stock_code;
@property (nonatomic, strong) NSArray *objs;
@end
