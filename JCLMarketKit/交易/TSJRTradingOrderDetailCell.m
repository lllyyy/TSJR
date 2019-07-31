//
//  TSJRTradingOrderDetailCell.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/14.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRTradingOrderDetailCell.h"

@implementation TSJRTradingOrderDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Cell_COL;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
        
    }
    return self;
}

-(void)setUI{
     
    [self addSubview:self.titleA];
    [self addSubview:self.titleB];
    [self addSubview:self.titleC];
    [self addSubview:self.titleD];
    
    
    [self.titleA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.titleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.centerX.mas_equalTo(self.mas_centerX).offset(-40);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(70);
        make.centerX.mas_equalTo(self.mas_centerX).offset(60);
        make.height.mas_equalTo(15);
    }];
   
    [self.titleD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(15);
    }];
    
} 

-(UILabel *)titleA{
    if (!_titleA) {
        _titleA = [[UILabel alloc]init];
        _titleA.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 15];;
        _titleA.textColor = JCLAccountRGB;
    }
    return _titleA;
}
-(UILabel *)titleB{
    if (!_titleB) {
        _titleB = [[UILabel alloc]init];
        _titleB.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 15];;
        _titleB.textColor = [UIColor whiteColor];
        _titleB.textAlignment =NSTextAlignmentRight;
    }
    return _titleB;
}
-(UILabel *)titleC{
    if (!_titleC) {
        _titleC = [[UILabel alloc]init];
        _titleC.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 15];;
        _titleC.textColor = JCLAccountRGB;
        _titleC.textAlignment=NSTextAlignmentLeft;
    }
    return _titleC;
}
-(UILabel *)titleD{
    if (!_titleD) {
        _titleD = [[UILabel alloc]init];
        _titleD.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 15];;
        _titleD.textColor = [UIColor whiteColor];
    }
    return _titleD;
}
@end
