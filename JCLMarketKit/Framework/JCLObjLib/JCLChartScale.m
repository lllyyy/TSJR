//
//  JCLChartScale.m
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/3/9.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLChartScale.h"

@implementation JCLChartScale
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) { self.backgroundColor = [UIColor clearColor]; } return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSArray *arr = self.idxArr;
    CGFloat wh = self.width/arr.count; self.color = JCL_Text_COL;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.textCols) {
            NSInteger middle = 0.5*arr.count;
            if (idx < middle) {
                self.color = self.textCols[0];
            } else if (idx > middle) {
                self.color = self.textCols[2];
            } else {
                self.color = self.textCols[1];
            }
        }
        switch (self.style) {
            case JCLChartScaleBoxV: [self drawInfo:arr.count idx:idx text:obj]; break;
            case JCLChartScaleLineV: [self drawInfo:arr.count idx:idx text:obj]; break;
            case JCLChartScaleBoxH: [self drawInfo:CGRectMake(idx*wh, 0, wh, self.height) text:obj]; break;
            case JCLChartScaleLineH: [self drawInfo:CGRectMake(0, idx*wh, self.width, wh) text:obj]; break;
            default: break;
        }
    }];
}

-(void)drawInfo:(CGRect)frame text:(NSString *)text{
    UILabel *info = [JCLKitObj JCLLable:self font:self.size color:self.color alignment:self.alignment]; info.text = text; info.frame = frame;
}

-(void)drawInfo:(NSInteger)count idx:(NSInteger)idx text:(NSString *)text{
    UILabel *info = [JCLKitObj JCLLable:self font:self.size color:self.color alignment:self.alignment];
    NSLog(@"-=-==-=-=-weakBroken %@",text);
//    info.text = text;
//    info.backgroundColor = [UIColor redColor];
    
    CGSize size = [JCLKitObj JCLTextSize:info.text font:info.font];
    CGFloat w = self.width/(count-1), h = self.height/(count-1);
    CGRect frame;
    if (self.style == JCLChartScaleLineV) {
        if (idx == 0) {
            frame = CGRectMake(0, 0, self.width, size.height);
        } else if (idx == count - 1) {
            frame = CGRectMake(0, self.height - size.height, self.width, size.height);
        } else {
            frame = CGRectMake(0, idx*h - 0.5*size.height, self.width, size.height);
        }
    } else {
        if (idx == 0) {
            frame = CGRectMake(0, 0, size.width, self.height);
        } else if (idx == count - 1) {
            frame = CGRectMake(self.width - size.width, 0, size.width, self.height);
        } else {
            frame = CGRectMake(idx*w - 0.5*size.width, 0, size.width, self.height);
        }
    }
    info.frame = frame;
}
@end
