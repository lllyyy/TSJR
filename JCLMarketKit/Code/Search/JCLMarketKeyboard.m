//
//  XLDStockKeyboard.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2016/12/8.
//  Copyright © 2016年 ruixue. All rights reserved.
//

#import "JCLMarketKeyboard.h"

@interface JCLMarketKeyboard()
@property (nonatomic, weak) UIView *bg1;
@property (nonatomic, weak) UIView *bg2;
@property (nonatomic, weak) UIButton *select;
@end

@implementation JCLMarketKeyboard
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.numBg = [JCLKitObj JCLView:self color:JCLRGBA(244, 244, 244, 1)]; [self drawNumKeyboard];
        self.azBg = [JCLKitObj JCLView:self color:JCLRGBA(244, 244, 244, 1)];
        [self drawAZKeyboard]; self.azBg.hidden = YES;
    }
    return self;
}

-(void)layoutSubviews{
    self.numBg.frame = self.bounds; self.azBg.frame = self.bounds;
}

-(void)drawNumKeyboard{
    CGFloat x = 8, y = 8, w = (self.width-6*x)/5, h = self.height-2*y;
    for (int i = 0; i < 2; i++) {
        UIView *bg = [JCLKitObj JCLView:self.numBg color:nil];
        bg.layer.cornerRadius = 4; bg.layer.borderWidth = 1.2;
        bg.layer.borderColor = [UIColor whiteColor].CGColor;
        CGFloat bgX = i == 0 ? x : self.width-w-x;
        bg.frame = CGRectMake(bgX, y, w, h);
        if (i == 0) {
            self.bg1 = bg;
        } else {
            self.bg2 = bg;
        }
    }
    
    h = (h-2)/4;
    CGFloat numH = (self.height-5*y)/4;
    NSArray *arr = @[@"600", @"601", @"000", @"ABC",                 @"", @"清空", @"隐藏", @"搜索",
                     @"1", @"2", @"3", @"4", @"5", @"6",   @"7", @"8", @"9", @"002", @"0", @"300"];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *info = [JCLKitObj JCLButton:self.numBg img:@"" size:15 target:self action:@selector(action:)];
        info.title = obj; ; info.color = [UIColor blackColor]; info.tag = idx;
        
        info.backgroundColor = JCLRGBA(214, 214, 214, 1);
        info.layer.borderWidth = 0.5; info.layer.borderColor = JCLRGBA(188, 188, 188, 1).CGColor;
        [info setBackgroundImage:[self imageWithColor:JCLRGBA(180, 180, 180, 1)] forState:UIControlStateHighlighted];
        
        if (idx < 4) {
            [self.bg1 addSubview:info];
            info.frame = CGRectMake(1, idx*h+1, w-2, h);
        } else if (idx >= 4 && idx < 8) {
            if (idx == 4) {
                info.img = @"dele"; info.highlightedImg = @"dele_select";
            }
            [self.bg2 addSubview:info];
            NSInteger index = idx-4;
            info.frame = CGRectMake(1, index*h+1, w-2, h);
        } else {
            info.backgroundColor = JCLRGBA(224, 224, 224, 1);
            NSInteger index = idx-8;
            CGFloat infoX = w+2*x +w*(index%3)+x*(index%3), infoY = y+numH*(index/3)+y*(index/3);
            info.layer.cornerRadius = 4; info.layer.borderWidth = 1.4; info.layer.borderColor = [UIColor whiteColor].CGColor;
            info.frame = CGRectMake(infoX, infoY, w, numH);
        }
    }];
}

-(void)drawAZKeyboard{
    NSArray *arr = @[@"Q", @"W", @"E", @"R", @"T",@"Y", @"U", @"I", @"O", @"P",
                     @"A", @"S", @"D", @"F", @"G",@"H", @"J", @"K", @"L",
                     @"", @"Z", @"X", @"C", @"V",@"B", @"N", @"M", @"",
                     @"123", @"空格", @"搜索"];
    CGFloat hs = 6, vs = 4, w = (self.width-11*vs)/10, h = (self.height-5*hs)/4;
    CGFloat towX = 0.5*(self.width-(w*9+vs*8));
    CGFloat threeW = 0.5*(self.width-(w*7+vs*10));
    
    CGFloat spaceW = w*5+vs*4, otherW = 0.5*(self.width-spaceW-vs*4);
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *info = [JCLKitObj JCLButton:self.azBg img:@"" size:15 target:self action:@selector(action:)];
        info.title = obj; info.backgroundColor = JCLRGBA(224, 224, 224, 1); info.color = [UIColor blackColor]; info.tag = idx;
        [info setBackgroundImage:[self imageWithColor:JCLRGBA(180, 180, 180, 1)] forState:UIControlStateHighlighted];
        
        info.layer.borderWidth = 1.2; info.layer.borderColor = [UIColor whiteColor].CGColor; info.layer.cornerRadius = 4;
        
        if (idx < 10) {
            info.frame = CGRectMake(vs+idx*vs+w*idx, hs, w, h);
        } else if (idx > 9 && idx < 19) {
            info.frame = CGRectMake(towX+(idx-10)*vs+w*(idx-10), 2*hs+h, w, h);
        } else if (idx > 18 && idx < 28) {
            if (idx == 19) {
                info.title=@"清空";
                info.frame = CGRectMake(vs, 3*hs+2*h, threeW, h);
            } else if (idx == 27) {
                info.img = @"dele"; info.highlightedImg = @"dele_select";
                info.frame = CGRectMake(self.width-threeW-vs, 3*hs+2*h, threeW, h);
            } else {
                info.frame = CGRectMake(threeW+2*vs+(idx-20)*vs+w*(idx-20), 3*hs+2*h, w, h);
            }
        } else {
            if (idx == 28) {
                info.frame = CGRectMake(vs, 4*hs+3*h, otherW, h);
            } if (idx == 29) {
                info.frame = CGRectMake(2*vs+otherW, 4*hs+3*h, spaceW, h);
            } if (idx == 30) {
                info.frame = CGRectMake(self.width-(vs+otherW), 4*hs+3*h, otherW, h);
            }
        }
    }];
}

-(void)action:(UIButton *)button{
    !self.submitActionBlock ? : self.submitActionBlock(button);
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect             = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context    = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image          = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
