//
//  JCLTableInfo.h
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "YSTableList.h"

@interface JCLTableInfo : YSTableList
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *texts;
@property (nonatomic, strong) UIImage *phone;
@property (nonatomic, strong) NSString *img;

-(void)showPhoneAction;
@end
