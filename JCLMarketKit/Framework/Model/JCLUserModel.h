//
//  JCLUserModel.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/18.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "MMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JCLUserModel : MMBaseModel
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *intro; // 简介
@property (nonatomic, copy) NSString *avatar; // 头像
@property (nonatomic, copy) NSString *phone; // 账号
@property (nonatomic, copy) NSString *name; // 姓名
@property (nonatomic, copy) NSString *email; // 姓名
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *currentAccount;//模拟账户0正式1
- (NSString *) uIntro ;
- (NSString *) uPhone;
- (NSString *) uAvatar;
- (NSString *) uName;
- (NSString *) uId ;
- (NSString *) uAccount;
- (NSString *) uCurrentAccount;
@end

NS_ASSUME_NONNULL_END
