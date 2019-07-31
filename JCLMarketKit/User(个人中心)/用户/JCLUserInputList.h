//
//  JCLInputList.h
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "YSTableList.h"

@interface JCLUserInputList : YSTableList
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) BOOL isMore;
@property (nonatomic, copy) void (^popActionBlock)(NSString *val);
@end
 

