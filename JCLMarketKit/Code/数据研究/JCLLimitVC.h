//
//  JCLLimitVC.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/30.
//  Copyright © 2017年 刘虎超. All rights reserved.
//  涨停抓妖

#import "JCLBaseVC.h"
typedef void(^LimitBlock)(NSArray *array);
@interface JCLLimitVC : JCLBaseVC
@property (nonatomic,copy) LimitBlock action;
- (void)loadData;
@end
