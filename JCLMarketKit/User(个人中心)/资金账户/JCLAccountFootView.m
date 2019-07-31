//
//  JCLAvvountFootView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/26.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLAccountFootView.h"

@implementation JCLAccountFootView

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = JCL_Cell_COL;
        [self setUI];
        
    }
    return self;
}


-(void)setUI{
     [self addSubview:self.iconIV];
     [self addSubview:self.titleLabel];
     [self addSubview:self.moreImg];
     [self addSubview:self.line];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(6);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconIV.mas_right).offset(10);
        make.top.mas_equalTo(6);
        make.height.mas_equalTo(15);
    }];
    [self.moreImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(6);
        make.size.mas_equalTo(CGSizeMake(10, 15));
    }];
}

-(UIImageView *)iconIV{
    if (!_iconIV) {
        _iconIV=[[UIImageView alloc]init];
        _iconIV.image = [UIImage imageNamed:@"AppIcon"];
    }
    return _iconIV;
}

-(UIImageView *)moreImg{
    if (!_moreImg) {
        _moreImg=[[UIImageView alloc]init];
        _moreImg.image = [UIImage imageNamed:@"下一页"];
    }
    return _moreImg;
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
