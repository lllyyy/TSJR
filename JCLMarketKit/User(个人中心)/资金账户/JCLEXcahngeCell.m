//
//  JCLEXcahngeCell.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/26.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLEXcahngeCell.h"
#import "JCLPickerViewPopupView.h"
#import "LewPopupViewAnimationFade.h"
@implementation JCLEXcahngeCell

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
    [self addSubview:self.line];
    [self addSubview:self.titleLBA];
    [self addSubview:self.titleLBB];
    [self addSubview:self.titleLBC];
    [self addSubview:self.lineA];
    [self addSubview:self.titleLBD];
    [self addSubview:self.moneField];
    [self addSubview:self.lineB];
    [self addSubview:self.titleLBE];
    [self addSubview:self.stateBtn];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        
    }];
    [self.titleLBA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo((kScreenWidth - 30)/3);
        make.height.mas_equalTo(45);
    }];
    [self.titleLBB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.titleLBA.mas_right).offset(0);
        make.width.mas_equalTo((kScreenWidth - 30)/3);
        make.height.mas_equalTo(45);
    }];
    [self.titleLBC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo((kScreenWidth - 30)/3);
        make.height.mas_equalTo(45);
    }];
    [self.lineA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.titleLBA.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.titleLBD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.lineA.mas_bottom).offset(15);
        make.height.mas_equalTo(15);
    }];
    [self.moneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.lineA.mas_bottom).offset(0);
        make.width.mas_equalTo(kScreenWidth - 100);
        make.height.mas_equalTo(45);
    }];
    [self.lineB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.moneField.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.titleLBE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.lineB.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
    }];
    [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.titleLBE.mas_bottom).offset(20);
        make.height.mas_equalTo(45);
    }];
}

-(UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor =JCL_Bg_COL;
    }
    return _line;
}
-(UIButton *)titleLBA{
    if (!_titleLBA) {
        _titleLBA = [[UIButton alloc]init];
        _titleLBA.titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleLBA addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        [_titleLBA setTitle:@"美元" forState:0];
        [_titleLBA setTitleColor:[UIColor whiteColor] forState:0];
        [_titleLBA setImage:[UIImage imageNamed:@""] forState:0];
        _titleLBA.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
    }
    return _titleLBA;
}
-(UIButton *)titleLBB{
    if (!_titleLBB) {
        _titleLBB = [[UIButton alloc]init];
        _titleLBB.titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleLBB setTitle:@"兑换" forState:0];
        [_titleLBB setTitleColor:JCLAccountRGB forState:0];
       
        
    }
    return _titleLBB;
}
-(UIButton *)titleLBC{
    if (!_titleLBC) {
        _titleLBC = [[UIButton alloc]init];
        _titleLBC.titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleLBC setTitle:@"美元" forState:0];
        [_titleLBC setTitleColor:[UIColor whiteColor] forState:0];
        [_titleLBC setImage:[UIImage imageNamed:@""] forState:0];
  
        _titleLBC.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentRight;
    }
    return _titleLBC;
}

-(UILabel *)lineA{
    if (!_lineA) {
        _lineA = [[UILabel alloc]init];
        _lineA.backgroundColor =JCL_Bg_COL;
    }
    return _lineA;
}
-(UILabel *)titleLBD{
    if (!_titleLBD) {
        _titleLBD = [[UILabel alloc]init];
        _titleLBD.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        _titleLBD.textColor = JCLAccountRGB;
        _titleLBD.adjustsFontSizeToFitWidth = YES;
        _titleLBD.text = @"金额";
    }
    return _titleLBD;
}
-(UITextField *)moneField{
    if (!_moneField) {
        _moneField = [[UITextField alloc]init];
        _moneField.placeholder =@"请输入金额";
        _moneField.textColor = [UIColor whiteColor];
        _moneField.font = [UIFont systemFontOfSize:14];
        _moneField.keyboardType = UIKeyboardTypeNumberPad;
        _moneField.textAlignment = NSTextAlignmentRight;
        [_moneField setValue: JCLAccountRGB forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _moneField;
}
-(UILabel *)lineB{
    if (!_lineB) {
        _lineB = [[UILabel alloc]init];
        _lineB.backgroundColor =JCL_Bg_COL;
    }
    return _lineB;
}
-(UILabel *)titleLBE{
    if (!_titleLBE) {
        _titleLBE = [[UILabel alloc]init];
        _titleLBE.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
        _titleLBE.textColor = JCLAccountRGB;
        _titleLBE.adjustsFontSizeToFitWidth = YES;
        _titleLBE.text = @"最大可兑784HKD";
    }
    return _titleLBE;
}


-(UIButton *)stateBtn{
    if (!_stateBtn) {
        _stateBtn = [[UIButton alloc]init];
        _stateBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        [_stateBtn setTitle:@"开始兑换" forState:0];
        [_stateBtn setTitleColor:JCLAccountRGB forState:0];
        _stateBtn.backgroundColor = [UIColor yellowColor];
        _stateBtn.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentCenter;
        _stateBtn.layer.cornerRadius = 5;
        _stateBtn.layer.masksToBounds = YES;
    }
    return _stateBtn;
}


-(void)popView{
    JCLPickerViewPopupView *popupView = [JCLPickerViewPopupView defaultPopupView];
    popupView.parentVC = [JCLKitObj rootVC];
    popupView.dataSource = @[@[@"美元",@"港币"],@[@"港币"],@[@"港币"]].mutableCopy;
    popupView.selectBlock  = ^(NSString *v) {
        
    };
    [[JCLKitObj rootVC] lew_presentPopupView:popupView animation:[LewPopupViewAnimationFade new] dismissed:^{
        NSLog(@"动画结束");
    }];
}

-(void)popexchangView{
    JCLPickerViewPopupView *popupView = [JCLPickerViewPopupView defaultPopupView];
     popupView.parentVC = [JCLKitObj rootVC];
    popupView.selectBlock  = ^(NSString *v) {
        
   };
   [[JCLKitObj rootVC] lew_presentPopupView:popupView animation:[LewPopupViewAnimationFade new] dismissed:^{
      NSLog(@"动画结束");
    }];
}
@end
