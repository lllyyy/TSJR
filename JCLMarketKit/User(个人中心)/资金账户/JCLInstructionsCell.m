//
//  JCLInstructionsCell.m
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/21.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import "JCLInstructionsCell.h"

@implementation JCLInstructionsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Cell_COL;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
        self.layer.masksToBounds = YES;
    }
    return self;
}

-(void)setUI{
 
    [self addSubview:self.title];
     
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(self);
    }];
    
     
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"老虎模拟账户  单位USD";
        _title.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        _title.textColor = JCLAccountRGB;
        _title.numberOfLines = 0;
        _title.adjustsFontSizeToFitWidth = YES;
    }
    return _title;
}

@end
