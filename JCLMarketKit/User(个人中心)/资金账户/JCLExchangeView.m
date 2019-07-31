//
//  JCLExchangeView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/26.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLExchangeView.h"

@implementation JCLExchangeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = JCL_Cell_COL;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.line];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    
}
-(UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        _descLabel.textColor = JCLAccountRGB;
        _descLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _descLabel;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        _titleLabel.textColor = JCLAccountRGB;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}
-(UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor =JCL_Bg_COL;
    }
    return _line;
}
@end
