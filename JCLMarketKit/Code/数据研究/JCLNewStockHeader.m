//
//  JCLNewStockHeader.m
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/5/12.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLNewStockHeader.h"

@interface JCLNewStockHeader()<UIScrollViewDelegate>
@property (nonatomic, weak) UIButton *title;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) UIButton *hisBtn;
@property (nonatomic, strong) NSMutableArray *btnArr;
@end

@implementation JCLNewStockHeader
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCLBGRGB;
        self.title = [JCLKitObj JCLButton:self img:@"" size:15 target:self action:@selector(textAction:)];
        self.title.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.title.title = @"股票名称";
        self.title.color = JCLRGBA(68, 70, 67, 1);
        self.scroll = [JCLKitObj JCLScroll:self page:NO delegate:self];
        self.btnArr= [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = 0.25*JCLWIDTH;
    self.title.frame = CGRectMake(15, 0, w, self.height);
    self.scroll.frame = CGRectMake(self.title.maxX, 0, self.width - self.title.maxX, self.height);
    self.scroll.contentSize = CGSizeMake(self.textArr.count*0.25*JCLWIDTH, 0);
}

- (void)setTextArr:(NSArray *)textArr
{
    [self.btnArr enumerateObjectsUsingBlock:^(UIButton *text, NSUInteger idx, BOOL * _Nonnull stop) {
        [text removeFromSuperview];
    }];
    [self.btnArr removeAllObjects];
    _textArr = textArr;
    CGFloat W =0.23*JCLWIDTH;
    
    [self.textArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *text = [JCLKitObj JCLButton:self.scroll img:@"" size:15 target:nil action:nil];
        text.title = self.textArr[idx]; text.color = JCLRGBA(68, 70, 67, 1); text.tag = idx;
        text.frame = CGRectMake(idx*W, 0, W, self.height);
        text.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        if([text.title isEqualToString:@"hidden"]){
            text.hidden=YES;
        }
        [self.btnArr addObject:text];
    }];
}

-(void)textAction:(UIButton *)sender{
//    sender.selected = !sender.selected;
//    self.hisBtn.img = @""; self.count = 0;
//    if (sender.selected) {
//        sender.img = [JCLKitObj JCLBundle:@"xia"]; self.codeActionBlock(1);
//    } else {
//        sender.img = [JCLKitObj JCLBundle:@"shang"]; self.codeActionBlock(2);
//    }
}

-(void)scrollAction:(UIButton *)sender{
    if(sender.tag == self.hisBtn.tag) {
        if(self.count==0) {
            [self.title setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.hisBtn setImage:[UIImage imageNamed:[JCLKitObj JCLBundle:@"xia"]] forState:UIControlStateNormal];
            [sender setImage:[UIImage imageNamed:[JCLKitObj JCLBundle:@"xia"]] forState:UIControlStateNormal];
        }else if(self.count==1){
            [self.hisBtn setImage:[UIImage imageNamed:[JCLKitObj JCLBundle:@"shang"]] forState:UIControlStateNormal];
        } self.count++;
    } else {
        self.count = 1;
        [self.title setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.hisBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:[JCLKitObj JCLBundle:@"xia"]] forState:UIControlStateNormal];
    } self.hisBtn = sender; if(self.count == 2){ self.count = 0; } self.title.selected = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{ self.slideActionBlock(scrollView); }
@end
