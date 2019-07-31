//
//  TSJRAccountOverHeaderView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/4/24.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRAccountOverHeaderView.h"

@implementation TSJRAccountOverHeaderView

//-(instancetype)initWithFrame:(CGRect)frame{
//    self =[super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = JCL_Cell_COL;
//        [self setUI];
//    }
//    return self;
//}

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
     [self addSubview:self.titleLB];
     [self addSubview:self.titleLBA];
     [self addSubview:self.titleLBB];
     [self addSubview:self.bgLine];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.left.mas_equalTo((JCLWIDTH/2)-80);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleLBA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLB.mas_top);
        make.left.mas_equalTo(self.titleLB.mas_right);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleLBB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLB.mas_bottom).offset(10);
        make.left.mas_equalTo(JCLWIDTH/2-30);
        make.height.mas_equalTo(20);
    }];
    
    [self.bgLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLBB.mas_bottom).offset(18);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
}

-(UILabel *)titleLB{
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.text = @"账户总资产";
        _titleLB.textColor = [UIColor whiteColor];
        _titleLB.font = [UIFont systemFontOfSize:15];
    }
    return _titleLB;
}

-(UILabel *)titleLBA{
    if (!_titleLBA) {
        _titleLBA = [[UILabel alloc]init];
        _titleLBA.text = @"单位：USD";
        _titleLBA.textColor = JCLAccountRGB;
        _titleLBA.font = [UIFont systemFontOfSize:15];
    }
    return _titleLBA;
}
-(UILabel *)titleLBB{
    if (!_titleLBB) {
        _titleLBB = [[UILabel alloc]init];
        _titleLBB.text = @"0.00";
        _titleLBB.textColor = [UIColor yellowColor];
        _titleLBB.font = [UIFont boldSystemFontOfSize:24];;
        _titleLBB.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLBB;
}
-(UILabel *)bgLine{
    if (!_bgLine) {
        _bgLine = [[UILabel alloc]init];
        _bgLine.backgroundColor = JCL_Bg_COL;
     }
    return _bgLine;
}

-(void)setDataModel:(JCLAccountModel *)model{
    if ([model.capability isEqualToString:@"Reg T Margin"]) {//现金账户
        self.titleLBB.text = [JCLKitObj moneyFormat:model.equityWithLoan];
    }else{
        self.titleLBB.text = @"0.00";
    }
}

@end
