//
//  JCLUserData.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserData.h"


@implementation JCLUserData
-(void)encodeWithCoder:(NSCoder *)coder{ [self encodeWithObject:self class:[self class] coder:coder]; }
-(id)initWithCoder:(NSCoder *)coder{
    if (self = [super init]) { [self decodeWithObject:self class:[self class] coder:coder]; } return self;
}

-(void)encodeWithObject:(NSObject *)obj class:(Class)class coder:(NSCoder *)coder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([class class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        [coder encodeObject:[obj valueForKeyPath:key] forKey:key];
    }
}

-(void)decodeWithObject:(NSObject *)obj class:(Class)class coder:(NSCoder *)coder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([class class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        [obj setValue:[coder decodeObjectForKey:key] forKey:key];
    }
}

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    JCLUserData *account = [[self alloc] init]; [account setValuesForKeysWithDictionary:dict];
    return account;
}

+(void)saveUserInfo:(JCLUserData *)model{
    [NSKeyedArchiver archiveRootObject:model toFile:CachesFile(JCLUser)]; }
+(JCLUserData *)getUserInfo{
    JCLUserData *info = [NSKeyedUnarchiver unarchiveObjectWithFile:CachesFile(JCLUser)];
    return info;
}
@end
