//
//  JCLMarketOptionHeader.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketOptionHeader.h"

@interface JCLMarketOptionHeader()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, strong) NSMutableArray *arrM;
@property (nonatomic, assign) BOOL isDesc;
@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, assign) NSInteger sortIdx;
@end

@implementation JCLMarketOptionHeader
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.idx = 44;
    }
    return self;
}

-(NSMutableArray *)arrM{
    if (_arrM)
        return _arrM;
    return _arrM = [NSMutableArray array];
    
}
-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    [self.arrM enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *info = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:NSTextAlignmentCenter]; info.text = @"";
        info.textColor = JCL_Text_COL;
        obj.attributedText = [self getAttStr:info img:@""];
    }];
    [self.arrM removeAllObjects];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger style = NSTextAlignmentCenter;
        if (idx == 0) { style = NSTextAlignmentLeft; }
        if (idx == 2) { style = NSTextAlignmentRight; }
        if (!self.isAction) {
            if (idx == arr.count-1) { style = NSTextAlignmentRight; }
        }
        UILabel *info = [JCLKitObj JCLLable:self font:14 color:JCL_Text_COL alignment:style];
        info.textColor = JCL_Text_COL;
        info.text = obj; info.tag = idx;
        [self.arrM addObject:info];
    }];
}

-(void)menuAction:(UITapGestureRecognizer *)tap{
    UILabel *obj = (UILabel *)tap.view;
//    if (self.isDesc) {
//        obj.attributedText = [self getAttStr:obj img:@"Tactics_shang"]; self.isDesc = NO;
//    } else {
//        obj.attributedText = [self getAttStr:obj img:@"Tactics_xia"]; self.isDesc = YES;
//    }
    if (self.isAction) {
        if (self.idx != obj.tag) {
            self.sortIdx = 0;
        }
        
        !self.menuActionBlock ? : self.menuActionBlock(obj, self.sortIdx);

        if (self.sortIdx == 0) {
            obj.attributedText = [self getAttStr:obj img:@"降序"];
//            self.sortIdx +=1;
            self.sortIdx= 1;
        } else if (self.sortIdx == 1) {
            obj.attributedText = [self getAttStr:obj img:@"升序"];
//            self.sortIdx -= self.sortIdx;
             self.sortIdx= 0;
        }
//        else {
//            obj.attributedText = [self getAttStr:obj img:@""]; self.sortIdx +=1;
//        }
        
        if (self.idx != obj.tag) {
            self.obj.attributedText = [self getAttStr:self.obj img:@""];
            self.obj = obj;
        }
        
        self.idx = obj.tag;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bg.frame = CGRectMake(0, 0, self.width, self.height - 1);
    CGFloat x = 14;
    CGFloat w = (self.width-2*x)/self.arr.count;
    [self.arrM enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(idx*w+x, 0, w, self.bg.height);
        obj.attributedText = [self getAttStr:obj img:@""];
        UITapGestureRecognizer *tap = [JCLKitObj RXTap:obj target:self action:@selector(menuAction:) number:1];
         if (idx == 2) {
//            [self menuAction:tap];
//             obj.attributedText = [self getAttStr:obj img:@"排序_n"];
             
             NSLog(@"sortIdxsortIdx  %@",self.sortIdx);
             
             if (self.sortIdx == 0) {
                 obj.attributedText = [self getAttStr:obj img:@"降序"];
                
                 self.sortIdx= 1;
             } else if (self.sortIdx == 1) {
                 obj.attributedText = [self getAttStr:obj img:@"升序"];
               
                 self.sortIdx= 0;
             }
        }
    }];
}

-(NSAttributedString *)getAttStr:(UILabel *)obj img:img{
    NSString *text = [NSString stringWithFormat:@"%@", obj.text];
    CGSize size = [JCLKitObj JCLTextSize:@"44" font:[JCLKitObj JCLFont:15]];
    return [JCLKitObj RXAttStr:text icon:img y:0 wh:0.6*size.height idx:text.length];
}
@end
