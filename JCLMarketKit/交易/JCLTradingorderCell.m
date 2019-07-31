//
//  JCLTradingorderCell.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/3.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "JCLTradingorderCell.h"

@implementation JCLTradingorderCell

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
    
    [self addSubview:self.footView];
    
    
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
    
    
    [self.titleC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo((JCLWIDTH-80)/2);
        make.height.mas_equalTo(15);
    }];
    [self.titleH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleC.mas_bottom).offset(10);
        make.left.mas_equalTo((kScreenWidth-40)/2);
        make.height.mas_equalTo(15);
    }];
     
    [self.titleF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(15);
    }];
    [self.titleG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleF.mas_bottom).offset(10);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(15);
    }];
    
    
    
    [self.titleD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(self.titleF.mas_left).offset(-40);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleD.mas_bottom).offset(10);
        make.right.mas_equalTo(self.titleF.mas_left).offset(-40);
        make.height.mas_equalTo(15);
    }];
    
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(55);
    }];
}



-(UILabel *)titleA{
    if (!_titleA) {
        _titleA = [[UILabel alloc]init];
        _titleA.font = [UIFont systemFontOfSize:14];
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
        _titleC.font = [UIFont systemFontOfSize:14];
        _titleC.textColor = [UIColor orangeColor];
    }
    return _titleC;
}

-(UILabel *)titleD{
    if (!_titleD) {
        _titleD = [[UILabel alloc]init];
        _titleD.font = [UIFont systemFontOfSize:14];
        _titleD.textColor = [UIColor whiteColor];
        _titleD.textAlignment = NSTextAlignmentRight;
      }
    return _titleD;
}
-(UILabel *)titleE{
    if (!_titleE) {
        _titleE = [[UILabel alloc]init];
        _titleE.textAlignment = NSTextAlignmentRight;
        _titleE.font = [UIFont systemFontOfSize:14];
        _titleE.textColor =JCLAccountRGB;
    
    }
    return _titleE;
}

-(UILabel *)titleF{
    if (!_titleF) {
        _titleF = [[UILabel alloc]init];
        _titleF.font = [UIFont systemFontOfSize:14];
        _titleF.textColor = [UIColor whiteColor];
    }
    return _titleF;
}
-(UILabel *)titleG{
    if (!_titleG) {
        _titleG = [[UILabel alloc]init];
        _titleG.font = [UIFont systemFontOfSize:14];
        _titleG.textColor = JCLAccountRGB;
     
    }
    return _titleG;
}
-(UILabel *)titleH{
    if (!_titleH) {
        _titleH = [[UILabel alloc]init];
        _titleH.font = [UIFont systemFontOfSize:14];
        _titleH.textColor = [UIColor whiteColor];;
        _titleH.textAlignment = NSTextAlignmentRight;
       
    }
    return _titleH;
}
-(JCLTradingFootHiderView *)footView{
    if (!_footView) {
        _footView = [[JCLTradingFootHiderView alloc]init];
    }
    return _footView;
}



-(void)setTradingOrderModel:(id)idModel{
 
    if ([idModel isKindOfClass:[JCLTradingOrderModel class]]) {
        JCLTradingOrderModel *model = idModel;
        self.titleB.text =  [NSString stringWithFormat:@"%@",model.symbol];
        self.titleC.text =  [NSString stringWithFormat:@"%@", [JCLKitObj actionType:model.action]];
        if ([self.titleC.text isEqualToString:@"买入"]) {
            self.titleC.textColor = RoseColor;
        }else{
            self.titleC.textColor = FallColor;
        }
        
        self.titleD.text =  [NSString stringWithFormat:@"%@",model.totalQuantity];
        self.titleE.text =  [JCLKitObj countNumAndChangeformat:model.avgFillPrice];
        if (model.openTime.length>10) {
            self.titleF.text =  [[JCLKitObj timeStampString:model.openTime] substringWithRange:NSMakeRange(5, 5)];
            self.titleG.text =  [[JCLKitObj timeStampString:model.openTime] substringFromIndex:10];
        }
    }else{
        TSJRQueryPositionModel *model = idModel;
        self.titleA.text =  [NSString stringWithFormat:@"%@",[[AppDelegate shareAppDelegate].messageNoticeStore fetchMessage:model.symbol]];
        self.titleB.text =  [NSString stringWithFormat:@"%@",model.symbol];
        
        self.titleC.text =  [NSString stringWithFormat:@"%@",model.multiplier];
        self.titleH.text =  [NSString stringWithFormat:@"%.2f",model.averageCost.floatValue];
        
         self.titleD.text =  [NSString stringWithFormat:@"%.2f",model.position.floatValue];
        self.titleE.text =  [NSString stringWithFormat:@"%@",model.averageCost];
        
        self.titleF.text = [NSString stringWithFormat:@"%@",[JCLKitObj moneyFormat: model.unrealizedPnl]];
        self.titleG.text =  @"+10%";
       }
    
    
   
}

@end
