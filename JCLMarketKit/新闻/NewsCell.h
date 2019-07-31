//
//  NewsCell.h
//  JCLMarketKit
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSJRNewModel.h"
@interface NewsCell : UITableViewCell
+(instancetype)CellWithTableView:(UITableView *)tableView;
//标题
@property (nonatomic,strong) UILabel *titleLab;
//时间

@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UIImageView *pic;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *titleLB;

-(void)setData:(TSJRNewModel *)m;
@end
