//
//  JCLTradeRiskInfo.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/11/9.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLTradeRiskInfo.h"

@interface JCLTradeRiskInfo()
@property (nonatomic, weak) UIView *riskBg;
//@property (nonatomic, weak) UIImageView *img;

@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) UIView *zcl;
@property (nonatomic, weak) UIView *pcl;
@property (nonatomic, weak) UIView *yjl;
@property (nonatomic, weak) UIView *lp;

@property (nonatomic, weak) UIView *capitalBg;
@property (nonatomic, strong) NSMutableArray *lines;
@end

@implementation JCLTradeRiskInfo
-(instancetype)init{
    if(self = [super init]) {
        self.backgroundColor = JCL_Line_COL;
        self.riskBg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.title = [JCLKitObj JCLLable:self.riskBg font:16 color:JCL_Text_COL alignment:1];
       // self.img = [JCLKitObj JCLImage:self];
        
        self.line = [JCLKitObj JCLView:self.riskBg color:JCLHexCol(@"#00FF01")];
        self.line.layer.cornerRadius = 4;
        self.line.clipsToBounds = YES;
        self.zcl = [JCLKitObj JCLView:self.line color:JCLHexCol(@"#EF4640")];
        self.pcl = [JCLKitObj JCLView:self.line color:JCLHexCol(@"#F9F536")];
        self.yjl = [JCLKitObj JCLView:self.line color:JCLHexCol(@"#24AF51")];
        self.lp = [JCLKitObj JCLView:self.riskBg color:JCLHexCol(@"#00FF01")];

        self.zzc = [JCLKitObj JCLLable:self.riskBg font:13 color:JCL_Text_COL alignment:0];
        self.pcx = [JCLKitObj JCLLable:self.riskBg font:12 color:JCL_Text_COL alignment:0];
        self.yjx = [JCLKitObj JCLLable:self.riskBg font:12 color:JCL_Text_COL alignment:0];
        
        self.capitalBg = [JCLKitObj JCLView:self color:JCL_Cell_COL];
        self.yk = [JCLKitObj JCLLable:self.capitalBg font:13 color:JCL_Text_COL alignment:1];
        self.ye = [JCLKitObj JCLLable:self.capitalBg font:13 color:JCLHexCol(@"#5E6163") alignment:1];
        self.ky = [JCLKitObj JCLLable:self.capitalBg font:13 color:JCLHexCol(@"#5E6163") alignment:1];
        self.sz = [JCLKitObj JCLLable:self.capitalBg font:13 color:JCLHexCol(@"#5E6163") alignment:1];
        
        self.lines = [[NSMutableArray alloc]init];
        for (int i = 0; i < 3; i++) {
            UIView *line = [JCLKitObj JCLView:self.capitalBg color:JCL_Line_COL];
            [self.lines addObject:line];
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat s = 1, leftS = 10, riskH = 0.7*(self.height-s*2);
    self.riskBg.frame = CGRectMake(0, 0, self.width, riskH);
    CGFloat titleH = 0.22*(self.riskBg.height-16);
    self.title.frame = CGRectMake(0, 8, self.width, titleH);
    
    CGFloat riskCH = riskH - titleH;
    CGFloat lineW = self.width-2*leftS, lineH = 6.6, contH = 0.5*(riskCH-lineH-6);
    self.zzc.frame = CGRectMake(leftS, self.title.maxY, self.width, contH);
    
    self.line.frame = CGRectMake(leftS, self.zzc.maxY, lineW, lineH);
    self.zcl.frame = CGRectMake(0, 0, 0.2*lineW, lineH);
    self.pcl.frame = CGRectMake(self.zcl.maxX, 0, 0.3*lineW, lineH);
    self.yjl.frame = CGRectMake(self.pcl.maxX, 0, 0.5*lineW, lineH);
    CGFloat lineWH = lineH+6;
    self.lp.frame = CGRectMake(leftS, self.zzc.maxY-3, lineWH, lineWH);
    self.lp.layer.cornerRadius = 0.5*lineWH;
    
    CGSize pcSize = [JCLKitObj JCLTextSize:self.pcx.text font:self.pcx.font];
    self.pcx.frame = CGRectMake(leftS+self.zcl.width-0.5*pcSize.width, self.line.maxY, pcSize.width, contH);
    CGSize yjSize = [JCLKitObj JCLTextSize:self.yjx.text font:self.yjx.font];
    self.yjx.frame = CGRectMake(leftS+self.yjl.width-0.5*pcSize.width, self.line.maxY, yjSize.width, contH);

    self.capitalBg.frame = CGRectMake(0, self.riskBg.maxY+s, self.width, (self.height-s*2)-riskH);
    CGFloat capitalW = 0.3*self.width;
    self.yk.frame = CGRectMake(0, 0, capitalW, self.capitalBg.height);
    CGFloat w = (self.width-capitalW)/3;
    self.ye.frame = CGRectMake(self.yk.maxX, 0, w, self.capitalBg.height);
    self.ky.frame = CGRectMake(self.ye.maxX, 0, w, self.capitalBg.height);
    self.sz.frame = CGRectMake(self.ky.maxX, 0, w, self.capitalBg.height);
    CGFloat h = 0.54*self.capitalBg.height, y = 0.5*(self.capitalBg.height-h);
    [self.lines enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(capitalW+idx*w+idx+s, y, s, h);
    }];
}
@end
