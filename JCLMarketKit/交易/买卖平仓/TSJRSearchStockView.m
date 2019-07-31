//
//  TSJRSearchStockView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/19.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRSearchStockView.h"

@implementation TSJRSearchStockView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JCL_Cell_COL;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.stockCodeLB];
     [self addSubview:self.codeFiled];
     [self addSubview:self.findCodeBtn];
     [self addSubview:self.linA];
     [self addSubview:self.usCode];
     [self addSubview:self.stockName];
     [self addSubview:self.stockindex];
     [self addSubview:self.profitLB];
    
    [self.stockCodeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.codeFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.stockCodeLB.mas_right).offset(10);
        make.width.mas_offset(130);
        make.height.mas_equalTo(45);
    }];
    [self.findCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-15);
        make.width.mas_offset(60);
        make.height.mas_equalTo(25);
    }];
    [self.linA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeFiled.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.usCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.linA.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.left.width.mas_offset(40);
        make.height.mas_equalTo(15);
    }];
    [self.stockName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.linA.mas_bottom).offset(10);
        make.left.mas_equalTo(self.usCode.mas_right).offset(5);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
    }];
 
    [self.profitLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.linA.mas_bottom).offset(10);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(15);
    }];
    
    [self.stockindex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.linA.mas_bottom).offset(10);
        make.right.mas_equalTo(self.profitLB.mas_left).offset(-20);
        make.height.mas_equalTo(15);
    }];
}
-(UILabel *)stockCodeLB{
    if (!_stockCodeLB) {
        _stockCodeLB = [[UILabel alloc]init];
        _stockCodeLB.text = @"股票代码";
        _stockCodeLB.font = [UIFont systemFontOfSize:14];
        _stockCodeLB.textColor = JCLAccountRGB;
        _stockCodeLB.adjustsFontSizeToFitWidth = YES;
    }
    return _stockCodeLB;
}

-(UILabel *)codeFiled{
    if (!_codeFiled) {
        _codeFiled = [[UILabel alloc]init];
//        _codeFiled.text = @"股票代码";
        _codeFiled.font = [UIFont systemFontOfSize:15];
        _codeFiled.textColor = [UIColor whiteColor];;
        _codeFiled.adjustsFontSizeToFitWidth = YES;
    }
    return _codeFiled;
}

//-(UITextField *)codeFiled{
//    if (!_codeFiled) {
//        _codeFiled = [[UITextField alloc]init];
//       _codeFiled.font = [UIFont systemFontOfSize:15];
//       _codeFiled.textAlignment = NSTextAlignmentLeft;
//       _codeFiled.textColor = [UIColor whiteColor];
////        _codeFiled.placeholder= @"请输入股票代码";
//       [_codeFiled setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
////       _codeFiled.keyboardType = UIKeyboardTypeNumberPad;
//
//
//    }
//    return _codeFiled;
//}


-(UIButton *)findCodeBtn{
    if (!_findCodeBtn) {
        _findCodeBtn = [[UIButton alloc]init];
        _findCodeBtn.tag = 1;
        [_findCodeBtn setTitle:@"查找" forState:0];
        [_findCodeBtn setTitleColor:[UIColor whiteColor] forState:0];
        _findCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_findCodeBtn setImage:[UIImage imageNamed:@"输入框_搜索"] forState:0];//刷新成功
        _findCodeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _findCodeBtn.layer.cornerRadius = 5;
        _findCodeBtn.layer.masksToBounds =YES;
        _findCodeBtn.layer.borderWidth = 1;
        _findCodeBtn.layer.borderColor = JCLRGB(197, 171, 112).CGColor;
    }
   return _findCodeBtn;
}
-(UILabel *)linA{
    if (!_linA) {
        _linA = [[UILabel alloc]init];
        _linA.backgroundColor = JCL_Bg_COL;
    }
    return _linA;
}

-(UILabel *)usCode{
    if (!_usCode) {
        _usCode = [[UILabel alloc]init];
        _usCode.text = @"美股";
        _usCode.font = [UIFont systemFontOfSize:12];
        _usCode.textColor = [UIColor whiteColor];
        _usCode.backgroundColor = UIColorHex(84C1FF);
        _usCode.layer.cornerRadius = 3;
        _usCode.layer.masksToBounds =YES;
        _usCode.textAlignment = NSTextAlignmentCenter;
        _usCode.adjustsFontSizeToFitWidth = YES;
    }
    return _usCode;
}

-(UILabel *)stockName{
    if (!_stockName) {
        _stockName = [[UILabel alloc]init];
        _stockName.font = [UIFont systemFontOfSize:14];
        _stockName.textColor = JCLAccountRGB;
        _stockName.textAlignment = NSTextAlignmentLeft;
      
    }
    return _stockName;
}

-(UILabel *)stockindex{
    if (!_stockindex) {
        _stockindex = [[UILabel alloc]init];
        _stockindex.font = [UIFont systemFontOfSize:14];
        _stockindex.textAlignment = NSTextAlignmentCenter;
    
    }
    return _stockindex;
}
-(UILabel *)profitLB{
    if (!_profitLB) {
        _profitLB = [[UILabel alloc]init];
 
        _profitLB.font = [UIFont systemFontOfSize:14];
        _profitLB.textColor = [UIColor redColor];
        
         _profitLB.textAlignment = NSTextAlignmentRight;
    }
    return _profitLB;
}
@end
