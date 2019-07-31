//
//  JCLMarketInfo.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/27.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLMarketInfo : UIView
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *code;
@property (nonatomic, weak) UILabel *range;
@property (nonatomic, weak) UILabel *scale;

@property (nonatomic, copy) void (^tapActionBlock)();
@end
