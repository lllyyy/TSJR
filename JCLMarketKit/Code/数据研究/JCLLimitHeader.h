//
//  JCLLimitHeader.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/5.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HeaderAction)(NSInteger idx);
typedef void (^SortAction) (NSInteger idx);
typedef void (^TopAction)(NSInteger idx);

@interface JCLLimitHeader : UIView
@property (nonatomic,strong) NSArray      *titleArr;
@property (nonatomic,copy  ) HeaderAction action;
@property (nonatomic,copy  ) SortAction   sortaction;
@property (nonatomic,strong) UIButton     *selectBtn;

@property (nonatomic,strong) NSArray      *numberArr;
@property (nonatomic,strong) NSArray      *dataArr;
@property (nonatomic,copy  ) TopAction    topaction;
@end
