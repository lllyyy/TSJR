//
//  JCLStockRankDate.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/18.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTablePop.h"
#import "JCLTablePopCell.h"

@interface JCLTablePop()
@end

@implementation JCLTablePop
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.table = [JCLKitObj JCLTable:self target:self frame:self.bounds style:UITableViewStylePlain];
    self.table.backgroundColor = JCL_Bg_COL;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return self.arr.count; }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return [JCLKitObj JCLHeight:44]; }
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLTablePopCell *cell = [JCLTablePopCell cellWithTable:tableView style:UITableViewCellStyleDefault];
//    if ([self.arr[indexPath.row] isEqualToString:self.date]) {
//        cell.icon.img = @"xuanzhong";
//    } else {
//        cell.icon.img = @"";
//    }
    cell.icon.title = @"删除";
    [cell.icon tapActionBlock:^{
        !self.cellActionBlock ? : self.cellActionBlock(indexPath.row);
    }];
    cell.time.text = self.arr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    !self.actionBlock ? : self.actionBlock(indexPath.row);
}
@end
