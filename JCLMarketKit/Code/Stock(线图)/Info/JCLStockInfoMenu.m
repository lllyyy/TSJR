//
//  StockInfoView.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockInfoMenu.h"
#import "JCLStockFive.h"
#import "JCLStockDetailed.h"
#import "JCLStockPrice.h"
#import "JCLStockHandicap.h"
#import "JCLStockPlate.h"
#import "JCLBaseMenu.h"
#import "JCLStockBaseInfo.h"

@interface JCLStockInfoMenu()
@property (nonatomic, weak) JCLBaseMenu *about;
@property (nonatomic, weak) UIButton *diss;

@property (nonatomic, weak) JCLStockBaseInfo *five;
@property (nonatomic, weak) JCLStockBaseInfo *detailed;
@property (nonatomic, weak) JCLStockBaseInfo *price;
@property (nonatomic, weak) JCLStockBaseInfo *handicap;
@property (nonatomic, weak) JCLStockBaseInfo *plate;

@property (nonatomic, assign) NSInteger idx;
@end

@implementation JCLStockInfoMenu
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(infoAction)]];
        self.diss = [JCLKitObj JCLButton:self img:@"cha_select" size:14 target:self action:@selector(dissAction)];
        self.diss.backgroundColor = JCL_Cell_COL;
    }
    return self;
}
-(void)infoAction{ !self.infoActionBlock ? : self.infoActionBlock(); }
-(void)dissAction{ !self.dissActionBlock ? : self.dissActionBlock(); }

-(void)drawRect:(CGRect)rect{
    CGFloat h = [JCLKitObj JCLHeight:40];
    JCLBaseMenu *menu = [[JCLBaseMenu alloc]init]; [self addSubview:menu];
    menu.backgroundColor = JCL_Cell_COL;
    menu.style = MenuStyleIdxLine; menu.isAction = YES;
    NSString *idx = [NSString stringWithFormat:@"%@", PreRead(JCLInfoIdx)];
    if (idx.length) { menu.idx = idx.integerValue; }
    menu.arr = @[@"五档", @"明细", @"分价", @"盘口", @"板块"];
    menu.tapActionBlock = ^(NSInteger idx){
        [self RemoveSubview];
        self.idx = idx;
        switch (idx) {
            case 0: self.five = [self InitSubview:[[JCLStockFive alloc]init]];
                break;
            case 1: self.detailed = [self InitSubview:[[JCLStockDetailed alloc]init]];
                break;
            case 2: self.price = [self InitSubview:[[JCLStockPrice alloc]init]];
                break;
            case 3:self.handicap = [self InitSubview:[[JCLStockHandicap alloc]init]];
                break;
            case 4: self.plate = [self InitSubview:[[JCLStockPlate alloc]init]];
                self.plate.actionBlock = ^(NSArray *arr){
                    !self.actionBlock ? : self.actionBlock(arr);
                };
                break;
        }
        NSString *index = [NSString stringWithFormat:@"%ld", (long)idx]; PreWrite(index, JCLInfoIdx);
    };
    CGFloat w = self.isPop ? self.width - h: self.width;
    menu.frame = CGRectMake(0, 0, w, h);
    self.about = menu;
    self.diss.frame = CGRectMake(self.width - menu.height, 0, menu.height, menu.height);
}

-(JCLStockBaseInfo *)InitSubview:(JCLStockBaseInfo *)info{
    [self addSubview:info]; info.infoArr = self.infoArr; info.code = self.code; info.isScroll = self.isPop;  info.decimal = self.decimal;
    info.frame = CGRectMake(0, self.about.maxY, self.width, self.height - self.about.maxY);
    return info;
}
-(void)RemoveSubview{
    [self.five removeFromSuperview]; [self.detailed removeFromSuperview]; [self.price removeFromSuperview];
    [self.handicap removeFromSuperview]; [self.plate removeFromSuperview];
}

-(void)isReload{
    switch (self.idx) {
        case 0: [self.five setNeedsDate]; break;
        case 1: [self.detailed setNeedsDate:NO]; break;
        case 2: [self.price setNeedsDate]; break;
        case 3: [self.handicap setNeedsDate]; break;
        case 4: [self.plate setNeedsDate]; break;
        default: break;
    }
}
@end
