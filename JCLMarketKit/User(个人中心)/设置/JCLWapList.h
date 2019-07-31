//
//  JCLWapList.h
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLKitList.h"

@interface JCLWapList : JCLKitList
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, copy) void (^popActionBlock)();
@end

