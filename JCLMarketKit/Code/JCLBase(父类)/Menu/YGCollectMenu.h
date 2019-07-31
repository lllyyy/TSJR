//
//  YGCollectMenu.h
//  NongGe_iOS
//
//  Created by 邢昭俊 on 2017/6/25.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGCollectMenu : UIView
@property (nonatomic, weak) UICollectionView *collect;
@property(nonatomic, strong) NSArray *arr;
@property (nonatomic, assign) BOOL isSever;
@property (nonatomic, copy) void (^selectActionBlock)(NSDictionary *dic);
@end
