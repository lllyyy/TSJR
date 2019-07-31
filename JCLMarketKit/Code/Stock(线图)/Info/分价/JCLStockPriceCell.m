//
//  StockIndexPriceCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockPriceCell.h"

@interface JCLStockPriceCell()
@property (nonatomic, weak) UIView *buy;
@property (nonatomic, weak) UIView *sell;
@end

@implementation JCLStockPriceCell
+(instancetype)cellWithCollect:(UICollectionView *)collect idxPath:(NSIndexPath *)idxPath{
    NSString *ID = @"StockPriceCell";
    JCLStockPriceCell *cell = [collect dequeueReusableCellWithReuseIdentifier:ID forIndexPath:idxPath];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
        
        self.price = [YSKitObj YSLable:self size:13 color:JCL_Text_COL alignment:1 style:0];
        self.number = [YSKitObj YSLable:self size:13 color:JCL_Text_COL alignment:1 style:0];
        self.ratio= [YSKitObj YSLable:self size:13 color:JCL_Text_COL alignment:1 style:0];
        self.buy = [JCLKitObj JCLView:self color:JCLRGBA(218, 63, 42, 1)];
        self.sell = [JCLKitObj JCLView:self color:JCLRGBA(35, 137, 37, 1)];
    }
    return self;
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    self.price.frame = CGRectMake(0, 0, self.width/4, self.height);
    self.number.frame = CGRectMake(self.price.maxX, 0, self.width/4, self.height);
    self.ratio.frame = CGRectMake(self.number.maxX, 0, self.width/4, self.height);
    
    CGSize size = [JCLKitObj JCLTextSize:self.ratio.text spac:0 font:self.ratio.font width:self.width];
    CGFloat s = 14, x = self.ratio.maxX + s, w = self.width - s - x;
    
    //
    self.sell.frame = CGRectMake(x, 0.5*(self.height - size.height), self.sellVal*w, size.height);

    self.buy.frame = CGRectMake(self.sell.maxX, 0.5*(self.height - size.height), self.buyVal*w, size.height);
}
@end
