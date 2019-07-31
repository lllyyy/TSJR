//
//  JCLTradeKeyboard.m
//  JCLFutures
//
//  Created by 邢昭俊 on 2017/9/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradeKeyboard.h"

@interface JCLTradeKeyboard()
@property (nonatomic, strong) UIScrollView *scroll;
@end

@implementation JCLTradeKeyboard
-(instancetype)init{
    if (self = [super init]){
        self.backgroundColor = JCLRGB(186, 187, 188);
        self.val = [JCLKitObj JCLLable:self font:14 color:JCLRGB(112, 113, 115) alignment:0];
        self.val.backgroundColor = JCL_Cell_COL;
        self.diss = [JCLKitObj JCLButton:self img:@"jp_shou" size:14 target:self action:nil];
        self.scroll = [[UIScrollView alloc]init]; [self addSubview:self.scroll];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat vh = 0.16*self.height, s = 1;
    self.val.frame = CGRectMake(0, 0, self.width, vh);
    self.diss.frame = CGRectMake(self.width-vh, 0, vh, vh);
    
    if (!self.isCode) {
        if (!self.isPrice) {
            NSArray *vals = @[];
            CGFloat w = (self.width-s)/vals.count;
            [vals enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton *val = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:@selector(wayAction:)];
                val.frame = CGRectMake(idx*w+idx*s, vh, w, vh);
                val.title = obj; val.color = [UIColor blackColor]; val.tag = idx;
                val.backgroundColor = JCLRGB(225, 226, 228);
                [val setBackgroundImage:[self imageWithColor:JCLRGB(180, 180, 180)] forState:UIControlStateHighlighted];
            }];
        }
        NSArray *nums = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @".", @"0", @"删除"];
        NSUInteger num = 3;
        CGFloat ny = vh;
        if (!self.isPrice) {
            ny = 2*vh+1;
        }
        
        CGFloat nw = (0.74*self.width-s*(num-1))/num, nh = (self.height-ny-num*s)/(num+1);
        [nums enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *val = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:@selector(numAction:)];
            CGFloat x = nw*(idx%num) + s*(idx%num), y = nh*(idx/num) + s*(idx/num);
            val.frame = CGRectMake(x, ny+y, nw, nh);
            val.title = obj; val.color = [UIColor blackColor]; val.tag = idx;
            val.backgroundColor = JCLRGB(235, 236, 237);
            if (idx == 9 || idx == 11) {
                val.backgroundColor = JCLRGB(225, 226, 228);
            }
            if (idx == 11) {
                val.img = @"";
            }
            [val setBackgroundImage:[self imageWithColor:JCLRGB(180, 180, 180)] forState:UIControlStateHighlighted];
        }];
        
        NSArray *opts = @[];
        CGFloat oh = 0.5*(self.height-ny-s);
        [opts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *val = [JCLKitObj JCLButton:self img:@"" size:34 target:self action:@selector(optAction:)];
            val.frame = CGRectMake(0.74*self.width+s, ny+oh*idx+s*idx, 0.26*self.width-s, oh);
            val.title = obj; val.color = [UIColor blackColor]; val.tag = idx;
            val.backgroundColor = JCLRGB(225, 226, 228);
            [val setBackgroundImage:[self imageWithColor:JCLRGB(180, 180, 180)] forState:UIControlStateHighlighted];
        }];
        
    } else {
        self.scroll.frame = CGRectMake(0, vh, self.width, self.height-vh);
        NSArray *codes = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @".", @"0", @""
                           ,@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @".", @"0", @""
                           ,@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @".", @"0", @""];
        NSUInteger cs = 4;
        CGFloat cw = (self.width-s*(cs-1))/cs, ch = (self.height-vh-cs*s)/cs;
        self.scroll.contentSize = CGSizeMake(self.width, codes.count/4*(ch+s));
        [codes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *val = [JCLKitObj JCLButton:self.scroll img:@"" size:14 target:self action:@selector(valAction:)];
            CGFloat x = cw*(idx%cs) + s*(idx%cs), y = ch*(idx/cs) + s*(idx/cs);
            val.frame = CGRectMake(x, y, cw, ch);
            val.title = obj; val.color = [UIColor blackColor];
            val.backgroundColor = JCLRGB(225, 226, 228);
            [val setBackgroundImage:[self imageWithColor:JCLRGB(180, 180, 180)] forState:UIControlStateHighlighted];

        }];
    }
}

-(UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect             = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context    = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image          = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)valAction:(UIButton *)sender{ !self.valAction ? : self.valAction(sender); }
-(void)wayAction:(UIButton *)sender{ !self.wayAction ? : self.wayAction(sender); }
-(void)numAction:(UIButton *)sender{
    if (self.isPrice) {
        !self.volAction ? : self.volAction(sender);
    } else {
        !self.numAction ? : self.numAction(sender);
    }
}
-(void)optAction:(UIButton *)sender{
//    !self.optAction ? : self.optAction(sender);
}
@end
