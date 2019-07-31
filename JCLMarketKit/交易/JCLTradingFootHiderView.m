//
//  JCLTradingFootHiderView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/12.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "JCLTradingFootHiderView.h"

@implementation JCLTradingFootHiderView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.backgroundColor=JCL_Bg_COL;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.stocksBtn];
    [self addSubview:self.detailBtn];
    [self addSubview:self.updateBtn];
    [self addSubview:self.undolBtn];
    
    [self.stocksBtn addSubview:self.stocksimg];
    [self.stocksBtn addSubview:self.stocksLB];
    
    [self.detailBtn addSubview:self.detailimg];
    [self.detailBtn addSubview:self.detailLB];
    
    [self.updateBtn addSubview:self.updateimg];
    [self.updateBtn addSubview:self.updateLB];
    
    [self.undolBtn addSubview:self.undoimg];
    [self.undolBtn addSubview:self.undoLB];
    
    [self.stocksBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(self);
    }];
    
    [self.stocksimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(self.stocksBtn.mas_centerX);
        make.width.height.mas_equalTo(20);
    }];
    [self.stocksLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stocksimg.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.stocksBtn.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.stocksBtn.mas_right).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(self);
    }];
    
    [self.detailimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(self.detailBtn.mas_centerX);
        make.width.height.mas_equalTo(20);
    }];
    [self.detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailimg.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.detailimg.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    [self.updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.detailBtn.mas_right).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(self);
    }];
    
    [self.updateimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(self.updateBtn.mas_centerX);
        make.width.height.mas_equalTo(20);
    }];
    [self.updateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.updateimg.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.updateimg.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    
    
    [self.undolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(self);
    }];
    
    [self.undoimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(self.undolBtn.mas_centerX);
        make.width.height.mas_equalTo(20);
    }];
    [self.undoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.undoimg.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.undoimg.mas_centerX);
        make.height.mas_equalTo(15);
    }];
}


-(UIButton *)stocksBtn{
    if (!_stocksBtn) {
        _stocksBtn = [[UIButton alloc]init];
    }
    return _stocksBtn;
}

-(UIImageView *)stocksimg{
    if (!_stocksimg) {
        _stocksimg = [[UIImageView alloc]init];
        _stocksimg.image = [UIImage imageNamed:@"行情_n"];
    }
    return _stocksimg;
}
-(UILabel *)stocksLB{
    if (!_stocksLB) {
        _stocksLB = [[UILabel alloc]init];
        _stocksLB.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        _stocksLB.textColor = [UIColor whiteColor];
        _stocksLB.adjustsFontSizeToFitWidth = YES;
        _stocksLB.text = @"个股";
    }
    return _stocksLB;
}
-(UIButton *)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc]init];
    }
    return _detailBtn;
}

-(UIImageView *)detailimg{
    if (!_detailimg) {
        _detailimg = [[UIImageView alloc]init];
        _detailimg.image = [UIImage imageNamed:@"suo-12"];
    }
    return _detailimg;
}
-(UILabel *)detailLB{
    if (!_detailLB) {
        _detailLB = [[UILabel alloc]init];
        _detailLB.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        _detailLB.textColor = [UIColor whiteColor];
        _detailLB.adjustsFontSizeToFitWidth = YES;
        _detailLB.text = @"详情";
    }
    return _detailLB;
}
-(UIButton *)updateBtn{
    if (!_updateBtn) {
        _updateBtn = [[UIButton alloc]init];
        _updateBtn.hidden = YES;
    }
    return _updateBtn;
}

-(UIImageView *)updateimg{
    if (!_updateimg) {
        _updateimg = [[UIImageView alloc]init];
        _updateimg.image = [UIImage imageNamed:@"suo-12"];
    }
    return _updateimg;
}
-(UILabel *)updateLB{
    if (!_updateLB) {
        _updateLB = [[UILabel alloc]init];
        _updateLB.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        _updateLB.textColor = [UIColor whiteColor];
        _updateLB.adjustsFontSizeToFitWidth = YES;
        _updateLB.text = @"修改";
    }
    return _updateLB;
}

-(UIButton *)undolBtn{
    if (!_undolBtn) {
        _undolBtn = [[UIButton alloc]init];
        _undolBtn.hidden = YES;
    }
    return _undolBtn;
}

-(UIImageView *)undoimg{
    if (!_undoimg) {
        _undoimg = [[UIImageView alloc]init];
        _undoimg.image = [UIImage imageNamed:@"suo-12"];
    }
    return _undoimg;
}
-(UILabel *)undoLB{
    if (!_undoLB) {
        _undoLB = [[UILabel alloc]init];
        _undoLB.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        _undoLB.textColor = [UIColor whiteColor];
        _undoLB.adjustsFontSizeToFitWidth = YES;
        _undoLB.text = @"撤销";
    }
    return _undoLB;
}
@end
