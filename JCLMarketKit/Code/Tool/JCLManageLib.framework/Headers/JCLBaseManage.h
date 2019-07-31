//
//  RXPath.h
//  Jincelue
//
//  Created by 邢昭俊 on 2017/1/16.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JCLBaseManage : NSObject
#pragma mark - UIKit
+(UIView *)JCLView:(UIView *)parent color:(UIColor *)color;
+(UILabel *)JCLLable:(UIView *)parent font:(NSInteger)font color:(UIColor *)color alignment:(NSInteger)alignment;
+(UIImageView *)JCLImage:(UIView *)parent;
+(UIImage *)JCLResizeImg:(NSString *)str;

+(UITextView *)JCLText:(UIView *)parent font:(NSInteger)font color:(UIColor *)color;
+(UIButton *)JCLButton:(UIView *)parent img:(NSString *)img size:(CGFloat)size target:(id)target action:(SEL)action;

#pragma mark - JCLSetup
+(UIFont *)JCLSetupFont:(CGFloat)size;
+(NSString *)JCLBundle:(NSString *)str;

#pragma mark ---- UIGestureRecognizer
+ (UIPinchGestureRecognizer *)RXPinch:(UIView *)parentView target:(id)target action:(SEL)action;
+ (UIPanGestureRecognizer *)RXPan:(UIView *)parentView target:(id)target action:(SEL)action;
+ (UILongPressGestureRecognizer *)RXLongPress:(UIView *)parentView target:(id)target action:(SEL)action;
+ (UITapGestureRecognizer *)RXTap:(UIView *)parent target:(id)target action:(SEL)action number:(NSUInteger)number;

#pragma mark - NSMutableAttributedString
+(NSString *)JCLStr:(NSString *)str; +(NSString *)JCLInt:(NSString *)str; +(NSString *)JCLDou:(NSString *)str type:(NSInteger)type;
//间隔
+(NSMutableAttributedString *)RXAttStr:(NSString *)str spac:(NSUInteger)spac;
+(NSMutableAttributedString *)RXAttStr:(NSString *)str color:(UIColor *)color beginIdx:(NSInteger)idx;
+(NSMutableAttributedString *)RXAttStr:(NSString *)str color:(UIColor *)color endIdx:(NSInteger)idx;
+(NSMutableAttributedString *)RXAttStr:(NSString *)str icon:(NSString *)icon y:(CGFloat)y wh:(CGFloat)wh idx:(NSUInteger)idx;
+(CGSize)JCLSize:(NSString *)str spac:(CGFloat)spac font:(CGFloat)font width:(CGFloat)width;
+(CGSize)JCLTextSize:(NSString *)value font:(UIFont *)font width:(float)width;
+(CGSize)JCLAttTextSize:(NSAttributedString *)value size:(float)size width:(float)width;
+(CGFloat)JCLArrStrH:(NSString *)str spac:(CGFloat)spac font:(CGFloat)font width:(CGFloat)width;

#pragma mark - NSDateFormatter
+(NSString *)JCLDate;
+(NSString *)JCLDate:(NSString *)str style:(NSString *)style;
+(NSString *)JCLDate:(NSString *)begin end:(NSString *)end;
+(NSInteger)JCLDay:(NSInteger)year month:(NSInteger)month;

#pragma mark - CAShapeLayer
+(CAShapeLayer *)JCLFilletLayer:(CGFloat)radius width:(CGFloat)width color:(UIColor *)color;
+(CAShapeLayer *)RXLinePath:(UIView *)parent arr:(NSArray *)arr strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor;
+(CAShapeLayer *)RXArcCenterPath:(UIView *)parent strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor;
+(CGPoint)setupAngle:(UIView *)parent angle:(CGFloat)angle radius:(CGFloat)radius;
@end
