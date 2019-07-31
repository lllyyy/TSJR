//
//  TSJRBuyingSellingCell.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/15.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRBuyingSellingHeaderView.h"

@implementation TSJRBuyingSellingHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JCL_Cell_COL;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.searchStockView];
    
     [self addSubview:self.buyingA];
     [self addSubview:self.linA];
     [self addSubview:self.linB];
     [self addSubview:self.bglin];
     [self addSubview:self.selling];
     [self addSubview:self.linC];
     [self addSubview:self.linD];
    
    [self addSubview:self.bglinA];
    [self addSubview:self.buyingB];
    [self addSubview:self.bglinB];
    [self addSubview:self.buyingC];
    
    [self addSubview:self.linbottom];
     
    
    [self.searchStockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_offset(0);
        make.height.mas_equalTo(85);
    }];
  
    [self.buyingA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchStockView.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.linA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyingA.mas_top);
        make.left.mas_equalTo(self.buyingA.mas_right).offset(30);
        make.height.mas_equalTo(15);
    }];
    [self.bglin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyingA.mas_top);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(35);
    }];
    [self.linB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyingA.mas_top);
        make.left.mas_equalTo(self.bglin.mas_left).offset(-20);
        make.height.mas_equalTo(15);
    }];
    
    [self.selling mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyingA.mas_top);
        make.left.mas_equalTo(self.bglin.mas_right).offset(15);
        make.height.mas_equalTo(15);
    }];
    [self.linC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyingA.mas_top);
        make.left.mas_equalTo(self.selling.mas_right).offset(30);
        make.height.mas_equalTo(15);
    }];
    [self.linD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyingA.mas_top);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(15);
    }];
    
    [self.bglinA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyingA.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(8);
    }];
    
    [self.buyingB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bglinA.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(JCLWIDTH/2);
        make.height.mas_equalTo(45);
    }];
    [self.bglinB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bglinA.mas_bottom).offset(0);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(45);
    }];
    [self.buyingC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bglinA.mas_bottom).offset(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(JCLWIDTH/2);
        make.height.mas_equalTo(45);
    }];
    [self.linbottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

-(TSJRSearchStockView *)searchStockView{
    if (!_searchStockView) {
        _searchStockView = [[TSJRSearchStockView alloc]init];
    }
    return _searchStockView;
}


-(UILabel *)buyingA{
    if (!_buyingA) {
        _buyingA = [[UILabel alloc]init];
        _buyingA.text = @"买盘";
        _buyingA.font = [UIFont systemFontOfSize:14];
        _buyingA.textColor = JCLAccountRGB;
        _buyingA.adjustsFontSizeToFitWidth = YES;
    }
    return _buyingA;
}
-(UILabel *)linA{
    if (!_linA) {
        _linA = [[UILabel alloc]init];
        _linA.text = @"--";
        _linA.font = [UIFont systemFontOfSize:14];
        _linA.textColor = [UIColor redColor];
       
    }
    return _linA;
}
-(UILabel *)linB{
    if (!_linB) {
        _linB = [[UILabel alloc]init];
        _linB.text = @"--";
        _linB.font = [UIFont systemFontOfSize:14];
        _linB.textColor = JCLAccountRGB;
        
    }
    return _linB;
}
-(UILabel *)bglin{
    if (!_bglin) {
        _bglin = [[UILabel alloc]init];
        _bglin.backgroundColor = JCL_Bg_COL;
    }
    return _bglin;
}
-(UILabel *)selling{
    if (!_selling) {
        _selling = [[UILabel alloc]init];
        _selling.text = @"卖盘";
        _selling.font = [UIFont systemFontOfSize:14];
        _selling.textColor = JCLAccountRGB;
        _selling.adjustsFontSizeToFitWidth = YES;
    }
    return _selling;
}
-(UILabel *)linC{
    if (!_linC) {
        _linC = [[UILabel alloc]init];
        _linC.text = @"--";
        _linC.font = [UIFont systemFontOfSize:14];
        _linC.textColor = [UIColor redColor];
        
    }
    return _linC;
}
-(UILabel *)linD{
    if (!_linD) {
        _linD = [[UILabel alloc]init];
        _linD.text = @"--";
        _linD.font = [UIFont systemFontOfSize:14];
        _linD.textColor = JCLAccountRGB;
    }
    return _linD;
}
-(UILabel *)bglinA{
    if (!_bglinA) {
        _bglinA = [[UILabel alloc]init];
        _bglinA.backgroundColor = JCL_Bg_COL;
    }
    return _bglinA;
}

-(UIButton *)buyingB{
    if (!_buyingB) {
        _buyingB = [[UIButton alloc]init];
        _buyingB.tag = 1001;
        [_buyingB setTitle:@"买入"];
        _buyingB.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buyingB setImage:[UIImage imageNamed:@"下拉按钮"] forState:0];
        [_buyingB setTitleColor:JCLRGB(197, 171, 112) forState:0];
        _buyingB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _buyingB.imageEdgeInsets = UIEdgeInsetsMake(0,JCLWIDTH/2-20, 0, 0);
        _buyingB.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    return _buyingB;
}
-(UILabel *)bglinB{
    if (!_bglinB) {
        _bglinB = [[UILabel alloc]init];
        _bglinB.backgroundColor = JCL_Bg_COL;
    }
    return _bglinB;
}

-(UIButton *)buyingC{
    if (!_buyingC) {
        _buyingC = [[UIButton alloc]init];
        _buyingC.tag = 1002;
        [_buyingC setTitle:@"限单价"];
        _buyingC.titleLabel.font = [UIFont systemFontOfSize:14];
         [_buyingC setImage:[UIImage imageNamed:@"下拉按钮"] forState:0];
        _buyingC.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _buyingC.imageEdgeInsets = UIEdgeInsetsMake(0,JCLWIDTH/2-20, 0, 0);
        _buyingC.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    }
    return _buyingC;
}

-(UILabel *)linbottom{
    if (!_linbottom) {
        _linbottom = [[UILabel alloc]init];
        _linbottom.backgroundColor = JCL_Bg_COL;
    }
    return _linbottom;
}
@end
 
