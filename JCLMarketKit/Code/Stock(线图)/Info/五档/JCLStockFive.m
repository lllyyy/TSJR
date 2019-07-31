//
//  StockIndexFive.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockFive.h"
#import "JCLStockFiveCell.h"

@interface JCLStockFive()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collect;
@property (nonatomic, strong) NSArray *buyArr;
@property (nonatomic, strong) NSArray *sellArr;
@property (nonatomic, assign) CGFloat max;
@property (nonatomic, assign) BOOL isLine;
@end

@implementation JCLStockFive
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) { self.backgroundColor = JCL_Bg_COL; } return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.collect == nil) {
        self.collect = [JCLKitObj JCLCollect:self target:self frame:CGRectMake(0, 0, self.width, self.height) cell:[JCLStockFiveCell class] ident:@"StockFiveCell" style:0];
        if (!self.isScroll) { self.collect.scrollEnabled = NO; }
        self.collect.backgroundColor = JCL_Bg_COL;
        [self setNeedsDate];
    }
}

-(void)setNeedsDate{
    if (self.code.length) {
        [JCLStockDataObj JCLGetStockFiveInfo:JCLMarketURL code:self.code success:^(NSArray *obj) {
            self.sellArr = [JCLHttpsObj JCLHandleStr:obj begin:3 end:5];
            self.buyArr = [JCLHttpsObj JCLHandleStr:obj begin:8 end:5];
            NSMutableArray *arrM = [[NSMutableArray alloc]init];
            [self.sellArr enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) { [arrM addObject:obj[1]]; }];
            [self.buyArr enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) { [arrM addObject:obj[1]]; }];
            self.max = [[arrM valueForKeyPath:@"@sum.floatValue"] floatValue];
            [self.collect reloadData];
        } failure:^(NSError *error) { }];
    }
}

#pragma mark ---- 3.DataSource/Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.isScroll) {
        return self.sellArr.count + self.buyArr.count + 1;
    } else {
        return self.sellArr.count + self.buyArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JCLStockFiveCell *cell = [JCLStockFiveCell cellWithCollect:collectionView idxPath:indexPath];
    if (self.isScroll) {
        cell.isScroll = YES;
        NSString *val = @"";
        if (indexPath.row < self.buyArr.count) {
            NSInteger number = self.sellArr.count - (long)indexPath.row;
            cell.title.text = [NSString stringWithFormat:@"卖%ld", (long)number];
            cell.price.text = [JCLMarketObj JCLMarketPrice:[self.buyArr[number - 1][0] floatValue] decimal:self.decimal];
            cell.number.text = [JCLMarketObj JCLMarketUnit:self.buyArr[number - 1][1] decimal:nil style:2];
            val = self.buyArr[number - 1][1];
        } else if (indexPath.row == 5) {
               // cell.isLine = YES;
        } else {
            NSInteger number = (long)indexPath.row - self.buyArr.count;
            cell.title.text = [NSString stringWithFormat:@"买%ld", (long)number];
            cell.price.text = [JCLMarketObj JCLMarketPrice:[self.sellArr[number -1][0] floatValue] decimal:self.decimal];
            cell.number.text = [JCLMarketObj JCLMarketUnit:self.sellArr[number -1][1] decimal:nil style:2];
            val = self.sellArr[number -1][1];
        }
        
        if (cell.number.text.floatValue == 0) {
            cell.w = 0;
        } else {
            CGFloat w = val.floatValue/self.max;
            if (w < 0.004) {
                w = 0.004;
            }
            cell.w = w;
        }
        cell.price.textColor = [JCLMarketObj JCLMarketColor:cell.price.text close:self.infoArr[1]];
        cell.scale.backgroundColor = cell.price.textColor;
        if([cell.price.text floatValue]==0.00){
            cell.price.textColor=JCL_Text_COL;
        }
    } else {
        if (indexPath.row % 4 == 2 || indexPath.row % 4 == 3){
            cell.backgroundColor = JCL_Cell_COL;
        } else {
            cell.backgroundColor = JCL_Cell_COL;
        }
        
        if (indexPath.row % 2 == 0) {
            NSArray *arr = [[self.buyArr reverseObjectEnumerator] allObjects];
            cell.title.text = [NSString stringWithFormat:@"卖%ld", 5-(long)indexPath.row/2];
            cell.price.text = [JCLMarketObj JCLMarketPrice:[arr[indexPath.row/2][0] floatValue] decimal:self.decimal];
            cell.number.text = [JCLMarketObj JCLMarketUnit:arr[indexPath.row/2][1] decimal:nil style:2];
        } else {
            NSArray *arr = self.sellArr;//[[self.sellArr reverseObjectEnumerator] allObjects];
            cell.title.text = [NSString stringWithFormat:@"买%ld", (long)indexPath.row/2+1];
            cell.price.text = [JCLMarketObj JCLMarketPrice:[arr[indexPath.row/2][0] floatValue] decimal:self.decimal];
            cell.number.text = [JCLMarketObj JCLMarketUnit:arr[indexPath.row/2][1] decimal:nil style:2];
        }
        
        cell.price.textColor = [JCLMarketObj JCLMarketColor:cell.price.text close:self.infoArr[1]];
        if([cell.price.text floatValue]==0.00){
            cell.price.textColor=JCL_Text_COL;
        }
    }
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{ return 0; }
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{  return 0; }
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isScroll) {
        if (indexPath.row < self.buyArr.count) {
            return CGSizeMake(self.width, 40);
        } else if (indexPath.row == 5) {
            return CGSizeMake(self.width, 1.4);
        } else {
            return CGSizeMake(self.width, 40);
        }
    } else {
        return CGSizeMake(0.5*(self.width - 1), self.height/5);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{ return UIEdgeInsetsMake(0, 0, 1, 0); }

@end
