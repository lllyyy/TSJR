//
//  UserManager.m
//  交易
//
//  Created by apple on 2016/11/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+(instancetype)shareUser{
    static UserManager *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[UserManager alloc]init];
  });
    return user;
}

-(void)loginWithUser
{
     NSDictionary  * accountInfo = [[NSUserDefaults standardUserDefaults]objectForKey:@"GY_USER"];
    _Client_id=accountInfo[@"UserName"];
    _phone=accountInfo[@"phone"];
    _name=accountInfo[@"ucname"];
    _isLogin=[accountInfo[@"isLogin"] integerValue];
    _iconimage=accountInfo[@"header"];
    _openid=accountInfo[@"Open"];
    _registfrom=accountInfo[@"Regist"];
}
@end
