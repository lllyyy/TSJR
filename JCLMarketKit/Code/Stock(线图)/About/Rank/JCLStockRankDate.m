//
//  JCLStockRankDate.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/18.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockRankDate.h"
#import "JCLStockRankDateCell.h"

@interface JCLStockRankDate()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation JCLStockRankDate
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.table = [JCLKitObj JCLTable:self target:self frame:self.bounds style:UITableViewStylePlain];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count; }
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLStockRankDateCell *cell = [JCLStockRankDateCell cellWithTable:tableView style:UITableViewCellStyleDefault];
    if ([self.arr[indexPath.row] isEqualToString:self.date]) {
        cell.bg.backgroundColor = JCLBGRGB;
        cell.icon.img = @"xuanzhong";
    } else {
        cell.bg.backgroundColor = [UIColor whiteColor];
        cell.icon.img = @"";
    }
    cell.time.text = self.arr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ return 60; }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    !self.actionBlock ? : self.actionBlock(indexPath.row);
}
@end
