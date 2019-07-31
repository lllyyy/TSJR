//
//  LHCObject.h
//  常用类的封装
//
//  Created by 刘虎超 on 2017/2/15.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LHCObject : NSObject
@property (nonatomic, strong) NSTimer *timer;
#pragma mark ---- CGSize
+ (CGFloat)LHCFont:(CGFloat)size;
+ (CGSize)LHCSize:(NSString *)text font:(CGFloat)fontSize;
+ (CGSize)LHCSize:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
+ (CGFloat)height:(CGFloat)height;

#pragma mark ---- UIKit
+ (UITableView *)LHCTable:(UIView *)parentView target:(id)target frame:(CGRect)frame style:(UITableViewStyle)style;

+ (UIButton *)LHCButton:(UIView *)parentView  Img:(NSString *)img  Title:(NSString *)title   backgroundColor:(UIColor *)backgroundColor Target:(id)target Action:(SEL)action ;

+ (UITextField *)LHCField:(UIView *)parnetView   BorderColor:(UIColor *)color BorderWidth:(CGFloat)width  Placeholder:(NSString *)placeholder;

+ (UILabel *)LHCLable:(UIView *)parentView  size:(CGFloat)size Textcolor:(UIColor *)color alignment:(NSInteger)alignment text:(NSString *)text;

+ (UIImageView *)LHCImage:(UIView *)parnetView  Image:(NSString *)image;

+ (UIView *)LHCView:(UIView *)parnetView backgroundColor:(UIColor *)backgroundColor;


#pragma mark ---- UIAlertView
+(void)setupAlert:(NSString *)message;

#pragma mark ---- UIColor
+ (UIImage *)getImageColor:(UIColor *)color;
+ (UIColor *)getHexColor:(NSString *)value alpha:(CGFloat)alpha;
+ (UIColor *)getBackgroundColor:(CGFloat)alpha;
+ (UIColor *)getRandomColor:(CGFloat)alpha;
+ (UIColor *)getRGBColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b alpha:(CGFloat)alpha;

#pragma mark ---- Base64
+(NSString *)base64FromJson:(NSMutableDictionary *)dicM;
//格式化时间
+(NSString *)FormatTimeString:(NSString *)timeStr;
//格式化日期
+(NSString *)FormatDateString:(NSString *)DateStr;
//裁剪字符串
+ (NSString *)FormCutString:(NSString *)string Start:(NSInteger)start Len:(NSInteger)Len;
#pragma mark ---- 富文本
+ (NSMutableAttributedString *)LHCattributedStr:(NSString *)str Range:(NSRange)range Color:(UIColor *)color FontSize:(CGFloat)fontSize;
#pragma mark ---- 手势
+(UITapGestureRecognizer *)LHCRecognizerTarget:(id)target Action:(SEL)action Num:(NSInteger)num;

#pragma mark 手机号正则表达式
+ (BOOL)validatePhone:(NSString *)phone;
//第一个和第二个比  大就返回红色
+ (UIColor *)Newprice:(NSString *)Newprice Price:(NSString *)price;
//模拟交易用到的
+ (UILabel *)LHCLable:(UIView *)parentView text:(NSString *)text size:(CGFloat)size Textcolor:(UIColor *)color alignment:(NSInteger)alignment;

+ (UIView *)LHCView:(UIView *)parnetView frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

+(NSMutableArray *)JCLSZStockInfo:(NSString *)code type:(NSString *)type;

+(BOOL)testzs:(NSString *)codeStr; // 检测是否是指数

+ (id)loadMarketcode:(NSString *)code;
+ (int)second;

+ (NSString *)NewDateFormat:(NSString *)format;

+ (NSString*)UTF8_To_GB2312:(NSString*)utf8string;

//行内间距富文本
+(NSMutableAttributedString *)LHCAttStr:(NSString *)str spac:(NSUInteger)spac;
//过滤非法字符串
+ (NSString *)filterStr:(NSString *)str;

+(NSString *)filterHTML:(NSString *)html;
@end
