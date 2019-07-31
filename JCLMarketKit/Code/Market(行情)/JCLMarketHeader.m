//
//  JCLMarketHeader.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/27.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLMarketHeader.h"
#import "JCLMarketInfo.h"
#import "TSJRRealTimeMarket.h"
@interface JCLMarketHeader()
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, strong) NSMutableArray *arrM;
@property (nonatomic, strong) NSMutableArray *lineArrM;
@end

@implementation JCLMarketHeader
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
        self.bg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bg.frame = CGRectMake(0, 0, self.width, self.height-6);
 
}

-(NSMutableArray *)arrM{
    if (_arrM)
        return _arrM;
    return _arrM = [[NSMutableArray alloc]init];
    
}
-(NSMutableArray *)lineArrM{ if (_lineArrM) return _lineArrM; return _lineArrM = [[NSMutableArray alloc]init]; }
-(void)setArr:(NSMutableArray *)arr{
    _arr = arr;
    if (!self.arrM.count) {
        [arr enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JCLMarketInfo *info = [[JCLMarketInfo alloc]init];
            [self.bg addSubview:info];
            [self.arrM addObject:info];
            info.layer.cornerRadius = 4;
        }];

        CGFloat x = 10, y = 10;
        CGFloat w = (self.width-(arr.count+1)*x)/3;
        [self.arrM enumerateObjectsUsingBlock:^(JCLMarketInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.frame =CGRectMake(idx*x+idx*w+x, y, w, self.bg.height-2*y);
            obj.tapActionBlock = ^(){ !self.tapActionBlock ? : self.tapActionBlock(idx); };
        }];
    }
    NSArray *title = @[@"道琼斯",@"纳斯达克",@"标普"];
    [self.arrM enumerateObjectsUsingBlock:^(JCLMarketInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
     
        TSJRRealTimeMarket *makeModel = arr[idx];
         obj.title.text = title[idx];
         obj.code.text = [JCLKitObj moneyFormat:makeModel.latestPrice];
         obj.range.text = [JCLMarketObj JCLMarketRange:makeModel.close close:makeModel.preClose];
         obj.scale.text = [JCLMarketObj JCLMarketScale:obj.range.text close:makeModel.preClose];;
         obj.backgroundColor = [JCLMarketObj TSJRMarketColorA:obj.range.text];;
    }];
}
@end
