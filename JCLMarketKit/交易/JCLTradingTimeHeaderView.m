//
//  JCLTradingTimeHeaderView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/11.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "JCLTradingTimeHeaderView.h"

@implementation JCLTradingTimeHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JCL_Cell_COL;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.titleA];
    [self addSubview:self.titleB];
    [self addSubview:self.arrmor];
    
    
    [self.titleA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
    
    [self.arrmor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(10);
    }];
    [self.titleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(self.arrmor.mas_left).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
}
-(UILabel *)titleA{
    if (!_titleA) {
        _titleA = [[UILabel alloc]init];
        _titleA.text = @"选择月份";
        _titleA.font = [UIFont systemFontOfSize:14];
        _titleA.textColor = JCLAccountRGB;
    }
    return _titleA;
}
-(UILabel *)titleB{
    if (!_titleB) {
        _titleB = [[UILabel alloc]init];
        _titleB.text = @"全部";
        _titleB.font = [UIFont systemFontOfSize:14];
        _titleB.textColor = JCL_SelText_COL;
    }
    return _titleB;
}
-(UIImageView *)arrmor{
    if (!_arrmor) {
        _arrmor = [[UIImageView alloc]init];
        _arrmor.image = [UIImage imageNamed:@"向下展开"];
    }
    return _arrmor;
}
@end
