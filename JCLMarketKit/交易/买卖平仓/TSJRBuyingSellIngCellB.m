//
//  TSJRBuyingSellIngCellB.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/15.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRBuyingSellIngCellB.h"

@implementation TSJRBuyingSellIngCellB

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = JCL_Cell_COL;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.titleA];
    [self addSubview:self.changeQuantityView];
    [self addSubview:self.linbottom];
    
    [self.titleA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
       make.height.mas_equalTo(15);
    }];
    [self.changeQuantityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(self.titleA.mas_right).offset(50);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(35);
    }];
    [self.linbottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}
-(UILabel *)titleA{
    if (!_titleA) {
        _titleA = [[UILabel alloc]init];
        _titleA.text = @"限价";
        _titleA.font = [UIFont systemFontOfSize:14];
        _titleA.textColor = JCLAccountRGB;
        
    }
    return _titleA;
}
 
- (MMChangeQuantityView *)changeQuantityView {
    if (!_changeQuantityView) {
        _changeQuantityView = [[MMChangeQuantityView alloc] init];
        _changeQuantityView.textField.text = @"0.0";
        _changeQuantityView.whichCell = @"MMUsageDosageCell";
    }
    return _changeQuantityView;
}
-(UILabel *)linbottom{
    if (!_linbottom) {
        _linbottom = [[UILabel alloc]init];
        _linbottom.backgroundColor = JCL_Bg_COL;
    }
    return _linbottom;
}
@end
