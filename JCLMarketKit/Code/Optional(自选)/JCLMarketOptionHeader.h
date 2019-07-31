//
//  JCLMarketOptionHeader.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLMarketOptionHeader : UIView
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, copy) void (^menuActionBlock)(UILabel *idx, NSInteger sortIdx);
@property (nonatomic, assign) BOOL isAction;
@property (nonatomic, assign) UILabel *obj;
-(NSAttributedString *)getAttStr:(UILabel *)obj img:img;
@end
