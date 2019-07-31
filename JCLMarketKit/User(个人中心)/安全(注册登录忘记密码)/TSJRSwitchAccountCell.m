//
//  TSJRSwitchAccountCell.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/4/10.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRSwitchAccountCell.h"

@implementation TSJRSwitchAccountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.bgview];
    [self.bgview addSubview:self.titleLB];
    [self.bgview addSubview:self.titleLBA];
    [self.bgview addSubview:self.titleLBB];
    [self.bgview addSubview:self.imagebtn];
    
    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(self);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.titleLBA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLB.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
    [self.titleLBB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLBA.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.imagebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
}

-(UIView *)bgview{
    if (!_bgview) {
        _bgview = [[UIView alloc]init];
        _bgview.backgroundColor = JCLFallRGB;
        _bgview.alpha = 0.7;
        _bgview.layer.cornerRadius = 5;
        _bgview.layer.masksToBounds = YES;
    }
    return _bgview;
}
-(UILabel *)titleLB{
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.font = [UIFont systemFontOfSize:14];
        _titleLB.textColor = [UIColor whiteColor];
        _titleLB.text = @"老虎实盘账户";
    }
    return _titleLB;
}
-(UILabel *)titleLBA{
    if (!_titleLBA) {
        _titleLBA = [[UILabel alloc]init];
        _titleLBA.font = [UIFont systemFontOfSize:25];
        _titleLBA.textColor = [UIColor whiteColor];
        _titleLBA.text = @"立即开通";
    }
    return _titleLBA;
}
-(UILabel *)titleLBB{
    if (!_titleLBB) {
        _titleLBB = [[UILabel alloc]init];
        _titleLBB.font = [UIFont systemFontOfSize:12];
        _titleLBB.textColor = [UIColor whiteColor];
        _titleLBB.text = @"开户快、支持融资、交易便捷";
    }
    return _titleLBB;
}

-(UIButton *)imagebtn{
    if (!_imagebtn) {
        _imagebtn = [[UIButton alloc]init];
        
    }
    return _imagebtn;
}

@end
