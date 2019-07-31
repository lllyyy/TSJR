//
//  JCLNewStockHeader.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/5/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLNewStockHeader : UIView
@property (nonatomic, strong) NSArray *textArr;

@property (nonatomic, weak) UIScrollView *scroll;
@property (nonatomic, copy) void (^slideActionBlock)(UIScrollView *scroll);

@property (nonatomic, copy) void (^codeActionBlock)(NSInteger idx);
@property (nonatomic, copy) void (^riseActionBlock)(NSInteger idx);
@property (nonatomic, copy) void (^dropActionBlock)(NSInteger idx);
@end
