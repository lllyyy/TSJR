//
//  StockIndexPlateCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockPlateCell.h"

@interface JCLStockPlateCell()
@end

@implementation JCLStockPlateCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    NSString *ID = @"PlateCell";
    JCLStockPlateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Cell_COL;
        self.bg = [JCLKitObj JCLView:self color:nil];
        self.title = [YSKitObj YSLable:self.bg size:14 color:[UIColor whiteColor] alignment:1 style:0];
        self.ratio = [YSKitObj YSLable:self.bg size:17 color:[UIColor whiteColor] alignment:1 style:0];
        self.subTitle = [YSKitObj YSLable:self.bg size:11 color:[UIColor whiteColor] alignment:1 style:0];
        self.subRatio = [YSKitObj YSLable:self.bg size:12 color:[UIColor whiteColor] alignment:1 style:0];
        

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat s = 10;
    
    if (self.isScroll) {
        [JCLKitObj RXTap:self target:self action:@selector(action) number:1];
    }
    self.bg.frame = CGRectMake(s, s, self.width - 2*s, self.height - s);
    CGSize textSize = [JCLKitObj JCLTextSize:self.title.text font:self.title.font];
    CGSize rangeSize = [JCLKitObj JCLTextSize:self.ratio.text font:self.ratio.font];
    CGSize subSize = [JCLKitObj JCLTextSize:self.subTitle.text font:self.subTitle.font];
    CGFloat textH = 1.2*textSize.height, rangeH = 1.2*rangeSize.height, subH = 1.2*subSize.height;
    CGFloat subY = 0.5*(self.bg.height - textH - rangeH - subH);
    self.title.frame = CGRectMake(0, subY, self.bg.width, textH);
    self.ratio.frame = CGRectMake(0, self.title.maxY, self.bg.width, rangeH);
    self.subTitle.frame = CGRectMake(0, self.ratio.maxY, 0.5*self.bg.width, subH);
    self.subRatio.frame = CGRectMake(self.subTitle.maxX, self.ratio.maxY, 0.5*self.bg.width, subH);
}

-(void)action{
    !self.actionBlock ? : self.actionBlock();
}
@end
