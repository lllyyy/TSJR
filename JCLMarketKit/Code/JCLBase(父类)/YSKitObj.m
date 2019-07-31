//
//  YSKitObj.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/31.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "YSKitObj.h"

#define YSRandomRGB JCLRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.0)

@implementation YSKitObj
+(NSInteger )YSFont:(CGFloat)size{
    NSString *font = PreRead(YSFONT);
    if ([font isEqualToString:@"1"]) {
        return size + 2;
    } else if ([font isEqualToString:@"1"]) {
        return size + 4;
    } else {
        return size;
    }
}

+(UILabel *)YSLable:(UIView *)parent size:(NSInteger)size color:(UIColor *)color alignment:(NSInteger)alignment style:(NSInteger)style{
    UILabel *lable = [JCLKitObj JCLLable:parent font:size color:color alignment:alignment];
    NSString *title = style == 0 ? @"DINPro-Medium" : @"DINPRO-REGULAR";
    lable.font = [UIFont fontWithName:title size:[JCLKitObj JCLSize:size]];
    return lable;
}

+(NSMutableAttributedString *)YSStrM:(NSString *)key val:(NSString *)val color:(UIColor *)color{
    NSString *after = [NSString stringWithFormat:@"%@", val];
    NSString *before = [NSString stringWithFormat:@"%@%@", key, after];
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:before];
    [strM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DINPro-Medium" size:[JCLKitObj JCLSize:13]] range:[before rangeOfString:after]];
    [strM addAttribute:NSForegroundColorAttributeName value:color range:[before rangeOfString:after]];
    return strM;
}
@end
