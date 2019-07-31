//
//  JCLTableCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/4.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLTableCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;
@property (nonatomic, strong) UILabel *title;
@end
