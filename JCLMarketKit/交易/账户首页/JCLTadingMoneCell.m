//
//  JCLTadingMoneCell.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/27.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "JCLTadingMoneCell.h"

@implementation JCLTadingMoneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = RGB(55, 61, 93);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
       
    }
    return self;
}

-(void)setUI{
    
     [self addSubview:self.title];
     [self addSubview:self.titleA];
     [self addSubview:self.titleB];
     [self addSubview:self.titleC];
     [self addSubview:self.titleD];
     [self addSubview:self.titleE];
     [self addSubview:self.titleF];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);
    }];
    
    [self.titleA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).offset(25);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.titleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleA.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).offset(25);
        make.left.mas_equalTo((kScreenWidth-80)/2);
        make.height.mas_equalTo(15);
    }];
    [self.titleD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleC.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.titleC.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).offset(25);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(15);
    }];
    [self.titleF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleE.mas_bottom).offset(10);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(15);
    }];
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"25,172.55";
        _title.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:20];
        _title.textColor = [UIColor yellowColor];
        _title.textAlignment = NSTextAlignmentCenter;
       _title.adjustsFontSizeToFitWidth = YES;
    }
    return _title;
}

-(UILabel *)titleA{
    if (!_titleA) {
        _titleA = [[UILabel alloc]init];
        _titleA.text = @"风控值";
        _titleA.font = [UIFont systemFontOfSize:14];
        _titleA.textColor = [UIColor whiteColor];
    }
    return _titleA;
}

-(UILabel *)titleB{
    if (!_titleB) {
        _titleB = [[UILabel alloc]init];
        _titleB.text = @"25,170.50";
        _titleB.font = [UIFont systemFontOfSize:14];
        _titleB.textColor = [UIColor yellowColor];
    }
    return _titleB;
}

-(UILabel *)titleC{
    if (!_titleC) {
        _titleC = [[UILabel alloc]init];
        _titleC.text = @"持仓盈亏(USD)";
        _titleC.font = [UIFont systemFontOfSize:14];
        _titleC.textColor = [UIColor whiteColor];
    }
    return _titleC;
}

-(UILabel *)titleD{
    if (!_titleD) {
        _titleD = [[UILabel alloc]init];
        _titleD.text = @"25,170.50";
        _titleD.font = [UIFont systemFontOfSize:14];
        _titleD.textColor = [UIColor whiteColor];
    }
    return _titleD;
}
-(UILabel *)titleE{
    if (!_titleE) {
        _titleE = [[UILabel alloc]init];
        _titleE.text = @"可用购买力";
        _titleE.font = [UIFont systemFontOfSize:14];
        _titleE.textColor = [UIColor whiteColor];
    }
    return _titleE;
}

-(UILabel *)titleF{
    if (!_titleF) {
        _titleF = [[UILabel alloc]init];
        _titleF.text = @"25,170.50";
        _titleF.font = [UIFont systemFontOfSize:14];
        _titleF.textColor = [UIColor yellowColor];
    }
    return _titleF;
}

-(void)setDate:(JCLAccountModel *)model{
    self.title.text = [JCLKitObj countNumAndChangeformat:model.equityWithLoan];
    self.titleB.text = [NSString stringWithFormat:@"%@",[JCLKitObj moneyFormat:model.availableFunds]];
    self.titleD.text = [NSString stringWithFormat:@"%@",[JCLKitObj countNumAndChangeformat:model.unrealizedPnL]];
    self.titleF.text = model.buyingPower;
}

 
@end
