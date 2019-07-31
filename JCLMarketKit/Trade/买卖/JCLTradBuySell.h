//
//  JCLBuyAndSell.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/23.
//  Copyright © 2017年 刘虎超. All rights reserved.
//  买卖View

#import <UIKit/UIKit.h>

@interface JCLTradBuySell : UIView
@property (nonatomic,strong) UILabel *money;
@property (nonatomic,strong) UILabel *remain;
@property (nonatomic,strong) UILabel *buyVol;
@property (nonatomic,strong) UILabel *sellVol;

@property (nonatomic,strong) UIButton *buy;
@property (nonatomic,strong) UIButton *sell;

-(void)codeAction:(UITextField *)text;
@property (nonatomic, copy) void (^buySellActionBlock)();
@end
