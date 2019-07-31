//
//  JCLTable.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/11/4.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import "JCLTable.h"
#import "JCLTableCell.h"

@interface JCLTable()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *table;
@end

@implementation JCLTable
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 0.8;
        self.layer.borderWidth = 1; self.layer.backgroundColor = JCLBGRGB.CGColor;
        self.table = [JCLKitObj JCLTable:self target:self frame:self.bounds style:UITableViewStylePlain];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCLTableCell *cell = [JCLTableCell cellWithTableView:tableView style:UITableViewCellStyleDefault];
    cell.title.text = self.array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.actionBlock ? : self.actionBlock(indexPath.row);
}
@end
