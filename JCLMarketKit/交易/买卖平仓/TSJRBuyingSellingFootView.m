//
//  TSJRBuyingSellingFootView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/17.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRBuyingSellingFootView.h"

@implementation TSJRBuyingSellingFootView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JCL_Cell_COL;
        [self setUI];
    }
    return self;
}

-(void)setUI{
     [self addSubview:self.descLB];
     [self addSubview:self.amountLB];
     [self addSubview:self.priceLB];
     [self addSubview:self.lineA];
    
    [self addSubview:self.amountDescLB];
    [self addSubview:self.limitLB];
    [self addSubview:self.plateLB];
    [self addSubview:self.effectiveBtn];
    [self addSubview:self.noAllowbtn];
    [self addSubview:self.allowbtn];
    [self addSubview:self.linbg];
    
    [self.descLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(15);
    }];
    
    [self.amountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descLB.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descLB.mas_bottom).offset(15);
        make.left.mas_equalTo(100);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(15);
    }];
    [self.lineA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.amountLB.mas_bottom).offset(15);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    [self.amountDescLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineA.mas_bottom).offset(5);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(15);
    }];
    
    [self.limitLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.amountDescLB.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    [self.plateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.limitLB.mas_bottom).offset(30);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.effectiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.amountDescLB.mas_bottom).offset(15);
        make.left.mas_equalTo(self.limitLB.mas_right).offset(15);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(20);
    }];
   
    [self.allowbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.limitLB.mas_bottom).offset(30);
        make.left.mas_equalTo(self.plateLB.mas_right).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    [self.noAllowbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.limitLB.mas_bottom).offset(30);
        make.left.mas_equalTo(self.allowbtn.mas_right).offset(30);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(20);
    }];
    [self.linbg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
}

-(UILabel *)descLB{
    if (!_descLB) {
        _descLB = [[UILabel alloc]init];
//        _descLB.text = @"持仓数量 1 持仓均价158.12";
        _descLB.font = [UIFont systemFontOfSize:12];
        _descLB.textColor = JCLAccountRGB;
    }
    return _descLB;
}
-(UILabel *)amountLB{
    if (!_amountLB) {
        _amountLB = [[UILabel alloc]init];
        _amountLB.text = @"金额";
        _amountLB.font = [UIFont systemFontOfSize:14];
        _amountLB.textColor = JCLAccountRGB;
    }
    return _amountLB;
}
-(UILabel *)priceLB{
    if (!_priceLB) {
        _priceLB = [[UILabel alloc]init];
 
        _priceLB.font = [UIFont systemFontOfSize:14];
        _priceLB.textColor = JCLRGB(197, 171, 112);
        _priceLB.textAlignment=NSTextAlignmentCenter;
    }
    return _priceLB;
}
-(UILabel *)lineA{
    if (!_lineA) {
        _lineA = [[UILabel alloc]init];
        _lineA.backgroundColor = JCL_Bg_COL;
    }
    return _lineA;
}


-(UILabel *)amountDescLB{
    if (!_amountDescLB) {
        _amountDescLB = [[UILabel alloc]init];
        _amountDescLB.text = @"当前账户杠杆1.12倍，成交后将会增大";
        _amountDescLB.font = [UIFont systemFontOfSize:12];
        _amountDescLB.textColor = JCLAccountRGB;
    }
    return _amountDescLB;
}
-(UILabel *)limitLB{
    if (!_limitLB) {
        _limitLB = [[UILabel alloc]init];
        _limitLB.text = @"期限";
        _limitLB.font = [UIFont systemFontOfSize:14];
        _limitLB.textColor = JCLAccountRGB;
    }
    return _limitLB;
}
-(UILabel *)plateLB{
    if (!_plateLB) {
        _plateLB = [[UILabel alloc]init];
        _plateLB.text = @"盘前盘后";
        _plateLB.font = [UIFont systemFontOfSize:14];
        _plateLB.textColor = JCLAccountRGB;
    }
    return _plateLB;
}

-(UIButton *)effectiveBtn{
    if (!_effectiveBtn) {
        _effectiveBtn = [[UIButton alloc]init];
        [_effectiveBtn setTitle:@"当前有效" forState:0];
        [_effectiveBtn setTitleColor:JCLRGB(197, 171, 112) forState:0];
        _effectiveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_effectiveBtn setImage:[UIImage imageNamed:@"已添加"] forState:0];//刷新成功
        _effectiveBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//        _effectiveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     }
    return _effectiveBtn;
}
-(UIButton *)noAllowbtn{
    if (!_noAllowbtn) {
        _noAllowbtn = [[UIButton alloc]init];
        _noAllowbtn.tag = 10001;
        [_noAllowbtn setTitle:@"不允许" forState:0];
        [_noAllowbtn setTitleColor:JCLRGB(197, 171, 112) forState:0];
        _noAllowbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_noAllowbtn setImage:[UIImage imageNamed:@"buxuan"] forState:0];
        _noAllowbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//        _noAllowbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _noAllowbtn;
}
-(UIButton *)allowbtn{
    if (!_allowbtn) {
        _allowbtn = [[UIButton alloc]init];
        _allowbtn.tag = 10002;
       [_allowbtn setTitle:@"允许" forState:0];
        [_allowbtn setTitleColor:JCLRGB(197, 171, 112) forState:0];
        _allowbtn.titleLabel.font = [UIFont systemFontOfSize:14];
      
          [_allowbtn setImage:[UIImage imageNamed:@"已添加"] forState:0];//刷新成功
        _allowbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//        _allowbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _allowbtn;
}
-(UILabel *)linbg{
    if (!_linbg) {
        _linbg = [[UILabel alloc]init];
        _linbg.backgroundColor = JCL_Bg_COL;
    }
    return _linbg;
}
@end
