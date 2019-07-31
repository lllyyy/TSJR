//
//  TSJRTradingOrderDetailView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/14.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRTradingOrderDetailView.h"

@implementation TSJRTradingOrderDetailView

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
    [self addSubview:self.titleE];
    [self addSubview:self.linA];
    
    [self.titleA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
    }];
    [self.titleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleA.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(15);
    }];
    [self.titleC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleA.mas_bottom).offset(10);
        make.left.mas_equalTo(self.titleB.mas_right);
        make.height.mas_equalTo(15);
    }];
    [self.titleD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleC.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(15);
    }];
    [self.titleE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleC.mas_bottom).offset(10);
        make.left.mas_equalTo(self.titleD.mas_right);
        make.height.mas_equalTo(15);
    }];
    [self.linA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}
-(UILabel *)titleA{
    if (!_titleA) {
        _titleA = [[UILabel alloc]init];
        _titleA.text = @"已成交";
        _titleA.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 30];
        _titleA.textColor = [UIColor yellowColor];
    }
    return _titleA;
}
-(UILabel *)titleB{
    if (!_titleB) {
        _titleB = [[UILabel alloc]init];
        _titleB.text = @"下单时间 ";
        _titleB.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 15];
        _titleB.textColor = JCLAccountRGB;
    }
    return _titleB;
}
-(UILabel *)titleC{
    if (!_titleC) {
        _titleC = [[UILabel alloc]init];
        _titleC.text = @"2019/03/01 11:54:40";
        _titleC.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
        _titleC.textColor = [UIColor whiteColor];
    }
    return _titleC;
}
-(UILabel *)titleD{
    if (!_titleD) {
        _titleD = [[UILabel alloc]init];
        _titleD.text = @"成交时间 ";
        _titleD.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 15];
        _titleD.textColor = JCLAccountRGB;
    }
    return _titleD;
}
-(UILabel *)titleE{
    if (!_titleE) {
        _titleE = [[UILabel alloc]init];
        _titleE.text = @"2019/03/01 11:54:40";
        _titleE.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
        _titleE.textColor = [UIColor whiteColor];
    }
    return _titleE;
}
-(UILabel *)linA{
    if (!_linA) {
        _linA = [[UILabel alloc]init];
        
        _linA.backgroundColor = JCL_Bg_COL;
    }
    return _linA;
}
@end
