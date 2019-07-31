//
//  TSJRTradingMainHeaderView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/14.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRTradingMainHeaderView.h"
#import "TSJRQueryPositionModel.h"
@implementation TSJRTradingMainHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JCL_Cell_COL;
        [self setUI];
    }
    return self;
}
-(void)setUI{
    [self addSubview:self.bgBtn];
    [self.bgBtn addSubview:self.imagev];
    [self.bgBtn addSubview:self.titleA];
    [self.bgBtn addSubview:self.currency];
    [self.bgBtn addSubview:self.market];
    [self.bgBtn addSubview:self.rightMore];
    [self.bgBtn addSubview:self.unrealizedPnl];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.linA];
    [self.bgView addSubview:self.titleB];
   [self.bgView addSubview:self.titleC];
   [self.bgView addSubview:self.titleD];
   [self.bgView addSubview:self.titleE];
    
    [self.bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    [self.imagev mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(15);
    }];
    [self.titleA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.imagev.mas_right).offset(5);
        make.height.mas_equalTo(15);
    }];
    [self.currency mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.titleA.mas_right);
        make.height.mas_equalTo(15);
    }];
    [self.market mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.currency.mas_right).offset(5);
        make.height.mas_equalTo(15);
    }];
    
    [self.rightMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(13);
    }];
    [self.unrealizedPnl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(self.rightMore.mas_left).offset(-10);
        make.height.mas_equalTo(15);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
    [self.linA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.1);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    [self.titleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    if (isX) {
        [self.titleC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(1);
            make.left.mas_equalTo(self.titleB.mas_right).offset(45);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(24);
        }];
    }else{
        [self.titleC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(1);
            make.left.mas_equalTo(self.titleB.mas_right).offset(60);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(24);
        }];
    }
   
    [self.titleE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(24);
    }];
    [self.titleD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(self.titleE.mas_left).offset(-25);
        make.height.mas_equalTo(15);
    }];
}

-(UIButton *)bgBtn{
    if (!_bgBtn) {
        _bgBtn = [[UIButton alloc]init];
    }
    return _bgBtn;
}


-(UIImageView *)imagev{
    if (!_imagev) {
        _imagev = [[UIImageView alloc]init];
        _imagev.contentMode = UIViewContentModeScaleAspectFill;
        _imagev.image = [UIImage imageNamed:@"usa"];
        _imagev.layer.masksToBounds = YES;
    }
    return _imagev;
}
-(UILabel *)titleA{
    if (!_titleA) {
        _titleA = [[UILabel alloc]init];
        _titleA.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        _titleA.textColor = [UIColor whiteColor];
     }
    return _titleA;
}
-(UILabel *)currency{
    if (!_currency) {
        _currency = [[UILabel alloc]init];
        _currency.font = [UIFont systemFontOfSize:15];
        _currency.textColor = JCLAccountRGB;
    }
    return _currency;
}
-(UILabel *)market{
    if (!_market) {
        _market = [[UILabel alloc]init];
        _market.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        _market.textColor = [UIColor whiteColor];
    }
    return _market;
}

-(UILabel *)unrealizedPnl{
    if (!_unrealizedPnl) {
        _unrealizedPnl = [[UILabel alloc]init];
        _unrealizedPnl.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        _unrealizedPnl.textColor = JCLRGB(75, 240, 178);
    }
    return _unrealizedPnl;
}

-(UIImageView *)rightMore{
    if (!_rightMore) {
        _rightMore = [[UIImageView alloc]init];
        _rightMore.image =[UIImage imageNamed:@"ic_drop_down"];
    }
    return _rightMore;
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
        _titleB.font = [UIFont systemFontOfSize:12];
        _titleB.textColor = JCLAccountRGB;
        _titleB.text = @"名称 | 代码";
    }
    return _titleB;
}

-(UIButton *)titleC{
    if (!_titleC) {
        _titleC = [[UIButton alloc]init];
 
        [_titleC setTitle:@"持仓 | 市值 " forState:0];
        [_titleC setTitleColor:JCLAccountRGB forState:0];
        _titleC.titleLabel.font = [UIFont systemFontOfSize:12];
        [_titleC setImage:[UIImage imageNamed:@"排序_n"] forState:0];
        _titleC.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        _titleC.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    }
    return _titleC;
}

-(UILabel *)titleD{
    if (!_titleD) {
        _titleD = [[UILabel alloc]init];
        _titleD.font = [UIFont systemFontOfSize:12];
        _titleD.textColor = JCLAccountRGB;
        _titleD.text = @"现价 | 成本";
    }
    return _titleD;
}

-(UIButton *)titleE{
    if (!_titleE) {
        _titleE = [[UIButton alloc]init];
        [_titleE setTitle:@"浮动盈亏" forState:0];
        [_titleE setTitleColor:JCLAccountRGB forState:0];
        _titleE.titleLabel.font = [UIFont systemFontOfSize:12];
        [_titleE setImage:[UIImage imageNamed:@"排序_n"] forState:0];
        _titleE.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _titleE.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
     }
    return _titleE;
}

-(void)setData:(id)model{
//     TSJRQueryPositionModel *m = model;
    CGFloat marketValue = 0;
    CGFloat unrealizedPnl = 0;
    for (TSJRQueryPositionModel *makeP in model) {
        marketValue   += makeP.marketValue.floatValue;
        unrealizedPnl += makeP.unrealizedPnl.floatValue;
 
    }
     NSLog(@"unrealizedPnlunrealizedPnl %f",marketValue);
     NSLog(@"unrealizedPnlunrealizedPnl %f",unrealizedPnl);
    self.imagev.backgroundColor = [UIColor redColor];
    self.titleA.text=@"美股市值";
    self.currency.text=@"(USD)";
    self.market.text=  [NSString stringWithFormat:@"%.2f",marketValue];;
   self.unrealizedPnl.text=[JCLKitObj countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",unrealizedPnl]];
    
}

@end
