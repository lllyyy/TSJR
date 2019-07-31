//
//  RangeMoreHeader.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/11/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLMarketInfoHeader : UIView
@property (nonatomic, strong) NSArray *textArr;

@property (nonatomic, weak) UIScrollView *scroll;
@property (nonatomic, copy)void (^slideActionBlock)(UIScrollView *scroll);

@property (nonatomic, assign) NSInteger idx;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy)void (^codeActionBlock)(NSInteger idx);
@property (nonatomic, copy)void (^riseActionBlock)(NSInteger idx);
@property (nonatomic, copy)void (^dropActionBlock)(NSInteger idx);
@end
