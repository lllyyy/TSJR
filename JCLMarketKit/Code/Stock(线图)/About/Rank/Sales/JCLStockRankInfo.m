//
//  JCLStockRankInfo.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/4/18.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLStockRankInfo.h"

@interface JCLStockRankInfo()
@property(nonatomic, weak) UILabel *title;
@property(nonatomic, strong) NSMutableArray *arrM;
@end

@implementation JCLStockRankInfo
-(NSMutableArray *)arrM{ if (_arrM) return _arrM; return _arrM = [[NSMutableArray alloc]init]; }
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 8; self.layer.borderWidth = 1.4; self.layer.borderColor = JCLRGBA(237, 142, 52, 1).CGColor;
        self.title = [JCLKitObj JCLLable:self font:14 color:nil alignment:1];
        self.title.text = @"参与个股";
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat s = 5;
    self.title.frame = CGRectMake(0, s, self.width, 24);
    if (!self.arrM.count) {
        [self.arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *info = [JCLKitObj JCLLable:self font:12 color:JCLRGBA(237, 142, 52, 1) alignment:1];
            info.text = self.arr[idx][0]; info.tag = idx;
            [JCLKitObj RXTap:info target:self action:@selector(tapAction:) number:1];
            [self.arrM addObject:info];
        }];
    }
    
    CGFloat infoW =0.5*self.width; NSInteger infoCols = 2;
    CGFloat count = self.arr.count;
    CGFloat num = count/infoCols; NSInteger numb = num,
    number = num > numb ? num+1 : num;
    number = number == 0 ? 1 : number;
     CGFloat h = (self.height-self.title.maxY-s)/number;
    [self.arrM enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.arrM.count > 1) {
            obj.frame = CGRectMake(infoW *(idx % infoCols), self.title.maxY + h *(idx / infoCols), infoW, h);
        } else {
            obj.frame = CGRectMake(0, self.title.maxY, self.width, h);
        }
    }];
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    UILabel *obj = (UILabel *)tap.view; !self.tapAction ? : self.tapAction(obj.tag);
}
@end
