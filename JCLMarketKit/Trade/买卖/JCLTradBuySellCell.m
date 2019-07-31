//
//  JCLTradBuySellCell.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/17.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradBuySellCell.h"

@interface JCLTradBuySellCell()
@property (nonatomic, weak) UIView *bg;
@end

@implementation JCLTradBuySellCell
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.title = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:1];
        self.text = [JCLKitObj JCLField:self font:14 color:JCL_Text_COL delegate:self];
        self.text.keyboardType = UIKeyboardTypeNumberPad;
        self.text.textAlignment = 1;
        
        self.add = [JCLKitObj JCLButton:self img:@"" size:9 target:self action:nil];
        self.add.title = @" ╋\n0.01";
        self.add.titleLabel.lineBreakMode = 0;
        self.reduce = [JCLKitObj JCLButton:self img:@"" size:9 target:self action:nil];
        self.reduce.title = @" ━\n0.01";
        self.reduce.titleLabel.lineBreakMode = 0;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat y = 1;
    self.bg.frame = CGRectMake(0, y, self.width, self.height-2);
    CGFloat x = 10;
    self.title.frame = CGRectMake(x, 0, 0.2*self.width, self.bg.height);
    CGFloat wh = self.bg.height-2*x;
    if (self.isNum || self.isVol) {
        self.add.frame = CGRectMake(self.title.maxX+x, 0, wh, self.height);
        self.reduce.frame = CGRectMake(self.width-x-wh, x, wh, wh);
        self.text.frame = CGRectMake(self.add.maxX+x, 0, self.reduce.x-self.add.maxX-2*x, self.bg.height);
    } else {
        self.text.frame = CGRectMake(self.title.maxX+x, 0, self.width-self.title.maxX-2*x, self.bg.height);
    }
    if (self.isVol) {
        self.add.title = @" ╋\n100";
        self.reduce.title = @" ━\n100";
    }
    self.add.titleLabel.attributedText = [self JCLStrM:self.add.title];
    self.reduce.titleLabel.attributedText = [self JCLStrM:self.reduce.title];
    
    UILabel *label = [self.text valueForKeyPath:@"_placeholderLabel"];
    label.textColor = JCLHexCol(@"#646564");
}

-(NSAttributedString *)JCLStrM:(NSString *)val{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 10;
    
    NSDictionary *obj = @{NSParagraphStyleAttributeName:style};
    NSMutableAttributedString *add = [[NSMutableAttributedString alloc]initWithString:val];
    [add addAttribute:NSForegroundColorAttributeName
                value:JCLRISERGB
                range:NSMakeRange(1, 1)];
    [add addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:[JCLKitObj JCLSize:13]]
                range:NSMakeRange(1, 1)];
    [add addAttributes:obj range:NSMakeRange(1, val.length-1)];
    return add;
}
@end
