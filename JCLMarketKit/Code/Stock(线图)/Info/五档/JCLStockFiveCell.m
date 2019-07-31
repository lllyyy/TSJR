//
//  StockIndexFiveCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockFiveCell.h"

@implementation JCLStockFiveCell
+(instancetype)cellWithCollect:(UICollectionView *)collect idxPath:(NSIndexPath *)idxPath{
    NSString *ID = @"StockFiveCell";
    JCLStockFiveCell *cell = [collect dequeueReusableCellWithReuseIdentifier:ID forIndexPath:idxPath];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Cell_COL;
        self.title = [YSKitObj YSLable:self size:13 color:JCLRGBA(152, 153, 154, 1) alignment:1 style:0];
        self.price = [YSKitObj YSLable:self size:12 color:JCL_Text_COL alignment:1 style:0];
        self.number = [YSKitObj YSLable:self size:12 color:JCL_Text_COL alignment:1 style:0];
        self.scale = [JCLKitObj JCLView:self color:nil];
        self.line = [JCLKitObj JCLView:self color:[UIColor whiteColor]];
    }
    return self;
}

-(void)setW:(CGFloat)w{
    _w = w;
    if (self.isScroll) {
        self.title.frame = CGRectMake(0, 0, self.width/4, self.height);
        self.price.frame = CGRectMake(self.title.maxX, 0, self.width/4, self.height);

        self.number.frame = CGRectMake(self.price.maxX, 0, self.width/4, self.height);
        CGFloat h = 0.6*self.height, y = 0.5*(self.height - h);
        self.scale.frame = CGRectMake(self.width/4*3, y, w*(self.width/4), h);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];

    if (self.isLine) {
    } else {
        if (!self.isScroll) {
            self.title.frame = CGRectMake(0, 0, self.width/3, self.height);
            self.price.frame = CGRectMake(self.title.maxX, 0, self.width/3, self.height);
            self.number.frame = CGRectMake(self.price.maxX, 0, self.width/3, self.height);
        }
    }
}

-(void)setIsLine:(BOOL)isLine{
    _isLine = isLine;
    if (isLine) {
        self.line.frame = CGRectMake(20, 0, self.width - 40, 1);

    }

}
@end
