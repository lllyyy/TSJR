//
//  YSTableList.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/1.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLKitList.h"
#import "UITableView+Base.h"

@interface YSTableList : JCLKitList
@property (nonatomic, weak) UITableView *table;
@property (nonatomic, strong) NSMutableArray *arrM;
@property (nonatomic, strong) NSMutableArray *vals;
@property (nonatomic, strong) NSTimer *timer;
@end
