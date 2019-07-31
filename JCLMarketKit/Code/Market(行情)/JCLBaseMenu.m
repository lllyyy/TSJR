//
//  JCLBaseMenu.m
//  Jincelue_Sdk
//
//  Created by 邢昭俊 on 2017/3/28.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLBaseMenu.h"

@interface JCLBaseMenu()
@property (nonatomic, strong) NSMutableArray *arrM;
@property (nonatomic, strong) NSMutableArray *lineArrM;
@end

@implementation JCLBaseMenu
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) { self.backgroundColor = JCL_Cell_COL; self.hisIdx = 100; } return self;
}

-(NSMutableArray *)arrM{ if (_arrM) return _arrM; return _arrM = [[NSMutableArray alloc]init]; }
-(NSMutableArray *)lineArrM{ if (_lineArrM) return _lineArrM; return _lineArrM = [[NSMutableArray alloc]init]; }
-(void)setArr:(NSArray *)arr{
    _arr = arr;
    self.color = self.color ? self.color : JCL_Text_COL;
    if (!self.arrM.count) {
        switch (self.style) {
            case MenuStyleNormal: [self InitNormalMenu:arr]; break;
            case MenuStyleIdxLine: [self InitIdxLineMenu:arr]; break;
            case MenuStyleBGLine: [self InitBGLineMenu:arr]; break;
            default: break;
        }
    }
}

// 初始化普通菜单
-(void)InitNormalMenu:(NSArray *)arr{
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JCLKitModel *model = [[JCLKitModel alloc]init]; [self addSubview:model]; model.type = MenuTypeOfText;
        model.text.text = arr[idx]; [self.arrM addObject:model];
        CGFloat size = self.size ? self.size: 14;
        model.text.font = [UIFont systemFontOfSize:size];
        model.text.textColor = self.color;
        if (self.isLCR) {
            if (idx == 0) {
                model.text.textAlignment = 0;
            } else if (idx == arr.count-1) {
                model.text.textAlignment = 2;
            } else {
                model.text.textAlignment = 1;
            }
        }
        
        if (self.isLine) { [self.lineArrM addObject:[JCLKitObj JCLView:self color:JCL_SelText_COL]]; }
    }];
}

// 初始化带指示的菜单
-(void)InitIdxLineMenu:(NSArray *)arr{
    [self InitNormalMenu:arr];
    self.idxLine = [JCLKitObj JCLView:self color:JCL_SelText_COL];
}

// 初始化带背景线的指示菜单
-(void)InitBGLineMenu:(NSArray *)arr{
    [self InitIdxLineMenu:arr];
    self.bgLine = [JCLKitObj JCLView:self color:JCL_Bg_COL];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    switch (self.style) {
        case MenuStyleNormal: [self layoutNormalMenu:self.height]; break;
        case MenuStyleIdxLine: [self layoutIdxLineMenu:self.height]; break;
        case MenuStyleBGLine: [self layoutBGLineMenu]; break;
        default: break;
    }
}

// 布局普通菜单
-(void)layoutNormalMenu:(CGFloat)height{
    CGFloat lineW = 1.4, lineH = 0.6*height, lineY = 0.5*(height - lineH);
    CGFloat w = (self.width-(self.arr.count*lineW-1))/self.arr.count;
    [self.lineArrM enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) { obj.frame = CGRectMake(idx*w + idx*lineW, lineY, lineW, lineH); }
    }];
    
    [self.arrM enumerateObjectsUsingBlock:^(JCLKitModel *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(idx*w + idx*lineW, 0, w, height);
        if (self.isAction) {
            if (idx == self.idx) { obj.text.textColor = JCL_SelText_COL; self.select = obj; !self.tapActionBlock ? : self.tapActionBlock(idx); }
            __weak typeof(obj)weakObj = obj;
            obj.tapActionBlock = ^(){
                if (self.hisIdx != idx) {
                    weakObj.text.textColor = JCL_SelText_COL; self.select.text.textColor = JCL_Text_COL; self.select = weakObj;
                    self.idxLine.centerX = weakObj.centerX;
                    self.hisIdx = idx != self.arr.count ? idx : 44;
                    !self.tapActionBlock ? : self.tapActionBlock(idx);
                }
            };
        }
    }];
}

// 布局带指示的菜单
-(void)layoutIdxLineMenu:(CGFloat)height{
    CGFloat w = self.width/self.arr.count, h = height - 2;
    CGSize size = [JCLKitObj JCLTextSize:@"4444" font:[UIFont systemFontOfSize:14]];
    self.idxLine.frame = CGRectMake(0.5*(w - 1.2*size.width)+self.idx*w, h, 1.4*size.width, 2);
    [self layoutNormalMenu:h];
}

// 布局带背景线的指示菜单
-(void)layoutBGLineMenu{
    CGFloat h = 1;
    self.bgLine.frame = CGRectMake(0, self.height - h, self.width, h);
    [self layoutIdxLineMenu:self.height - h];
}
@end
