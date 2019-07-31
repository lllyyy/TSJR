//
//  JCLTradingHeaderView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/11.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "JCLTradingHeaderView.h"

@implementation JCLTradingHeaderView
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
    [self addSubview:self.titleC];
    [self addSubview:self.titleD];
    
    
    [self.titleA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
    [self.titleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo((JCLWIDTH-80)/2);
        make.height.mas_equalTo(20);
    }];
    
    [self.titleD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);
    }];
    
    [self.titleC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(self.titleD.mas_left).offset(-25);
        make.height.mas_equalTo(20);
    }];
    
}
-(UILabel *)titleA{
    if (!_titleA) {
        _titleA = [[UILabel alloc]init];
        _titleA.text = @"名称|代码";
        _titleA.font = [UIFont systemFontOfSize:12];
        _titleA.textColor = JCLAccountRGB;
    }
    return _titleA;
}
-(UILabel *)titleB{
    if (!_titleB) {
        _titleB = [[UILabel alloc]init];
        _titleB.text = @"现价|委托";
        _titleB.font = [UIFont systemFontOfSize:12];
        _titleB.textColor = JCLAccountRGB;
    }
    return _titleB;
}
-(UILabel *)titleC{
    if (!_titleC) {
        _titleC = [[UILabel alloc]init];
        _titleC.text = @"总量|已成";
        _titleC.font = [UIFont systemFontOfSize:12];
        _titleC.textColor = JCLAccountRGB;
    }
    return _titleC;
}
-(UILabel *)titleD{
    if (!_titleD) {
        _titleD = [[UILabel alloc]init];
        _titleD.text = @"方向|状态";
        _titleD.font = [UIFont systemFontOfSize:12];
        _titleD.textColor = JCLAccountRGB ;
    }
    return _titleD;
}

@end
