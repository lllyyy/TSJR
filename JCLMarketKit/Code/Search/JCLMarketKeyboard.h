//
//  XLDStockKeyboard.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/12/8.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JCLMarketKeyboard : UIView
@property(nonatomic, weak) UIView *numBg;
@property(nonatomic, weak) UIView *azBg;
@property (nonatomic, copy) void (^submitActionBlock)(UIButton *button);
@end
