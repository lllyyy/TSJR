//
//  JCLTableInfoCell.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTableInfoCell.h"

@interface JCLTableInfoCell()
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger num;
@end

@implementation JCLTableInfoCell
+(instancetype)cellWithTable:(UITableView *)table{
    static NSString *ID = @"cell";
    JCLTableInfoCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    cell = [[JCLTableInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.title = [JCLKitObj JCLLable:self font:15 color:JCL_Text_COL alignment:0];
        self.unit = [JCLKitObj JCLLable:self font:15 color:nil alignment:0];
        
        self.text = [JCLKitObj JCLField:self font:15 color:JCL_Text_COL delegate:self];
        [self.text addTarget:self action:@selector(valAction:) forControlEvents:(UIControlEventEditingChanged)];
        
        //
        self.submit = [JCLKitObj JCLButton:self img:@"下一页" size:14 target:self action:@selector(action)];
        self.phone = [JCLKitObj JCLImage:self];
        self.phone.image = [UIImage imageNamed:@""];
        
        self.code = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:nil];
      
    }
    return self;
}
-(void)action{ !self.actionBlock ? : self.actionBlock(); }
-(void)valAction:(UITextField *)field{ !self.valActionBlock ? : self.valActionBlock(field.text); }

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat s = 20, w = 0.2*self.width, y = 0, h = self.height - 1;
    if (self.lineH>0) {
        h -= self.lineH;
    }
    self.bg.frame = CGRectMake(0, y, self.width, h);
    self.title.frame = CGRectMake(s, y, w+50*JCLWIDTH/375, h);
    CGFloat textW = self.width - 2*s;
    
    CGFloat wh = h-2*8;
    if (self.isRight) {
        self.text.textAlignment = 2;
    }
    
    if (self.isPhone) {
        self.submit.frame = CGRectMake(JCLWIDTH - 33, 65/2, 15, 15);
        self.phone.frame = CGRectMake(self.width - 65-30, 12, 50, 50);
        self.phone.layer.cornerRadius = 0.5*50;
        
    } else {
        if (!self.unit.text.length) {
            if (!self.text.enabled) {
                self.submit.frame = CGRectMake(self.width - h, y, h, h);
                self.text.frame = CGRectMake(self.title.maxX, y, self.submit.x-self.title.maxX+6, h);
            } else {
                self.text.frame = CGRectMake(self.title.maxX, y, textW - w, h);
            }
        }
    }
    
    if (self.unit.text.length) {
        CGSize size = [JCLKitObj JCLStrSize:self.unit.text font:self.unit.font];
        self.unit.frame = CGRectMake(self.width-s-size.width, y, size.width, h);
        self.text.frame = CGRectMake(self.title.maxX, y, self.unit.x -6-self.title.maxX, h);
    }
    
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
