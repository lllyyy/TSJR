//
//  JCLUserData.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JCLUser @"user.data"

@interface JCLUserData : NSObject
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *intro; // 简介
@property (nonatomic, copy) NSString *avatar; // 头像
@property (nonatomic, copy) NSString *phone; // 账号
@property (nonatomic, copy) NSString *name; // 账号

@property (nonatomic, copy) NSString *username; // 账号
@property (nonatomic, copy) NSString *password; // 密码
@property (nonatomic, copy) NSString *online;


@property (nonatomic, copy) NSString *profile; // 简介
@property (nonatomic, copy) NSString *truename;

@property (nonatomic, copy) NSString *khdate;
@property (nonatomic, copy) NSString *delFlag;
@property (nonatomic, copy) NSString *lastLoginTime;
@property (nonatomic, copy) NSString *localSource;
@property (nonatomic, copy) NSString *loginCount;
@property (nonatomic, copy) NSString *offlineTime;

@property (nonatomic, copy) NSString *phoneType;
@property (nonatomic, copy) NSString *regTime;
@property (nonatomic, copy) NSString *userInfoId;
@property (nonatomic, copy) NSString *utsdbmask;

@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *userInfo;
@property (nonatomic, copy) NSString *town;

@property (nonatomic, copy) NSString *sdkAppId; // 用户标识接入SDK的应用ID
@property (nonatomic, copy) NSString *accountType; // 用户的账号类型
@property (nonatomic, copy) NSString *friendId; // 好友ID

+(void)saveUserInfo:(JCLUserData *)model;
+(JCLUserData *)getUserInfo;
@end


