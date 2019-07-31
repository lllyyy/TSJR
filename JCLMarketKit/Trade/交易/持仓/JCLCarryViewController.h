//
//  JCLCarryViewController.h
//  JCLFutures
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSTableList.h"
NS_ASSUME_NONNULL_BEGIN

@interface JCLCarryViewController : YSTableList
@property(nonatomic,copy)void(^block)(NSString *code,NSDictionary *obj);
@property(nonatomic,assign)CGFloat listHeight;
-(void)reloadData:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
