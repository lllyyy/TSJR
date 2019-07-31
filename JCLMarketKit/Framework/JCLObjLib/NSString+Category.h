//
//  NSString+RuiXue.h
//  RuiXueTuan
//
//  Created by 邢昭俊 on 14-6-14.
//  Copyright (c) 2014年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
// emoji处理
+ (NSString *)emojiWithIntCode:(int)intCode; // 将十六进制的编码转为emoji字符
+ (NSString *)emojiWithStringCode:(NSString *)stringCode; // 将十六进制的编码转为emoji字符
- (BOOL)isEmoji; // 是否为emoji字符

-(CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

// 是否是正确的用户名
- (BOOL)isUsers;

// 是否是正确的手机号
- (BOOL)isPhone;
- (BOOL)isPassword;

// 是否是正确的邀请码
- (BOOL)isInvitationCode;

// 是否是正确的身份证号
- (BOOL)isIdentityCode;
    
/**
 *  是否是纯数字文本(小数也可以)
 */
- (BOOL)matchNumber;

/**
 *  是否是正确的邮箱
 */
- (BOOL)matchEmail;

/**
 *  是否是正确的身份证号
 */
- (BOOL)matchIdentityCard;

/**
 *  是否是正确的车牌号
 */
- (BOOL)matchCarNumber;
@end
