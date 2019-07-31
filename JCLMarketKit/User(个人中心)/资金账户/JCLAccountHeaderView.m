//
//  JCLAccountHeaderView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/18.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLAccountHeaderView.h"

@implementation JCLAccountHeaderView

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Cell_COL;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
        self.layer.masksToBounds = YES;
    }
    return self;
}



-(void)setUI{
    __weak typeof (self) weakSelf = self;
    [self addSubview:self.title];
    [self addSubview:self.blogo];
    [self addSubview:self.baseLB];
    
    [self addSubview:self.moreRight];
    [self addSubview:self.lin];
    [self addSubview:self.titleA];
    [self addSubview:self.digitalA];
    [self addSubview:self.titleB];
    [self addSubview:self.digitalB];
    [self addSubview:self.titleC];
    [self addSubview:self.digitalC];
    [self addSubview:self.titleD];
    [self addSubview:self.digitalD];
    
    [self addSubview:self.titleE];
    [self addSubview:self.digitalE];
    [self addSubview:self.titleF];
    [self addSubview:self.digitalF];
    [self addSubview:self.titleG];
    [self addSubview:self.digitalG];
    [self addSubview:self.titleH];
    [self addSubview:self.digitalH];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.baseLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(weakSelf.title.mas_right).offset(10);
        make.height.mas_equalTo(15);
    }];
    
    [self.blogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.mas_equalTo(weakSelf.title.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.moreRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10));
        make.right.equalTo(@(-15));
        make.size.mas_equalTo(CGSizeMake(10, 15));
    }];
    
    [self.lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    [self.titleA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lin.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.digitalA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleA.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lin.mas_bottom).offset(20);
        make.left.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    [self.digitalB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleA.mas_bottom).offset(15);
        make.left.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.digitalA.mas_bottom).offset(25);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.digitalC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleC.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.digitalB.mas_bottom).offset(25);
        make.left.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    [self.digitalD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleD.mas_bottom).offset(15);
        make.left.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.digitalC.mas_bottom).offset(25);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.digitalE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleE.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.digitalD.mas_bottom).offset(25);
        make.left.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    [self.digitalF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleF.mas_bottom).offset(15);
        make.left.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.digitalE.mas_bottom).offset(25);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.digitalG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleG.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.digitalF.mas_bottom).offset(25);
        make.left.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    [self.digitalH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleH.mas_bottom).offset(15);
        make.left.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(15);
    }];
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
       _title.text = @"天使模拟账户  单位USD";
        _title.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        _title.textColor = JCLAccountRGB;
        _title.adjustsFontSizeToFitWidth = YES;
    }
    return _title;
}

-(UILabel *)blogo{
    if (!_blogo) {
        _blogo = [[UILabel alloc]init];
        _blogo.text = @" 当前账户 ";
        _blogo.font = [UIFont  systemFontOfSize:12];
        _blogo.textColor = [UIColor yellowColor];
        _blogo.layer.borderWidth = 0.5;
        _blogo.layer.borderColor = [UIColor yellowColor].CGColor;
        _blogo.layer.cornerRadius = 3;
        
    }
    return _blogo;
}


-(UIImageView *)moreRight{
    if (!_moreRight) {
        _moreRight = [[UIImageView alloc]init];
        _moreRight.image = [UIImage imageNamed:@"下一页"];
    }
    return _moreRight;
}
-(UILabel *)lin{
    if (!_lin) {
        _lin = [[UILabel alloc]init];
        _lin.backgroundColor =JCL_Bg_COL;
    }
    return _lin;
}

-(UILabel *)titleA{
    if (!_titleA) {
        _titleA = [[UILabel alloc]init];
        _titleA.text = @"总资产";
        _titleA.font = [UIFont systemFontOfSize:14];
        _titleA.textColor = JCLAccountRGB;
    }
    return _titleA;
}

-(UILabel *)digitalA{
    if (!_digitalA) {
        _digitalA = [[UILabel alloc]init];
        _digitalA.text = @"0";
        _digitalA.font = [UIFont systemFontOfSize:14];
        _digitalA.textColor = [UIColor yellowColor];
    }
    return _digitalA;
}
-(UILabel *)titleB{
    if (!_titleB) {
        _titleB = [[UILabel alloc]init];
        _titleB.text = @"风控值";
        _titleB.font = [UIFont systemFontOfSize:14];
        _titleB.textColor = JCLAccountRGB;
    }
    return _titleB;
}

-(UILabel *)digitalB{
    if (!_digitalB) {
        _digitalB = [[UILabel alloc]init];
        _digitalB.text = @"0";
        _digitalB.font = [UIFont systemFontOfSize:14];
        _digitalB.textColor = [UIColor yellowColor];
    }
    return _digitalB;
}


-(UILabel *)titleC{
    if (!_titleC) {
        _titleC = [[UILabel alloc]init];
        _titleC.text = @"可用购买力";
        _titleC.font = [UIFont systemFontOfSize:14];
        _titleC.textColor = JCLAccountRGB;
    }
    return _titleC;
}

-(UILabel *)digitalC{
    if (!_digitalC) {
        _digitalC = [[UILabel alloc]init];
        _digitalC.text = @"0";
        _digitalC.font = [UIFont systemFontOfSize:14];
        _digitalC.textColor = [UIColor yellowColor];
    }
    return _digitalC;
}

-(UILabel *)titleD{
    if (!_titleD) {
        _titleD = [[UILabel alloc]init];
        _titleD.text = @"持仓盈亏";
        _titleD.font = [UIFont systemFontOfSize:14];
        _titleD.textColor = JCLAccountRGB;
    }
    return _titleD;
}

-(UILabel *)digitalD{
    if (!_digitalD) {
        _digitalD = [[UILabel alloc]init];
        _digitalD.text = @"0";
        _digitalD.font = [UIFont systemFontOfSize:14];
        _digitalD.textColor = JCLRGB(75, 240, 178);
    }
    return _digitalD;
}


-(UILabel *)titleE{
    if (!_titleE) {
        _titleE = [[UILabel alloc]init];
        _titleE.text = @"可用购买力";
        _titleE.font = [UIFont systemFontOfSize:14];
        _titleE.textColor = JCLAccountRGB;
    }
    return _titleE;
}

-(UILabel *)digitalE{
    if (!_digitalE) {
        _digitalE = [[UILabel alloc]init];
        _digitalE.text = @"0";
        _digitalE.font = [UIFont systemFontOfSize:14];
        _digitalE.textColor = [UIColor yellowColor];
    }
    return _digitalE;
}

-(UILabel *)titleF{
    if (!_titleF) {
        _titleF = [[UILabel alloc]init];
        _titleF.text = @"证券总价值";
        _titleF.font = [UIFont systemFontOfSize:14];
        _titleF.textColor = JCLAccountRGB;
    }
    return _titleF;
}

-(UILabel *)digitalF{
    if (!_digitalF) {
        _digitalF = [[UILabel alloc]init];
        _digitalF.text = @"0";
        _digitalF.font = [UIFont systemFontOfSize:14];
        _digitalF.textColor = [UIColor yellowColor];
    }
    return _digitalF;
}
-(UILabel *)titleG{
    if (!_titleG) {
        _titleG = [[UILabel alloc]init];
        _titleG.text = @"杠杆";
        _titleG.font = [UIFont systemFontOfSize:14];
        _titleG.textColor = JCLAccountRGB;
    }
    return _titleG;
}

-(UILabel *)digitalG{
    if (!_digitalG) {
        _digitalG = [[UILabel alloc]init];
        _digitalG.text = @"0";
        _digitalG.font = [UIFont systemFontOfSize:14];
        _digitalG.textColor = [UIColor yellowColor];
    }
    return _digitalG;
}
-(UILabel *)titleH{
    if (!_titleH) {
        _titleH = [[UILabel alloc]init];
        _titleH.text = @"账户保证金要求";
        _titleH.font = [UIFont systemFontOfSize:14];
        _titleH.textColor = JCLAccountRGB;
    }
    return _titleH;
}

-(UILabel *)digitalH{
    if (!_digitalH) {
        _digitalH = [[UILabel alloc]init];
        _digitalH.text = @"0";
        _digitalH.font = [UIFont systemFontOfSize:14];
        _digitalH.textColor = [UIColor yellowColor];
    }
    return _digitalH;
}


-(UILabel *)baseLB{
    if (!_baseLB) {
        _baseLB = [[UILabel alloc]init];
        _baseLB.text = @"0";
        _baseLB.font = [UIFont systemFontOfSize:12];
       _baseLB.textColor = [UIColor yellowColor];
        _baseLB.hidden = YES;
    }
    return _baseLB;
}


-(void)setDataModel:(JCLAccountModel *)model account:(NSInteger)account{
    if (account==0) {//现金账户
        self.blogo.hidden = YES;
        self.title.text = [NSString stringWithFormat:@"天使环球账户  单位%@",model.currency];
        self.title.textColor = [UIColor whiteColor];
        self.moreRight.image = [UIImage imageNamed:@" "];
    }else{
       self.blogo.hidden = NO;
       self.title.text = [NSString stringWithFormat:@"天使模拟账户  单位%@",model.currency];
       self.moreRight.image = [UIImage imageNamed:@"下一页"];
    }
  
    self.digitalA.text = [NSString stringWithFormat:@"%@",[JCLKitObj countNumAndChangeformat:model.equityWithLoan]];
    self.digitalB.text = [NSString stringWithFormat:@"%@",[JCLKitObj moneyFormat:model.availableFunds]];
    self.digitalC.text = [JCLKitObj moneyFormat:model.buyingPower];
    self.digitalD.text = [JCLKitObj countNumAndChangeformat:model.unrealizedPnL];
}
@end
