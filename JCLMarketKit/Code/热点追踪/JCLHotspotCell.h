//
//  JCLHotspot.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/23.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLHotspotCell : UITableViewCell
+ (instancetype)CellWithTableView:(UITableView *)tableView;
//板块名字
@property (nonatomic,strong) UILabel *nameLab;
//板块涨跌幅
@property (nonatomic,strong) UILabel *rangeLab;
//个股名字
@property (nonatomic,strong) UILabel *stocknameLab;
//个股涨跌幅
@property (nonatomic,strong) UILabel *stockrangelLab;
//对应模型
@property (nonatomic,strong) NSArray *array;
//涨模块颜色
@property (nonatomic,strong) UILabel *riseLab;
//平
@property (nonatomic,strong) UILabel *flatLab;
//跌
@property (nonatomic,strong) UILabel *fallLab;
@end
