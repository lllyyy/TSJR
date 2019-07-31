//
//  JCLIdxMenu.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/6/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLIdxMenu : UIView
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, copy) void (^actionBlock)(NSInteger idx);
@end
