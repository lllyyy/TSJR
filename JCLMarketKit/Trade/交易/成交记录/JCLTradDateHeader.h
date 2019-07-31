//
//  JCLTradDateHeader.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLTradDateHeader : UIView
@property (nonatomic, strong) NSString *beginVal;
@property (nonatomic, strong) NSString *endVal;

@property (nonatomic, weak) UIButton *begin;
@property (nonatomic, weak) UIButton *end;
@property (nonatomic, weak) UIButton *submit;
@property (nonatomic, copy) void (^dateActionBlock)(NSString *val);
@end
