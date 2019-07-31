//
//  RangeMoreHeader.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/11/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLMarketInfoHeader.h"

@interface JCLMarketInfoHeader()
@property (nonatomic, weak) UIButton *title;
@property (nonatomic, strong) UIButton *hisBtn;
@end

@implementation JCLMarketInfoHeader
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
        self.title = [JCLKitObj JCLButton:self img:@"" size:15 target:self action:@selector(textAction:)];
        self.title.title = @"名称"; self.title.color = JCL_Text_COL;
        self.scroll = [JCLKitObj JCLScroll:self page:NO delegate:self];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = 0.25*JCLWIDTH;
    self.title.frame = CGRectMake(0, 0, w, self.height);
    self.scroll.frame = CGRectMake(self.title.maxX, 0, self.width - self.title.maxX, self.height);
    self.scroll.contentSize = CGSizeMake(self.textArr.count*w, 0);
    
    [self.textArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *text = [JCLKitObj JCLButton:self.scroll img:@"" size:15 target:self action:@selector(scrollAction:)];
        text.title = self.textArr[idx]; text.color = JCL_Text_COL; text.tag = idx;
        text.frame = CGRectMake(idx*w, 0, w, self.height);
        
        if (idx == self.idx) {
            [self scrollAction:text]; }
    }];
}

-(void)textAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.hisBtn.img = @""; self.count = 0;
    if (sender.selected) {
        sender.img = [JCLKitObj JCLBundle:@"xia"]; self.codeActionBlock(1);
    } else {
        sender.img = [JCLKitObj JCLBundle:@"shang"]; self.codeActionBlock(2);
    }
}

-(void)scrollAction:(UIButton *)sender{
    if(sender.tag == self.hisBtn.tag) {
        if(self.count==0) {
            [self.title setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.hisBtn setImage:[UIImage imageNamed:[JCLKitObj JCLBundle:@"xia"]] forState:UIControlStateNormal];
            [sender setImage:[UIImage imageNamed:[JCLKitObj JCLBundle:@"xia"]] forState:UIControlStateNormal];
            self.riseActionBlock(sender.tag);
        } else if(self.count==1){
            [self.hisBtn setImage:[UIImage imageNamed:[JCLKitObj JCLBundle:@"shang"]] forState:UIControlStateNormal];
            self.dropActionBlock(sender.tag);
        } self.count++;
    } else {
        [self.title setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.hisBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (self.count == 1) {
            [sender setImage:[UIImage imageNamed:[JCLKitObj JCLBundle:@"shang"]] forState:UIControlStateNormal];
            self.dropActionBlock(sender.tag);
        } else {
            self.count = 1;
            [sender setImage:[UIImage imageNamed:[JCLKitObj JCLBundle:@"xia"]] forState:UIControlStateNormal];
            self.riseActionBlock(sender.tag);
        }
    } self.hisBtn = sender; if(self.count == 2){ self.count = 0; } self.title.selected = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{ self.slideActionBlock(scrollView); }
@end
