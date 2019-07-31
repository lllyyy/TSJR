//
//  JCLLimitCell.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/4/5.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLLimitCell : UITableViewCell
+ (instancetype)CellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) UILabel *codeLab;
@property (nonatomic,strong) UILabel *nameLab;
//考虑重用所以取名label1、2
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UIView  *line;
@end
