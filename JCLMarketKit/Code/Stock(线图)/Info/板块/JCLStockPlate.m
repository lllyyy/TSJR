//
//  StockIndexPlateView.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockPlate.h"
#import "JCLStockPlateCell.h"

@interface JCLStockPlate()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, weak) UICollectionView *collect;
@property(nonatomic, strong) NSArray *arr;
@end

@implementation JCLStockPlate
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) { self.backgroundColor = JCL_Bg_COL; } return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.collect == nil) {
        self.collect = [JCLKitObj JCLCollect:self target:self frame:self.bounds cell:[JCLStockPlateCell class] ident:@"PlateCell" style:0];
        self.collect.delegate = self;
        self.collect.backgroundColor = JCL_Bg_COL;
        if (!self.isScroll) { self.collect.scrollEnabled = NO; }
    }
    [self setNeedsDate];
}

-(void)setNeedsDate{
    if (self.code.length) {
        [JCLStockDataObj JCLGetStockPlateInfo:JCLMarketURL code:self.code
                                         page:@"0"
                                       number:@"100"
                                     mianSort:@"0*1*2*6"
                                      subSort:@"0*1*2*6" success:^(NSArray *obj) {
                                          if (obj.count > 2) {
                                              self.arr = [JCLHttpsObj JCLHandleStr:obj begin:1 end:obj.count - 2];
                                          }
                                          [self.collect reloadData];
                                      } failure:^(NSError *error) { }];
    }
}

#pragma mark ---- 3.DataSource/Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{ return self.arr.count; }
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JCLStockPlateCell *cell = [JCLStockPlateCell cellWithCollectionView:collectionView indexPath:indexPath];
    if (indexPath.row %5 == 0) {
        cell.bg.backgroundColor = JCLRGBA(13, 103, 204, 1);
    } else if (indexPath.row %5 == 1) {
        cell.bg.backgroundColor = JCLRGBA(219, 100, 171, 1);
    } else if (indexPath.row %5 == 2) {
        cell.bg.backgroundColor = JCLRGBA(253, 145, 0, 1);
    } else if (indexPath.row %5 == 3) {
        cell.bg.backgroundColor = JCLRGBA(37, 208, 202, 1);
    } else if (indexPath.row %5 == 4) {
        cell.bg.backgroundColor = JCLRGBA(116, 201, 245, 1);
    }
    id obj = self.arr[indexPath.row];
    cell.title.text = obj[1];
    cell.ratio.text = [JCLMarketObj JCLMarketScale:[JCLMarketObj JCLMarketRange:obj[3] close:obj[2]] close:obj[2]];
    cell.subTitle.text = obj[5];
    cell.subRatio.text = [JCLMarketObj JCLMarketScale:[JCLMarketObj JCLMarketRange:obj[7] close:obj[6]] close:obj[6]];
    if (self.isScroll) {
        cell.isScroll = YES;
        cell.actionBlock = ^{
            id obj = self.arr[indexPath.row];
            !self.actionBlock ? : self.actionBlock(@[obj[1], obj[0]]);
        };
    }

    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{ return 0; }
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{ return 0; }
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.isScroll ? CGSizeMake(self.width/3, 86) : CGSizeMake(self.width/3, (self.height - 10)/2);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{ return UIEdgeInsetsMake(0, 0, 0, 0);}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id obj = self.arr[indexPath.row];
    !self.actionBlock ? : self.actionBlock(@[obj[0], obj[1]]);
}
@end
