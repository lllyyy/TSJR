//
//  JCLUserSession.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/18.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCLUserSession : NSObject
+ (void)setDoctor:(JCLUserModel *)user;
+ (JCLUserModel *)getUser;
+ (void)removeUser;

 
+ (void)setPassWord:(NSString *)passWord ;
+ (NSString *)getPassWord;
+ (NSString *)getRPCToken;
+ (void)setRPCToken:(NSString *)token;
+ (NSString *)getPhoneNum;
+ (void)setPhoneNum:(NSString *)phone;
+ (void)setTel:(NSString *)tel;
+ (NSString *)getTel;
+ (NSString *)getintro ;
+ (NSString *)getname;
+ (void)setname:(NSString *)name;

+ (void)setintro:(NSString *)intro;
+ (void)setDB:(NSString *)DB;
+ (NSString *)getDB;
+ (void)setCurrentAccount:(NSString *)currentAccount;
+ (NSString *)getCurrentAccount;
+ (NSString *)getAvatar;
+ (void)setAvatar:(NSString *)avatar;

@end
extern JCLUserModel* user(void);

extern NSString* userId(void);
extern NSString* name(void);
extern NSString* avatar(void);
extern NSString* phone(void);
extern NSString* intro(void);
 

NS_ASSUME_NONNULL_END
