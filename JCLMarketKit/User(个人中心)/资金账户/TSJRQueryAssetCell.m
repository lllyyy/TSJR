//
//  TSJRQueryAssetCell.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/4/25.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import "TSJRQueryAssetCell.h"
#import "JCLWapList.h"
@implementation TSJRQueryAssetCell

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
    [self addSubview:self.imagV];
    [self addSubview:self.titleLB];
    [self addSubview:self.subTitle];
    
    [self addSubview:self.imagVA];
    [self addSubview:self.titleLBA];
    [self addSubview:self.subTitleA];
    
    [self addSubview:self.imagVB];
    [self addSubview:self.titleLBB];
    [self addSubview:self.subTitleB];
    
    [self addSubview:self.openAccount];
    
    [self.imagV mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(20);
         make.top.mas_equalTo(20);
         make.width.mas_equalTo(40);
         make.height.mas_equalTo(40);
    }];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagV.mas_right).offset(10);
        make.top.mas_equalTo(23);
        make.height.mas_equalTo(15);
    }];
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagV.mas_right).offset(10);
        make.top.mas_equalTo(self.titleLB.mas_bottom).offset(3);
        make.height.mas_equalTo(15);
    }];
    
    [self.imagVA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.imagV.mas_bottom).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    [self.titleLBA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagVA.mas_right).offset(10);
        make.top.mas_equalTo(self.imagVA.mas_top).offset(3);
        make.height.mas_equalTo(15);
    }];
    [self.subTitleA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagVA.mas_right).offset(10);
        make.top.mas_equalTo(self.titleLBA.mas_bottom).offset(3);
        make.height.mas_equalTo(15);
    }];
    
    
    [self.imagVB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.imagVA.mas_bottom).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    [self.titleLBB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagVB.mas_right).offset(10);
        make.top.mas_equalTo(self.imagVB.mas_top).offset(3);
        make.height.mas_equalTo(15);
    }];
    [self.subTitleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagVB.mas_right).offset(10);
        make.top.mas_equalTo(self.titleLBB.mas_bottom).offset(3);
        make.height.mas_equalTo(15);
    }];
    
    [self.openAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
         make.height.mas_equalTo(45);
    }];
}
  
-(UIImageView *)imagV{
    if (!_imagV) {
        _imagV = [[UIImageView alloc]init];
        _imagV.image = [UIImage imageNamed:@"值得信赖"];
 
    }
    return _imagV;
}
-(UILabel *)titleLB{
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.text = @"值得信赖";
        _titleLB.textColor = [UIColor whiteColor];
        _titleLB.font = [UIFont systemFontOfSize:15];
    }
    return _titleLB;
}
-(UILabel *)subTitle{
    if (!_subTitle) {
        _subTitle = [[UILabel alloc]init];
        _subTitle.text = @"大品牌，安全稳定，值得信赖";
        _subTitle.textColor = [UIColor whiteColor];
        _subTitle.font = [UIFont systemFontOfSize:15];
    }
    return _subTitle;
}
-(UIImageView *)imagVA{
    if (!_imagVA) {
        _imagVA = [[UIImageView alloc]init];
        _imagVA.image = [UIImage imageNamed:@"急速交易"];
    }
    return _imagVA;
}

-(UILabel *)titleLBA{
    if (!_titleLBA) {
        _titleLBA = [[UILabel alloc]init];
        _titleLBA.text = @"极速交易";
        _titleLBA.textColor = [UIColor whiteColor];
        _titleLBA.font = [UIFont systemFontOfSize:15];
    }
    return _titleLBA;
}
-(UILabel *)subTitleA{
    if (!_subTitleA) {
        _subTitleA = [[UILabel alloc]init];
        _subTitleA.text = @"跨境专线直连交易所，毫秒级成交速度";
        _subTitleA.textColor = [UIColor whiteColor];
        _subTitleA.font = [UIFont systemFontOfSize:15];
    }
    return _subTitleA;
}
-(UIImageView *)imagVB{
    if (!_imagVB) {
        _imagVB = [[UIImageView alloc]init];
        _imagVB.image = [UIImage imageNamed:@"智能交易"];
    }
    return _imagVB;
}

-(UILabel *)titleLBB{
    if (!_titleLBB) {
        _titleLBB = [[UILabel alloc]init];
        _titleLBB.text = @"智能交易";
        _titleLBB.textColor = [UIColor whiteColor];
        _titleLBB.font = [UIFont systemFontOfSize:15];
    }
    return _titleLBB;
}
-(UILabel *)subTitleB{
    if (!_subTitleB) {
        _subTitleB = [[UILabel alloc]init];
        _subTitleB.text = @"智能寻价算法保证成交价格最低";
        _subTitleB.textColor = [UIColor whiteColor];
        _subTitleB.font = [UIFont systemFontOfSize:15];
    }
    return _subTitleB;
}

-(UIButton *)openAccount{
    if (!_openAccount) {
        _openAccount = [[UIButton alloc]init];
        _openAccount.titleLabel.font = [UIFont systemFontOfSize:14];
        [_openAccount setTitle:@"马上开户" forState:0];
        _openAccount.backgroundColor = JCLFallRGB;
        _openAccount.layer.masksToBounds = YES;
        _openAccount.layer.cornerRadius = 5;
        [_openAccount addTarget:self action:@selector(openAccountBtn)];
        
    }
    return _openAccount;
} 

-(void)openAccountBtn{
    if (name().length == 0){ JCLLOGIN; return; };
    JCLWapList *list = [[JCLWapList alloc]init];
    list.name = @"立即开户";
    
    list.url = [NSString stringWithFormat:@"https://itiger.com/accounts?invite=ZHANGJIAN"];
    
    [[JCLKitObj rootVC].navigationController pushViewController:list animated:YES];
}
@end
