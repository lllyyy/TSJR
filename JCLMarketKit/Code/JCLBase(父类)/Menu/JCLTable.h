//
//  JCLTable.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/4.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLTable : UIView
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, copy) void (^actionBlock)(NSInteger idx);
@end
