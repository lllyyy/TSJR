//
//  JCLDataCell.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/30.
//  Copyright © 2017年 刘虎超. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface JCLDataCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *code;

@property (nonatomic, weak) UIScrollView *scroll;
@property (nonatomic,strong) NSArray <UIColor *> *colorArr;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, copy) void (^actionBlock)();
@end
