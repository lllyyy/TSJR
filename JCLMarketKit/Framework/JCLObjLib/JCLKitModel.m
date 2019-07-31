//
//  XLDMenu.m
//  Jincelue
//
//  Created by 邢昭俊 on 2017/1/20.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import "JCLKitModel.h"
#import "JCLKitObj.h"

@implementation JCLKitModel
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [JCLKitObj RXTap:self target:self action:@selector(tapAction) number:1];
    }
    return self;
}
-(void)tapAction{
    !self.tapActionBlock ? : self.tapActionBlock();
};

-(void)setType:(MenuModelType)type{
    _type = type;
    switch (type){
        case MenuTypeOfText: [self setupText]; break;
        case MenuTypeOfIcon: [self setupIcon]; break;
        case MenuTypeOfsubText: [self setupSubText]; break;
        default: break;
    }
}

-(void)setupText{ self.text = [JCLKitObj JCLLable:self font:15 color:nil alignment:NSTextAlignmentCenter]; }
-(void)setupIcon{
    self.icon = [JCLKitObj JCLImage:self];
    self.text = [JCLKitObj JCLLable:self font:12 color:nil alignment:NSTextAlignmentCenter];
}

-(void)setupSubText{
    self.text = [JCLKitObj JCLLable:self font:12 color:JCL_Text_COL alignment:NSTextAlignmentCenter];
    self.subText = [JCLKitObj JCLLable:self font:12 color:JCL_Text_COL alignment:NSTextAlignmentCenter];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    switch (self.type){
        case MenuTypeOfText: [self layoutText]; break;
        case MenuTypeOfIcon: [self layoutIcon]; break;
        case MenuTypeOfsubText: [self layoutSubText]; break;
        default: break;
    }
}

-(void)layoutText{ self.text.frame = self.bounds; }
-(void)layoutIcon{
    CGSize size = [JCLKitObj JCLTextSize:self.text.text font:self.text.font width:self.width];
    CGFloat wh = 0.5*self.width, s = 8, y = 0.5*(self.height - wh - size.height - s);
    self.icon.frame = CGRectMake(0.5*(self.width - wh), y, wh, wh);
    self.text.frame = CGRectMake(0, self.icon.maxY + s, self.width, size.height);
}

-(void)layoutSubText{
    CGFloat infoH = 0.7*self.height, infoY = 0.5*(self.height - infoH);
    self.text.frame = CGRectMake(0, infoY, self.width, 0.5*infoH);
    self.subText.frame = CGRectMake(0, self.text.maxY, self.width, 0.5*infoH);
}
@end
