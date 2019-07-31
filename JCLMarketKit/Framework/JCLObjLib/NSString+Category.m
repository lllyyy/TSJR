//
//  NSString+RuiXue.m
//  RuiXueTuan
//
//  Created by 邢昭俊 on 14-6-14.
//  Copyright (c) 2014年 邢昭俊. All rights reserved.
//

#import "NSString+Category.h"


@implementation NSString (RuiXue)
-(CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize{
    return [NSString sizeWithText:self andFont:font andMaxSize:maxSize];
}

+(CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize{
    NSDictionary *attr = @{NSFontAttributeName: font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size ;
}

// 是否是正确的用户名
- (BOOL)isUsers{
    return [[self isRegular:@"^[A-Za-z0-9\u4E00-\u9FA5_-]+$"] evaluateWithObject:self];
    return [[self isRegular:@"^@A-Za-z0-9!#$%^&*.~$"] evaluateWithObject:self];
}

// 是否是正确的手机号
- (BOOL)isPhone{
    return [[self isRegular:@"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$"] evaluateWithObject:self];
}
// 是否是正确的密码
- (BOOL)isPassword{
    NSPredicate *predicate = [self isRegular:@"([0-9](?=[0-9]*?[a-zA-Z])\\w{5})|([a-zA-Z](?=[a-zA-Z]*?[0-9])\\w{5})"];
    return [predicate evaluateWithObject:self];
}
// 是否是正确的邮箱
- (BOOL)matchEmail{
    NSPredicate *predicate = [self isRegular:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
    return [predicate evaluateWithObject:self];
}

// 是否是正确的邀请码
- (BOOL)isInvitationCode{
    NSPredicate *predicate = [self isRegular:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
    return [predicate evaluateWithObject:self];
}

// 是否是正确的身份证号
- (BOOL)isIdentityCode{
    NSPredicate *predicate = [self isRegular:@"^(\\d{14}|\\d{17})(\\d|[xX])$"];
    return [predicate evaluateWithObject:self];
}

// 是否是正确的车牌号
- (BOOL)matchCarNumber{
    NSPredicate *predicate = [self isRegular:@"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$"];
    return [predicate evaluateWithObject:self];
}

-(NSPredicate *)isRegular:(NSString *)string{
    NSString *regular = string;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regular];
    return predicate;
}
@end
