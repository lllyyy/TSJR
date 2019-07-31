//
//  JCLUserSession.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/18.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLUserSession.h"

@implementation JCLUserSession
+ (void)setDoctor:(JCLUserModel *)user {
    
    [[YYCache sharedCache] setObject:user forKey:@"UserCacheKey"];
}

+ (JCLUserModel *)getUser {
    
    return (JCLUserModel *) [[YYCache sharedCache] objectForKey:@"UserCacheKey"];
}




+ (void)setTel:(NSString *)tel {
    
    [[YYCache sharedCache] setObject:tel forKey:@"tel"];
}

+ (NSString *)getTel {
    
    return (NSString *)[[YYCache sharedCache] objectForKey:@"tel"];
}

+ (void)removeUser {
    [[YYCache sharedCache] removeObjectForKey:@"UserCacheKey"];
}
//////
 
+ (NSString *)getintro {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"intro"];
}

+ (void)setintro:(NSString *)intro {
    [[NSUserDefaults standardUserDefaults] setObject:intro forKey:@"intro"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getname {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
}
+ (void)setname:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getAvatar{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];
}
+ (void)setAvatar:(NSString *)avatar {
    [[NSUserDefaults standardUserDefaults] setObject:avatar forKey:@"avatar"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



+ (NSString *)getPassWord {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"PassWord"];
}

+ (void)setPassWord:(NSString *)passWord {
    [[NSUserDefaults standardUserDefaults] setObject:passWord forKey:@"PassWord"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getPhoneNum {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
}

+ (void)setPhoneNum:(NSString *)phone {
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setDB:(NSString *)DB{
    [[NSUserDefaults standardUserDefaults] setObject:DB forKey:@"DB"];
    [[NSUserDefaults standardUserDefaults] synchronize];
};

+ (NSString *)getDB{
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"DB"];
};

+ (void)setCurrentAccount:(NSString *)currentAccount{
    [[NSUserDefaults standardUserDefaults] setObject:currentAccount forKey:@"currentAccount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
};

+ (NSString *)getCurrentAccount{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"currentAccount"];
};

@end


extern JCLUserModel* user() {
    
    return [JCLUserSession getUser];
}

extern NSString *userId() {
    if ([JCLUserSession getUser]  == nil) {
        return @"";
    }
    return [[JCLUserSession getUser] uId];
}

extern NSString* name() {
    if ([JCLUserSession getUser]  == nil) {
        return @"";
    }
    return [[JCLUserSession getUser] uName];
}

extern NSString* avatar() {
    if ([JCLUserSession getUser]  == nil) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@/%@",avatarURL,[[JCLUserSession getUser] uAvatar ]];
}

extern NSString* phone() {
    if ([JCLUserSession getUser]  == nil) {
        return @"";
    }
    return [[JCLUserSession getUser] uPhone];
}

extern NSString* intro() {
    if ([JCLUserSession getUser]  == nil) {
        return @"";
    }
    return [[JCLUserSession getUser] uIntro];
}
//
//extern NSString* technicalName() {
//    if ([JCLUserSession getDoctor]  == nil) {
//        return @"";
//    }
//    return [[JCLUserSession getDoctor] dTechnicalName];
//}
//
//extern NSString* department() {
//    if ([JCLUserSession getDoctor]  == nil) {
//        return @"";
//    }
//    return [[JCLUserSession getDoctor] dDepartment];
//}
//
//extern NSString* goodAt() {
//    if ([JCLUserSession getDoctor]  == nil) {
//        return @"";
//    }
//    return [[JCLUserSession getDoctor] dGoodAt];
//}
//
//extern NSString* descr() {
//    if ([JCLUserSession getDoctor]  == nil) {
//        return @"";
//    }
//    return [[JCLUserSession getDoctor] dDesc];
//}
//
//extern NSString* isAuth() {
//    if ([JCLUserSession getDoctor]  == nil) {
//        return @"";
//    }
//    return [[JCLUserSession getDoctor] dIsAuth];
//}
// 
