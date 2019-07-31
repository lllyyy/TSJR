//
//  TSJRMarketOptionListCell.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/20.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRMarketOptionListCell.h"

@implementation TSJRMarketOptionListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = JCL_Cell_COL;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}
-(void)setUI{
     [self addSubview:self.codeTypeLB];
     [self addSubview:self.afterLB];
     [self addSubview:self.codeNameLB];
     [self addSubview:self.codeLB];
     [self addSubview:self.priceLB];
     [self addSubview:self.afterPriceLB];
     [self addSubview:self.appliesLB];
     [self addSubview:self.afterAppliesLB];
     [self addSubview:self.linA];
    
    [self.codeTypeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(11);
        make.left.mas_equalTo(2);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(13);
    }];
    [self.afterLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeTypeLB.mas_bottom).offset(9);
        make.left.mas_equalTo(2);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(13);
    }];
    
    [self.codeNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.codeTypeLB.mas_right).offset(3);
        make.width.mas_equalTo((JCLWIDTH -50)/2);
        make.height.mas_equalTo(15);
    }];
    [self.codeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeTypeLB.mas_bottom).offset(7);
        make.left.mas_equalTo(self.afterLB.mas_right).offset(3);
        make.height.mas_equalTo(15);
    }];
    
    [self.appliesLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    [self.afterAppliesLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.appliesLB.mas_bottom).offset(7);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(self.appliesLB.mas_left).offset(-30);
         make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    [self.afterPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLB.mas_bottom).offset(7);
        make.right.mas_equalTo(self.afterAppliesLB.mas_left).offset(-30);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.linA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

-(UIImageView *)codeTypeLB{
    if (!_codeTypeLB) {
        _codeTypeLB = [[UIImageView alloc]init];
        _codeTypeLB.contentMode = UIViewContentModeScaleAspectFill;
        _codeTypeLB.image = [UIImage imageNamed:@"US"];
//        _codeTypeLB.font = [UIFont systemFontOfSize:10];
//        _codeTypeLB.textColor = JCLAccountRGB;
//        _codeTypeLB.text = @"US";
//        _codeTypeLB.backgroundColor =  [UIColor blueColor];
//        _codeTypeLB.layer.cornerRadius = 3;
//        _codeTypeLB.layer.masksToBounds = YES;
//        _codeTypeLB.textAlignment =NSTextAlignmentCenter;
    }
    return _codeTypeLB;
}

-(UILabel *)afterLB{
    if (!_afterLB) {
        _afterLB = [[UILabel alloc]init];
        _afterLB.font = [UIFont systemFontOfSize:8];
        _afterLB.textColor = [UIColor whiteColor];
        _afterLB.backgroundColor =  JCLAccountRGB;
        _afterLB.layer.cornerRadius = 3;
        _afterLB.layer.masksToBounds = YES;
        _afterLB.textAlignment =NSTextAlignmentCenter;
    }
    return _afterLB;
}

-(UILabel *)codeNameLB{
    if (!_codeNameLB) {
        _codeNameLB = [[UILabel alloc]init];
        _codeNameLB.font = [UIFont systemFontOfSize:15];
        _codeNameLB.textColor = [UIColor whiteColor];
        _codeNameLB.text = @"US";
      
    }
    return _codeNameLB;
}

-(UILabel *)codeLB{
    if (!_codeLB) {
        _codeLB = [[UILabel alloc]init];
        _codeLB.font = [UIFont systemFontOfSize:15];
        _codeLB.textColor = JCLAccountRGB;
        _codeLB.text = @"APPL";
        
    }
    return _codeLB;
}

-(UILabel *)priceLB{
    if (!_priceLB) {
        _priceLB = [[UILabel alloc]init];
        _priceLB.font = [UIFont systemFontOfSize:16];
        _priceLB.textColor = [UIColor whiteColor];
        _priceLB.text = @"37.24";
        _priceLB.textAlignment = NSTextAlignmentRight;
     }
    return _priceLB;
}
-(UILabel *)afterPriceLB{
    if (!_afterPriceLB) {
        _afterPriceLB = [[UILabel alloc]init];
        _afterPriceLB.font = [UIFont systemFontOfSize:13];
        _afterPriceLB.textColor = JCLAccountRGB;
         _afterPriceLB.textAlignment = NSTextAlignmentRight;
    }
    return _afterPriceLB;
}


-(UILabel *)appliesLB{
    if (!_appliesLB) {
        _appliesLB = [[UILabel alloc]init];
        _appliesLB.font = [UIFont systemFontOfSize:16];
        _appliesLB.textColor = [UIColor redColor];
        _appliesLB.text = @"-1.69%";
        _appliesLB.textAlignment = NSTextAlignmentRight;
    }
    return _appliesLB;
}
-(UILabel *)afterAppliesLB{
    if (!_afterAppliesLB) {
        _afterAppliesLB = [[UILabel alloc]init];
        _afterAppliesLB.font = [UIFont systemFontOfSize:13];
        _afterAppliesLB.textColor = JCLAccountRGB;
        _afterAppliesLB.text = @"-0.69%";
         _afterAppliesLB.textAlignment = NSTextAlignmentRight;
    }
    return _afterAppliesLB;
}
-(UILabel *)linA{
    if (!_linA) {
        _linA = [[UILabel alloc]init];
        _linA.backgroundColor = JCL_Line_COL;
    }
    return _linA;
}

-(void)setDataModel:(TSJRMarketOptionListModel *)model{
 
    self.codeNameLB.text = model.cn_name;  //[NSString stringWithFormat:@"%@",[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:model.symbol]];
    self.codeLB.text = model.symbol;
    self.priceLB.text = [NSString stringWithFormat:@"%.2f",model.price.floatValue];//[NSString stringWithFormat:@"%.2f",model.latestPrice.floatValue];
//    NSString *range = [JCLMarketObj JCLMarketRange:model.close close:model.preClose];
//    self.appliesLB.text = [JCLMarketObj JCLMarketScale:range  close:model.preClose];//涨跌幅
     self.appliesLB.text =  [JCLMarketObj JCLMarketPercent:model.percent];
    if ([self.appliesLB.text containsString:@"+"]) {
        self.appliesLB.textColor =RoseColor;
    }else if([self.appliesLB.text containsString:@"-"]){
        self.appliesLB.textColor  = FallColor;
    }else{
        self.appliesLB.textColor  =GreyColor;
    }
    
    if (model.hourTrading != nil) {
        self.afterLB.hidden = NO;
        self.afterPriceLB.hidden = NO;
        self.afterAppliesLB.hidden = NO;
        [self.appliesLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
        }];
        
        [self.priceLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
        }];
        [self.afterPriceLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.priceLB.mas_bottom).offset(7);
        }];
        [self.afterAppliesLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.appliesLB.mas_bottom).offset(7);
         }];
        
        self.afterLB.text = model.hourTrading.tag;//盘后
        self.afterPriceLB.text = [NSString stringWithFormat:@"%.2f",model.hourTrading.latestPrice.floatValue];
        NSString *rangeA = [JCLMarketObj JCLMarketRange:model.hourTrading.latestPrice close:model.hourTrading.preClose];
        self.afterAppliesLB.text = [JCLMarketObj JCLMarketScale:rangeA  close:model.hourTrading.preClose];//涨跌幅
     }else{
        self.afterLB.hidden = YES;
        self.afterPriceLB.hidden = YES;
        self.afterAppliesLB.hidden = YES;
        [self.appliesLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(22);
         }];
        [self.priceLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(22);
        }];
    }
    
    if ([model.symbol isEqualToString:@".DJI"]) {
        self.codeNameLB.text = @"道琼斯";
    }else if ([model.symbol isEqualToString:@".IXIC"]){
        self.codeNameLB.text = @"纳斯达克";
    }else if ([model.symbol isEqualToString:@".INX"]){
        self.codeNameLB.text = @"标普";
    }
    
    
    UIColor *colorA = [JCLMarketObj TSJRMarketColorA:[NSString stringWithFormat:@"%.2f",model.latestPrice.floatValue-model.preClose.floatValue]];
    
    self.appliesLB.textColor = colorA;
 
//     UIColor *colorB= [JCLMarketObj TSJRMarketColorA:model.latestPrice];
//    self.priceLB.textColor = colorB;
}


@end
