//
//  JCLStockRankDate.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/18.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLTablePop : UIView
@property(nonatomic, weak) UITableView *table;
@property(nonatomic, strong)NSArray *arr;
@property(nonatomic, strong)NSString *date;
@property(nonatomic, copy)void (^actionBlock)(NSInteger idx);
@property(nonatomic, copy)void (^cellActionBlock)(NSInteger idx);

@end
