//
//  UserManager.h
//  交易
//
//  Created by apple on 2016/11/10.
//  Copyright © 2016年 apple. All rights reserved.

#import <Foundation/Foundation.h>

@interface UserManager : NSObject
@property (nonatomic,copy) NSString *Client_id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *iconimage;
@property(nonatomic,strong)NSString *openid;
@property(nonatomic,strong)NSString *registfrom;
@property(nonatomic)BOOL isLogin;
+(instancetype)shareUser;
-(void)loginWithUser;
@end
