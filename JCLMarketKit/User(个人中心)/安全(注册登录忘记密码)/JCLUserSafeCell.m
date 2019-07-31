//
//  JCLUserCell.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/15.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLUserSafeCell.h"

@interface JCLUserSafeCell()
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger num;
@end

@implementation JCLUserSafeCell
+(instancetype)cellWithTable:(UITableView *)table{
    static NSString *ID = @"cell";
    JCLUserSafeCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCLUserSafeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.text = [JCLKitObj JCLField:self font:14 color:JCL_Text_COL delegate:self];
        self.line = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.code = [JCLKitObj JCLButton:self img:@"" size:15 target:self action:nil];
        [self.text addTarget:self action:@selector(valAction:) forControlEvents:(UIControlEventEditingChanged)];
        self.code.backgroundColor = JCLHexCol(@"#BE9E62");
        self.code.layer.cornerRadius = 4;
        self.code.title = @"获取验证码";
    }
    return self;
}
-(void)valAction:(UITextField *)field{ !self.valActionBlock ? : self.valActionBlock(field.text); }

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 14, w = self.width-2*x, lineH = 1.4;
    
    if (self.isCode) {
        CGSize size = [JCLKitObj JCLTextSize:self.code.title font:self.code.titleLabel.font];
        CGFloat codeW = size.width+x, codeH = size.height+10;
        self.code.frame = CGRectMake(self.width-codeW-x, 0.5*(self.height-codeH-lineH), codeW, codeH);
        w = self.code.x -2*x;
    }
    self.text.frame = CGRectMake(x, 0, w, self.height-lineH);
    self.line.frame = CGRectMake(x, self.text.maxY, w, lineH);

    UILabel *label = [self.text valueForKeyPath:@"_placeholderLabel"];
    label.textColor = JCLHexCol(@"#646564");
}

-(void)codeAction{
    self.num = 60; self.code.title = @"已发送(60)"; self.code.enabled = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}
- (void)timerAction{
    if (self.num != 0) { self.code.title = [NSString stringWithFormat:@"已发送(%zd)", --self.num]; return; }
    self.num = 0; self.code.title = @"重新获取"; self.code.enabled = YES; [self.timer invalidate]; self.timer = nil;
}
@end
