//
//  JCLStockRankInfo.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/18.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockRankInfo : UIView
@property(nonatomic, strong) NSArray *arr;
@property(nonatomic, copy) void (^tapAction)(NSInteger idx);
@end
