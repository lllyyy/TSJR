//
//  JCLDataCell.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/30.
//  Copyright © 2017年 刘虎超. All rights reserved.
//

#import "JCLDataCell.h"

@interface JCLDataCell()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, strong) NSMutableArray *arrM;
@end

@implementation JCLDataCell
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"cell";
    JCLDataCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLDataCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.arrM = [NSMutableArray arrayWithCapacity:0];
        self.backgroundColor = JCLBGRGB;
        self.bg = [JCLKitObj JCLView:self color:[UIColor whiteColor]];
        self.title = [YSKitObj YSLable:self size:16 color:JCLRGB(65, 72, 82) alignment:NSTextAlignmentLeft style:1];
        self.code = [YSKitObj YSLable:self size:14 color:JCLRGB(168,168,168) alignment:NSTextAlignmentLeft style:0];
        
        self.scroll = [JCLKitObj JCLScroll:self page:NO delegate:self];
        [JCLKitObj RXTap:self.scroll target:self action:@selector(action) number:1];
        [JCLKitObj RXTap:self.code   target:self action:@selector(action) number:1];
        [JCLKitObj RXTap:self.title  target:self action:@selector(action) number:1];
    }
    return self;
}

-(NSMutableArray *)arrM{ if (_arrM) return _arrM; return _arrM = [[NSMutableArray alloc]init]; }
-(void)setArr:(NSArray *)arr{
    [self.arrM enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self.arrM removeAllObjects];

    _arr = arr;
    if (arr.count && !self.arrM.count) {
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *info = [YSKitObj YSLable:self.scroll size:15 color:nil alignment:NSTextAlignmentCenter style:0];
            [self.arrM addObject:info];
        }];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - 1.4);
    CGFloat s = 5, w = 0.25*self.width, h = 0.5*(self.bg.height - 2*s);
    
    self.title.frame = CGRectMake(15, 5, 0.25*JCLWIDTH, self.height/2-3);
    self.code.frame = CGRectMake(15, self.height/2-3, 0.25*JCLWIDTH, self.height/2);
    
    self.scroll.frame = CGRectMake(self.title.maxX, 0, self.width - self.title.maxX, self.height - 2);
    self.scroll.contentSize = CGSizeMake(self.arrM.count*0.23*JCLWIDTH, 0);
    [self.arrM enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        obj.text = [NSString stringWithFormat:@"%@",self.arr[idx]];
        obj.textColor=self.colorArr[idx];
        obj.frame = CGRectMake(idx*0.23*JCLWIDTH, 0, 0.23*JCLWIDTH, self.scroll.height);
    }];
}

-(void)action{
    !self.actionBlock ? : self.actionBlock();
}
@end

