//
//  JCLTradeKeyboard.h
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLTradeKeyboard : UIView
@property (nonatomic, weak) UILabel *val;
@property (nonatomic, weak) UIButton *diss;
@property (nonatomic, assign) BOOL isPrice;
@property (nonatomic, assign) BOOL isCode;

@property (nonatomic, copy) void (^valAction)(UIButton *sender);
@property (nonatomic, copy) void (^wayAction)(UIButton *sender);
@property (nonatomic, copy) void (^numAction)(UIButton *sender);
@property (nonatomic, copy) void (^volAction)(UIButton *sender);
@property (nonatomic, copy) void (^optAction)(UIButton *sender);
@end
