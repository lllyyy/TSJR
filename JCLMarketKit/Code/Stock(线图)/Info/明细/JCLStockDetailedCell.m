//
//  StockIndexDetailedCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockDetailedCell.h"

@implementation JCLStockDetailedCell
+(instancetype)cellWithCollect:(UICollectionView *)collect idxPath:(NSIndexPath *)idxPath{
    NSString *ID = @"StockDetailedCell";
    JCLStockDetailedCell *cell = [collect dequeueReusableCellWithReuseIdentifier:ID forIndexPath:idxPath];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.time = [YSKitObj YSLable:self size:13 color:JCL_Text_COL alignment:1 style:0];
        self.price = [YSKitObj YSLable:self size:13 color:JCL_Text_COL alignment:1 style:0];
        self.number = [YSKitObj YSLable:self size:13 color:JCL_Text_COL alignment:1 style:0];
        self.type = [YSKitObj YSLable:self size:13 color:JCL_Text_COL alignment:1 style:0];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.width/3;
    self.time.frame = CGRectMake(0, 0, w, self.height);
    self.price.frame = CGRectMake(self.time.maxX, 0, w, self.height);
    self.number.frame = CGRectMake(self.price.maxX, 0, w, self.height);
    //self.typeLable.frame = CGRectMake(self.numberLable.maxX, 0, w, self.height);
}
@end
