//
//  JCLTradingHeaderView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/27.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "JCLTradingFootView.h"

@implementation JCLTradingFootView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Cell_COL;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.line];
    [self addSubview:self.orderbtn];
    [self addSubview:self.tradingBtn];
    [self addSubview:self.accountbtn];
    [self addSubview:self.bgview];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    [self.orderbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(0);;
        make.left.mas_equalTo(15);
        make.width.mas_equalTo((JCLWIDTH - 30)/3);
        make.height.mas_equalTo(40);
    }];
    [self.tradingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(0);;
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    [self.accountbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(0);;
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    
    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
}



-(UIButton *)orderbtn{
    if (!_orderbtn) {
        _orderbtn = [[UIButton alloc]init];
        _orderbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _orderbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_orderbtn setImage:[UIImage imageNamed:@"处方 icon 拷贝 2"] forState:0];
        [_orderbtn setTitle:@"订单" forState:0];
        [_orderbtn setTitleColor:[UIColor whiteColor] forState:0];
//         _orderbtn.imageEdgeInsets = UIEdgeInsetsMake(0, kScreenWidth - 45, 0, 0);
        _orderbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    }
    return _orderbtn;
}

-(UIButton *)tradingBtn{
    if (!_tradingBtn) {
        _tradingBtn = [[UIButton alloc]init];
        _tradingBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _tradingBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_tradingBtn setImage:[UIImage imageNamed:@"处方 icon 拷贝 2"] forState:0];
        [_tradingBtn setTitle:@"下单" forState:0];
        [_tradingBtn setTitleColor:[UIColor whiteColor] forState:0];
        //         _orderbtn.imageEdgeInsets = UIEdgeInsetsMake(0, kScreenWidth - 45, 0, 0);
        _tradingBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
    }
    return _tradingBtn;
}

-(UIButton *)accountbtn{
    if (!_accountbtn) {
        _accountbtn = [[UIButton alloc]init];
        _accountbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_accountbtn setImage:[UIImage imageNamed:@"我的账户"] forState:0];
        [_accountbtn setTitle:@"账户" forState:0];
        _accountbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        [_accountbtn setTitleColor:[UIColor whiteColor] forState:0];
        
    }
    return _accountbtn;
}


-(UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor = JCL_Bg_COL;
    }
    return _line;
}
-(UILabel *)bgview{
    if (!_bgview) {
        _bgview = [[UILabel alloc]init];
        _bgview.backgroundColor = JCL_Bg_COL;
    }
    return _bgview;
}
@end
