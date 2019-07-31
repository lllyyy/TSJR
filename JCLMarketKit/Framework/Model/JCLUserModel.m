//
//  JCLUserModel.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/18.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLUserModel.h"

@implementation JCLUserModel


- (NSString *) uId {
    if (self.userId != nil) {
        return self.userId;
    }
    return @"";
}

- (NSString *) uName {
    if (self.name != nil) {
        return self.name;
    }
    return @"";
}

- (NSString *) uAvatar {
    if (self.avatar != nil) {
        return self.avatar;
    }
    return @"";
}

- (NSString *) uPhone {
    if (self.phone   != nil) {
        return self.phone ;
    }
    return @"";
}
- (NSString *) uIntro {
    if (self.intro   != nil) {
        return self.intro ;
    }
    return @"";
}
- (NSString *) uAccount {
    if (self.account   != nil) {
        return self.account ;
    }
    return @"";
}
- (NSString *) uCurrentAccount {
    if (self.currentAccount   != nil) {
        return self.currentAccount ;
    }
    return @"";
}
@end
