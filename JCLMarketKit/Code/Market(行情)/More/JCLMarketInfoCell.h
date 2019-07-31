//
//  RangeMoreTableCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/11/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLMarketInfoCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *code;

@property (nonatomic, weak) UIScrollView *scroll;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, copy) void (^actionBlock)();
@end
