//
//  TSJRBuyingSellingFootViewB.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/19.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRBuyingSellingFootViewB.h"

@implementation TSJRBuyingSellingFootViewB
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
    
    [self addSubview:self.plateLB];
 
    [self addSubview:self.timeBtn];
 
    [self addSubview:self.linbg];
    
    [self.descLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(15);
    }];
    
    
    [self.plateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descLB.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descLB.mas_bottom).offset(20);
        make.left.mas_equalTo(self.plateLB.mas_right).offset(25);
        make.width.mas_equalTo(100);
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
//        _descLB.text = @"当前账户杠杆1.12倍，成交后将会增大";
        _descLB.font = [UIFont systemFontOfSize:12];
        _descLB.textColor = JCLAccountRGB;
    }
    return _descLB;
}


-(UILabel *)plateLB{
    if (!_plateLB) {
        _plateLB = [[UILabel alloc]init];
        _plateLB.text = @"期限";
        _plateLB.font = [UIFont systemFontOfSize:14];
        _plateLB.textColor = JCLAccountRGB;
    }
    return _plateLB;
}


-(UIButton *)timeBtn{
    if (!_timeBtn) {
        _timeBtn = [[UIButton alloc]init];
        _timeBtn.tag = 1;
        [_timeBtn setTitle:@"当日有效" forState:0];
        [_timeBtn setTitleColor:JCLRGB(197, 171, 112) forState:0];
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_timeBtn setImage:[UIImage imageNamed:@"已添加"] forState:0];//刷新成功
        _timeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //        _noAllowbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _timeBtn;
}

-(UILabel *)linbg{
    if (!_linbg) {
        _linbg = [[UILabel alloc]init];
        _linbg.backgroundColor = JCL_Bg_COL;
    }
    return _linbg;
}
 

@end
