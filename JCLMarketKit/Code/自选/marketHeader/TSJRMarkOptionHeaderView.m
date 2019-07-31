//
//  TSJRMarkOptionHeaderView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/19.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRMarkOptionHeaderView.h"

@implementation TSJRMarkOptionHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JCL_Cell_COL;
        [self setUI];
    }
    return self;
}
-(void)setUI{
    
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleB];
    [self.bgView addSubview:self.titleC];
 
    [self.bgView addSubview:self.titleE];
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    [self.titleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.titleC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.right.mas_equalTo(self.titleE.mas_left).offset(-60);
        make.width.mas_offset(55);
        make.height.mas_equalTo(24);
    }];
    [self.titleE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.right.mas_equalTo(-10);
        make.width.mas_offset(55);
        make.height.mas_equalTo(24);
    }];
 }

-(UIView *)bgView{
    if (!_bgView) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor = JCL_Cell_COL;
        //        _bgView.backgroundColor = [UIColor redColor];
    }
    return _bgView;
}
-(UILabel *)linA{
    if (!_linA) {
        _linA = [[UILabel alloc]init];
        _linA.backgroundColor = JCL_Bg_COL;
    }
    return _linA;
}

-(UILabel *)titleB{
    if (!_titleB) {
        _titleB = [[UILabel alloc]init];
        _titleB.font = [UIFont systemFontOfSize:14];
        _titleB.textColor = JCLAccountRGB;
        _titleB.text = @"名称 | 代码";
    }
    return _titleB;
}

-(UIButton *)titleC{
    if (!_titleC) {
        _titleC = [[UIButton alloc]init];
 
        [_titleC setTitle:@"价格" forState:0];
        [_titleC setTitleColor:JCLAccountRGB forState:0];
        _titleC.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_titleC setImage:[UIImage imageNamed:@"排序_n"] forState:0];
//        _titleC.imageEdgeInsets = UIEdgeInsetsMake(0, 43, 0, 0);
//        _titleC.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    return _titleC;
}



-(UIButton *)titleE{
    if (!_titleE) {
        _titleE = [[UIButton alloc]init];
        [_titleE setTitle:@"涨跌幅" forState:0];
        [_titleE setTitleColor:JCLAccountRGB forState:0];
        _titleE.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_titleE setImage:[UIImage imageNamed:@"排序_n"] forState:0];
//        _titleE.imageEdgeInsets = UIEdgeInsetsMake(0, 43, 0, 0);
//        _titleE.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    }
    return _titleE;
}

@end
