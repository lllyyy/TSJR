//
//  JCLLoginList.h
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTableInfo.h"

@interface JCLUserLoginList : JCLTableInfo
@property (nonatomic, assign) BOOL isMain;
@property (nonatomic, copy) void (^popActionBlock)();
@end
