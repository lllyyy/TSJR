//
//  RXPath.h
//  Jincelue
//
//  Created by 邢昭俊 on 2017/1/16.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define JCLHexCol(color) [JCLKitObj JCLHexCol:color]

@interface JCLKitObj : NSObject
+(UIColor *)JCLHexCol:(NSString *)color;
+(UIImage *)JCLImgCol:(UIColor *)col;

#pragma mark - UIKit
+(UIView *)JCLView:(UIView *)parent color:(UIColor *)color;
+(UIView *)RXView:(UIView *)parent color:(UIColor *)color;
+(UIView *)JCLView:(UIView *)parent color:(UIColor *)color target:(id)target action:(SEL)action;
+(UILabel *)JCLLable:(UIView *)parent font:(NSInteger)font color:(UIColor *)color alignment:(NSInteger)alignment;
+(UIImageView *)JCLImage:(UIView *)parent;

+(UITextField *)JCLField:(UIView *)parent font:(CGFloat)font color:(UIColor *)color delegate:(id)delegate;
+(UITextView *)JCLText:(UIView *)parent font:(NSInteger)font color:(UIColor *)color;
+(UIButton *)JCLButton:(UIView *)parent img:(NSString *)img size:(CGFloat)size target:(id)target action:(SEL)action;

+(UIScrollView *)JCLScroll:(UIView *)parentView page:(BOOL)page delegate:(id)delegate;
+(UIPageControl *)JCLPage:(UIView *)parent color:(UIColor *)color current:(UIColor *)current;
+(UITableView *)JCLTable:(UIView *)parent target:(id)target frame:(CGRect)frame style:(UITableViewStyle)style;

// 多组
+(UICollectionView *)JCLCollect:(UIView *)parent target:(id)target frame:(CGRect)frame style:(NSInteger)style;
// 单组
+(UICollectionView *)JCLCollect:(UIView *)parent target:(id)target frame:(CGRect)frame cell:(Class)cell ident:(NSString *)ident style:(NSInteger)style;

#pragma mark - JCLSetup
+(CGFloat)JCLSize:(CGFloat)size;
+(UIFont *)JCLFont:(CGFloat)size;
+(CGFloat)JCLHeight:(CGFloat)height;
+(NSString *)JCLBundle:(NSString *)str;

+(NSArray *)JCLRemoveKit:(NSMutableArray *)arrM;
+(NSArray *)JCLRemoveLayer:(NSMutableArray *)arrM;

#pragma mark ---- UIGestureRecognizer
+ (UIPinchGestureRecognizer *)RXPinch:(UIView *)parentView target:(id)target action:(SEL)action;
+ (UIPanGestureRecognizer *)RXPan:(UIView *)parentView target:(id)target action:(SEL)action;
+ (UILongPressGestureRecognizer *)RXLongPress:(UIView *)parentView target:(id)target action:(SEL)action;
+ (UITapGestureRecognizer *)RXTap:(UIView *)parent target:(id)target action:(SEL)action number:(NSUInteger)number;

#pragma mark - NSMutableAttributedString
+(NSString *)JCLStr:(NSString *)str;
+(NSString *)JCLInt:(NSString *)str;
+(NSString *)JCLDou:(NSString *)str type:(NSInteger)type;
+(CGSize)JCLStrSize:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
+(CGSize)JCLStrSize:(NSString *)text font:(UIFont *)font;
+(NSMutableAttributedString *)RXAttStr:(NSString *)str spac:(NSUInteger)spac;
+(NSMutableAttributedString *)RXAttStr:(NSString *)str color:(UIColor *)color beginIdx:(NSInteger)idx;
+(NSMutableAttributedString *)RXAttStr:(NSString *)str color:(UIColor *)color endIdx:(NSInteger)idx;
+(NSMutableAttributedString *)RXAttStr:(NSString *)str icon:(NSString *)icon y:(CGFloat)y wh:(CGFloat)wh idx:(NSUInteger)idx;

+(CGSize)JCLTextSize:(NSString *)str font:(UIFont *)font;
+(CGSize)JCLTextSize:(NSString *)str spac:(CGFloat)spac font:(UIFont *)font width:(CGFloat)width;
+(CGSize)JCLTextSize:(NSString *)val font:(UIFont *)font width:(float)width;
+(CGSize)JCLAttTextSize:(NSAttributedString *)val font:(UIFont *)font width:(float)width;
+(CGFloat)JCLArrStrH:(NSString *)str spac:(CGFloat)spac font:(CGFloat)font width:(CGFloat)width;

#pragma mark - NSDateFormatter
+(NSString *)JCLDate;
+(NSString *)JCLDate:(NSString *)str style:(NSString *)style;
+(NSString *)JCLDate:(NSString *)begin end:(NSString *)end;
+(NSInteger)JCLDay:(NSInteger)year month:(NSInteger)month;


//分享
+ (void)configUSharePlatforms:(NSString *)url
                           vc:(UIViewController *)vc
                        title:(NSString *)title
                         desc:(NSString *)desc;
//随机数code
+ (NSString *)createRand6;
//
+(void)showMsg:(NSString *)msg;

//x验证空格
+(NSString *)stringByTrimmingCharactersInSet:(NSString *)str ;

+(UINavigationController *)rootNav;
+(UIViewController *)rootVC;

+(NSString *)countNumAndChangeformat:(NSString *)num;
+(NSString *)moneyFormat:(NSString *)money;
+(NSString *)timeStampString:(NSString *)timeStampString;
+(NSDate *)timeStampStringIn:(NSString *)timeStampString;
+(NSString *)orderType:(NSString *)orderType;
+(NSString *)actionType:(NSString *)actionType;
+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString;
+ (NSString *) createHTMLFile2:(NSString *)value;
@end
