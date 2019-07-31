//
//  JCLStockMoreCell.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/5/11.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//  公告 研报下面加载更多

#import "JCLStockMoreCell.h"

@implementation JCLStockMoreCell

+(instancetype)CellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"StockMoreCell111";
    JCLStockMoreCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell=[[JCLStockMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Cell_COL;
        self.textLab= [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1]; self.textLab.text = @"加载更多";
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLab.frame=CGRectMake(0, 0, self.width, self.height);
}
@end
