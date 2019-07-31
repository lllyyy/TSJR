//
//  StockIndexPriceView.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockPrice.h"
#import "JCLStockPriceCell.h"
#import "JCLBaseMenu.h"

@interface JCLStockPrice()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collect;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, assign) CGFloat max;
@property (nonatomic, assign) CGFloat min;
@end

@implementation JCLStockPrice
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) { self.backgroundColor = JCL_Bg_COL; } return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.collect == nil) {
        JCLBaseMenu *menu = [[JCLBaseMenu alloc]init]; [self addSubview:menu];
        menu.frame = CGRectMake(0, 0, self.width, 40);
        menu.isLine = YES; menu.arr = @[@"价格", @"成交量", @"竞买率 %", @"比例"];
        
        self.collect = [JCLKitObj JCLCollect:self target:self frame:CGRectMake(0, menu.maxY, self.width, self.height - menu.maxY) cell:[JCLStockPriceCell class] ident:@"StockPriceCell" style:0];
        self.collect.backgroundColor = JCL_Bg_COL;
        if (!self.isScroll) { self.collect.scrollEnabled = NO; }
    }
    [self setNeedsDate];
}

-(void)setNeedsDate{
    if (self.code.length) {
        [JCLStockDataObj JCLGetStockPriceInfo:JCLMarketURL code:self.code page:@"0" number:@"100" success:^(NSArray * obj) {
            if (obj.count > 3) {
                self.arr = [JCLHttpsObj JCLHandleStr:obj begin:2 end:obj.count - 3];
                NSMutableArray *arrM = [[NSMutableArray alloc]init];
                [self.arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [arrM addObject:obj[1]];
                }];
                self.max = [[arrM valueForKeyPath:@"@max.floatValue"] floatValue];
                self.min = [[arrM valueForKeyPath:@"@min.floatValue"] floatValue];
                [self.collect reloadData];
            }
        } failure:^(NSError *error) { }];
    }
}

#pragma mark ---- 3.DataSource/Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{ return self.arr.count; }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JCLStockPriceCell *cell = [JCLStockPriceCell cellWithCollect:collectionView idxPath:indexPath];
    if (indexPath.row % 2 == 0){
        cell.backgroundColor = JCL_Cell_COL;
    } else {
        cell.backgroundColor = JCL_Cell_COL;
    }
    
    id obj = self.arr[indexPath.row]; //mai/(mai4+mai)*100
    cell.price.text = [JCLMarketObj JCLMarketPrice:[obj[0] floatValue] decimal:self.decimal];
    cell.price.textColor = [JCLMarketObj JCLMarketColor:obj[0] close:self.infoArr[1]];
    cell.number.text = [JCLMarketObj JCLMarketUnit:obj[1] decimal:self.decimal style:2];
    
    CGFloat val = [obj[1] floatValue];
    cell.ratio.text = [NSString stringWithFormat:@"%.2lf", [obj[2] floatValue] / val *100];
    
    if (self.arr.count>1) {
        cell.buyVal = [obj[2] floatValue] / (self.max - self.min);
        cell.sellVal = [obj[3] floatValue] / (self.max - self.min);
    } else {
        cell.buyVal = [obj[2] floatValue] / [obj[1] floatValue];
        cell.sellVal = [obj[3] floatValue] / [obj[1] floatValue];
    }
    cell.arr = obj;
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{ return 0; }
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{  return 0; }
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.isScroll ? CGSizeMake(self.width, 40) : CGSizeMake(self.width, (self.height - 40)/4);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{ return UIEdgeInsetsMake(0, 0, 0, 0); }
@end
