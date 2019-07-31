//
//  RangeMoreTableCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/11/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLMarketInfoCell.h"

@interface JCLMarketInfoCell()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, strong) NSMutableArray *arrM;
@end

@implementation JCLMarketInfoCell
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"cell";
    JCLMarketInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLMarketInfoCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.title = [YSKitObj YSLable:self size:15 color:JCL_Text_COL alignment:1 style:1];
        self.code = [YSKitObj YSLable:self size:13 color:JCLRGBA(190, 190, 190, 1) alignment:1 style:0];
        
        self.scroll = [JCLKitObj JCLScroll:self page:NO delegate:self];
        self.scroll.backgroundColor = JCL_Cell_COL;
        [JCLKitObj RXTap:self.scroll target:self action:@selector(action) number:1];
    }
    return self;
}

-(NSMutableArray *)arrM{ if (_arrM) return _arrM; return _arrM = [[NSMutableArray alloc]init]; }
-(void)setArr:(NSArray *)arr{
    _arr = arr;
    if (arr.count && !self.arrM.count) {
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *info = [YSKitObj YSLable:self.scroll size:15 color:nil alignment:1 style:0];
            info.textColor = JCL_Text_COL;
            [self.arrM addObject:info];
        }];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - 1.4);
    CGFloat s = 10, w = 0.25*self.width, h = 0.5*(self.bg.height - 2*s);
    self.title.frame = CGRectMake(0, s, w, h); self.code.frame = CGRectMake(0, self.title.maxY, w, h);
    
    self.scroll.frame = CGRectMake(self.title.maxX, 0, self.width - self.title.maxX, self.height - 2);
    self.scroll.contentSize = CGSizeMake(self.arrM.count*w, 0);
    [self.arrM enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL *stop) {
        obj.text = self.arr[idx];
        if (idx == 0 || idx == 1) {
            if([obj.text containsString:@"--"]){
                obj.textColor = JCL_Text_COL;
            }else{
                obj.textColor = [JCLMarketObj JCLMarketColor:self.arr[1] close:@"0"];
            }
        }
        obj.frame = CGRectMake(idx*w, 0, w, self.scroll.height);
    }];
}

-(void)action{ !self.actionBlock ? : self.actionBlock(); }
@end
