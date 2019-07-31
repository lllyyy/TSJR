//
//  JCLMarketOptionMsg.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/10.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketOptionMsg.h"

@interface JCLMarketOptionMsg()
@property (nonatomic, weak) UIButton *img;
@property (nonatomic, weak) UILabel *text;
@property (nonatomic, weak) UIButton *search;
@end

@implementation JCLMarketOptionMsg
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.img =  [JCLKitObj JCLButton:self img:@"添加自选" size:14 target:self action:@selector(searchAction)];
        self.text = [JCLKitObj JCLLable:self font:15 color:JCL_Text_COL alignment:1]; self.text.text = @"暂无自选, 点击添加";
//        self.search = [JCLKitObj JCLButton:self img:@"" size:14 target:self action:@selector(searchAction)];
//        self.search.layer.cornerRadius = 4; self.search.backgroundColor = JCLRGBA(251, 82, 84, 1);
//        self.search.title = @"请去添加";
    }
    return self;
}
-(void)searchAction{ !self.searchActionBlock ? : self.searchActionBlock(); }

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.img.frame = CGRectMake(0, 0, self.width, 0.66*self.height);
    self.text.frame = CGRectMake(0, self.img.maxY, self.width, 0.18*self.height);
    
    NSInteger w = 0.3*self.width, x = 0.5*(self.width - w), h = 0.12*self.height;
    self.search.frame = CGRectMake(x, self.text.maxY, w, h);
}
@end
