//
//  MMBirthDatePopuView.h
//  Doctor
//
//  Created by 卢杨 on 17/3月/3.
//  Copyright © 2017年 com.cti. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBlock)(NSString *v);
 
@interface TSJRTradingPopuView : UIView
@property (nonatomic, strong) NSArray *dataArray;

@property(nonatomic, strong) UITableView * tableView;
 @property (nonatomic, weak) UIViewController *parentVC;
@property (nonatomic,copy) SelectBlock selectBlock;
 
-(instancetype)initWithFrame:(CGRect)frame selectValue:(NSString *)selectValue;
+ (instancetype)defaultPopupView;
@end
