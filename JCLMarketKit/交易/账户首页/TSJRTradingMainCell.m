//
//  TSJRTradingMainCell.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/22.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRTradingMainCell.h"
#import "TSJRQueryPositionModel.h"


@implementation TSJRTradingMainCell

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
    [self addSubview:self.titleH];
    
    [self addSubview:self.titleD];
    [self addSubview:self.titleE];
    
    [self addSubview:self.titleF];
    [self addSubview:self.titleG];
    
 
    
    
    [self.titleA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.width.mas_offset(120);
        make.height.mas_equalTo(15);
    }];
    [self.titleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleA.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    
    
    [self.titleF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleF.mas_bottom).offset(10);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    
    
    [self.titleD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(self.titleF.mas_left).offset(-25);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleD.mas_bottom).offset(10);
        make.right.mas_equalTo(self.titleF.mas_left).offset(-25);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(self.titleD.mas_left).offset(-28);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleC.mas_bottom).offset(10);
         make.right.mas_equalTo(self.titleD.mas_left).offset(-28);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    
}



-(UILabel *)titleA{
    if (!_titleA) {
        _titleA = [[UILabel alloc]init];
        _titleA.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
        _titleA.textColor = [UIColor whiteColor];
    }
    return _titleA;
}

-(UILabel *)titleB{
    if (!_titleB) {
        _titleB = [[UILabel alloc]init];
        
        _titleB.font = [UIFont systemFontOfSize:14];
        _titleB.textColor = JCLAccountRGB;
    }
    return _titleB;
}

-(UILabel *)titleC{
    if (!_titleC) {
        _titleC = [[UILabel alloc]init];
        _titleC.textAlignment = NSTextAlignmentRight;
        _titleC.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
        _titleC.textColor = [UIColor orangeColor];
 
    }
    return _titleC;
}

-(UILabel *)titleD{
    if (!_titleD) {
        _titleD = [[UILabel alloc]init];
        _titleD.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
        _titleD.textColor = [UIColor whiteColor];
        _titleD.textAlignment = NSTextAlignmentRight;
 
    }
    return _titleD;
}
-(UILabel *)titleE{
    if (!_titleE) {
        _titleE = [[UILabel alloc]init];
        _titleE.textAlignment = NSTextAlignmentRight;
        _titleE.font = [UIFont systemFontOfSize:12];
        _titleE.textColor =JCLAccountRGB;
 
    }
    return _titleE;
}

-(UILabel *)titleF{
    if (!_titleF) {
        _titleF = [[UILabel alloc]init];
 
        _titleF.font =[UIFont fontWithName:@"PingFang-SC-Medium" size: 14];
        _titleF.textColor = [UIColor whiteColor];
        _titleF.textAlignment = NSTextAlignmentRight;
    }
    return _titleF;
}
-(UILabel *)titleG{
    if (!_titleG) {
        _titleG = [[UILabel alloc]init];
        _titleG.textAlignment = NSTextAlignmentRight;
        _titleG.font = [UIFont systemFontOfSize:12];
        _titleG.textColor = JCLAccountRGB;
    }
    return _titleG;
}
-(UILabel *)titleH{
    if (!_titleH) {
        _titleH = [[UILabel alloc]init];
        _titleH.font =  [UIFont systemFontOfSize:12];
        _titleH.textColor = [UIColor whiteColor];;
        _titleH.textAlignment = NSTextAlignmentRight;
 
    }
    return _titleH;
}



-(void)setTradingOrderModel:(id)idModel{
    
        TSJRQueryPositionModel *model = idModel;
        self.titleA.text = model.stock.cn_name;  //[NSString stringWithFormat:@"%@",[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:model.symbol]];
        self.titleB.text =  [NSString stringWithFormat:@"%@",model.symbol];
        
        self.titleC.text =  [NSString stringWithFormat:@"%@",model.position];
        self.titleH.text =  [NSString stringWithFormat:@"%.2f",model.marketValue.floatValue];
        
        self.titleD.text =  [NSString stringWithFormat:@"%.2f",model.latestPrice.floatValue];
        self.titleE.text =  [NSString stringWithFormat:@"%.@",[JCLKitObj countNumAndChangeformat:model.averageCost]];
    
        self.titleF.text = [JCLKitObj countNumAndChangeformat:model.unrealizedPnl];
//    浮动盈亏   /  成本 * 持仓     X100 =  浮动盈亏比
    
        self.titleG.text =  [NSString stringWithFormat:@"%.2f%%",model.unrealizedPnl.floatValue/(model.averageCost.floatValue*model.position.intValue)*100];
    
        UIColor *color =  [JCLMarketObj TSJRMarketColor:self.titleD.text  close:self.titleE.text];
        self.titleD.textColor = color;
    
    
         UIColor *colorA = [JCLMarketObj TSJRMarketColorA:self.titleF.text];
         self.titleF.textColor = colorA;
    
        UIColor *colorB= [JCLMarketObj TSJRMarketColorA:self.titleG.text];
        self.titleG.textColor = colorB;
}
//金钱每三位加一个逗号


@end
