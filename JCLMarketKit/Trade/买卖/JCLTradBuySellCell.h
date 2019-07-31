//
//  JCLTradBuySellCell.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLTradBuySellCell : UIView
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UITextField *text;

@property (nonatomic, assign) BOOL isNum;
@property (nonatomic, assign) BOOL isVol;

@property (nonatomic, weak) UIButton *add;
@property (nonatomic, weak) UIButton *reduce;
@end
