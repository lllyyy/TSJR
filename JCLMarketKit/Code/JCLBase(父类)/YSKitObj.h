//
//  YSKitObj.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/31.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YSFONT @"CurrencyFont"

@interface YSKitObj : NSObject
@property (strong, nonatomic) UIWindow *window;
+(NSInteger )YSFont:(CGFloat)size;
+(UILabel *)YSLable:(UIView *)parent size:(NSInteger)size color:(UIColor *)color alignment:(NSInteger)alignment style:(NSInteger)style;
+(NSMutableAttributedString *)YSStrM:(NSString *)key val:(NSString *)val color:(UIColor *)color;
@end
