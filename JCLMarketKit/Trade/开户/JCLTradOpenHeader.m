//
//  JCLTradOpenHeader.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/29.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradOpenHeader.h"
#import "JCLKitModel.h"

@interface JCLTradOpenHeader()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, weak) UIView *line;

@property (nonatomic, weak) UIView *bg1;
@property (nonatomic, weak) UILabel *text1;
@property (nonatomic, weak) UIView *bg2;
@property (nonatomic, weak) UILabel *text2;
@property (nonatomic, weak) UIView *bg3;
@property (nonatomic, weak) UILabel *text3;
@property (nonatomic, weak) UIView *bg4;
@property (nonatomic, weak) UILabel *text4;
@end

@implementation JCLTradOpenHeader
-(instancetype)init{
    if(self = [super init]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCLHexCol(@"#69696C")];
        self.line = [JCLKitObj JCLView:self color:JCL_SelText_COL];
        
        self.bg1 = [JCLKitObj JCLView:self color:JCL_SelText_COL];
        self.text1 = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.bg2 = [JCLKitObj JCLView:self color:JCLHexCol(@"#69696C")];
        self.text2 = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.bg3 = [JCLKitObj JCLView:self color:JCLHexCol(@"#69696C")];
        self.text3 = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.bg4 = [JCLKitObj JCLView:self color:JCLHexCol(@"#69696C")];
        self.text4 = [JCLKitObj JCLLable:self font:13 color:JCL_Text_COL alignment:1];
        self.text1.text = @"开户"; self.text2.text = @"签署文件"; self.text3.text = @"审核"; self.text4.text = @"交易";
        self.bg1.layer.borderWidth = 4, self.bg2.layer.borderWidth = 4, self.bg3.layer.borderWidth = 4; self.bg4.layer.borderWidth = 4;
        self.bg1.layer.borderColor = JCLHexCol(@"#524427").CGColor,
        self.bg2.layer.borderColor = JCLHexCol(@"#353537").CGColor,
        self.bg3.layer.borderColor = JCLHexCol(@"#353537").CGColor;
        self.bg4.layer.borderColor = JCLHexCol(@"#353537").CGColor;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 14, wh = [JCLKitObj JCLHeight:32], y = 0.5*(2*wh);
    self.bg.frame = CGRectMake(x, y+0.5*(wh-self.bg.height), self.width-2*x, 2);
    self.line.frame = CGRectMake(x, self.bg.y, 0.2*self.bg.width, 2);
    if ([self.type isEqualToString:@"1"]) {
        self.line.width = 0.5*self.bg.width;
    }
    if ([self.type isEqualToString:@"2"]) {
        self.line.width = 0.7*self.bg.width;
    }
    if ([self.type isEqualToString:@"3"]) {
        self.line.width = self.bg.width;
    }

    self.bg1.frame = CGRectMake(x, y, wh, wh);
    CGFloat bgX = self.bg.width/4;
    self.bg2.frame = CGRectMake(self.bg1.maxX-0.5*wh+bgX, self.bg1.y, wh, wh);
    self.bg3.frame = CGRectMake(self.bg2.maxX-0.5*wh+bgX, self.bg1.y, wh, wh);
    self.bg4.frame = CGRectMake(self.width-wh-x, self.bg1.y, wh, wh);
    self.bg1.layer.cornerRadius = 0.5*wh; self.bg2.layer.cornerRadius = 0.5*wh;
    self.bg3.layer.cornerRadius = 0.5*wh; self.bg4.layer.cornerRadius = 0.5*wh;

    CGFloat textW = 0.3*self.width;
    self.text1.frame = CGRectMake(self.bg1.centerX-0.5*textW, self.bg1.maxY, textW, wh);
    self.text2.frame = CGRectMake(self.bg2.centerX-0.5*textW, self.bg1.maxY, textW, wh);
    self.text3.frame = CGRectMake(self.bg3.centerX-0.5*textW, self.bg1.maxY, textW, wh);
    self.text4.frame = CGRectMake(self.bg4.centerX-0.5*textW, self.bg1.maxY, textW, wh);
}

-(void)setType:(NSString *)type{
    _type = type;
    [self layoutSubviews];
    if ([type isEqualToString:@"1"]) {
        self.bg2.backgroundColor = JCL_SelText_COL;
        self.bg2.layer.borderColor = JCLHexCol(@"#524427").CGColor;
    }
    
    if ([type isEqualToString:@"2"]) {
        self.bg3.backgroundColor = JCL_SelText_COL;
        self.bg3.layer.borderColor = JCLHexCol(@"#524427").CGColor;
        self.bg2.backgroundColor = JCL_SelText_COL;
        self.bg2.layer.borderColor = JCLHexCol(@"#524427").CGColor;
    }
    
    if ([type isEqualToString:@"3"]) {
        self.bg4.backgroundColor = JCL_SelText_COL;
        self.bg4.layer.borderColor = JCLHexCol(@"#524427").CGColor;
        self.bg3.backgroundColor = JCL_SelText_COL;
        self.bg3.layer.borderColor = JCLHexCol(@"#524427").CGColor;
        self.bg2.backgroundColor = JCL_SelText_COL;
        self.bg2.layer.borderColor = JCLHexCol(@"#524427").CGColor;
    }
}
@end
