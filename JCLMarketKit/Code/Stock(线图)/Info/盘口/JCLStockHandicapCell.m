//
//  StockIndexHandicapCell.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockHandicapCell.h"

@implementation JCLStockHandicapCell
+(instancetype)cellWithCollect:(UICollectionView *)collect idxPath:(NSIndexPath *)idxPath{
    NSString *ID = @"HandicapCell";
    JCLStockHandicapCell *cell = [collect dequeueReusableCellWithReuseIdentifier:ID forIndexPath:idxPath];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
        self.key1 = [YSKitObj YSLable:self size:12 color:[UIColor whiteColor] alignment:1 style:0];
        self.key2 = [YSKitObj YSLable:self size:12 color:JCLRGBA(81, 83, 84, 1) alignment:1 style:0];
        self.val  = [YSKitObj YSLable:self size:12 color:JCL_Text_COL alignment:1 style:0];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = [JCLKitObj JCLTextSize:self.key1.text font:self.key1.font];
    NSInteger wh = 1.4*size.width, y = 0.5*(self.height - wh), s = 10;
    self.key1.frame = CGRectMake(s, y, wh, wh);
    self.key2.frame = CGRectMake(self.key1.maxX, y, wh, wh);
    self.val.frame = CGRectMake(self.key2.maxX, 0, self.width - self.key2.maxX - s, self.height);
}
@end
