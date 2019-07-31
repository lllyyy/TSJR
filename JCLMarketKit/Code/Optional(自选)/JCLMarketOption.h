//
//  JCLMarketOption.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLMarketOption : UIView
@property (nonatomic, strong) UIButton *select;
@property (nonatomic, copy) void (^selectActionBlock)(UIButton *sender);
@property (nonatomic, copy) void (^deleteActionBlock)();
@end
