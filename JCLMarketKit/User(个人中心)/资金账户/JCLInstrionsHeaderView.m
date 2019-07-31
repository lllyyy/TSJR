//
//  JCLInstrionsHeaderView.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/21.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLInstrionsHeaderView.h"
 
@interface JCLInstrionsHeaderView()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLInstrionsHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Cell_COL;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.title];
//    [self.title addSubview:self.more];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(self);
    }];
    
//    [self.more mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(10);
//        make.right.mas_equalTo(-30);
//        make.width.mas_equalTo(15);
//        make.height.mas_equalTo(15);
//    }];
}



-(UIButton *)title{
    if (!_title) {
        _title = [[UIButton alloc]init];
        _title.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _title.color = JCL_Text_COL;
 
        _title.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_title setImage:[UIImage imageNamed:@"ic_drop_down"] forState:0];
//        _title.imageEdgeInsets = UIEdgeInsetsMake(0, kScreenWidth - 45, 0, 0);
//        _title.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_title addTarget:self action:@selector(infoAction:) forControlEvents:UIControlEventTouchUpInside];
        _title.layer.masksToBounds = YES;
    }
    return _title;
}

-(UIImageView *)more{
    if (!_more) {
        _more = [[UIImageView alloc]init];
       
        _more.hidden = YES;
    }
    return _more;
}

-(void)infoAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
   
    
    
    
    !self.infoActionBlock ? : self.infoActionBlock(sender);
    
}


@end
