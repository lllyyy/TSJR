//
//  JCLBillboardTableViewCell.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/7.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLBillboardTableViewCell : UITableViewCell
//股票名
@property(nonatomic,strong)UILabel *stockNameLab;
//股票代码
@property(nonatomic,strong)UILabel *stockCodeLab;
//涨幅
@property(nonatomic,strong)UILabel *roseLab;
//净买入额
@property(nonatomic,strong)UILabel *moneyLab;
@property(nonatomic,strong) UIView *line;
//初始化Cell自定义方法
+ (instancetype)CellWithTableView:(UITableView *)tableView;
@end

@interface JCLBillboardRank : UITableViewCell
//初始化Cell自定义方法
+ (instancetype)CellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *numberLab;
@property(nonatomic,strong)UIView  *line;
@end
