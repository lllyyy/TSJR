//
//  JCLStockDraw.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/8/28.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockDraw : UIView
@property (nonatomic, copy) void (^buttonActionBlock)(NSInteger idx);
@end
