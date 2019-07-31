//
//  StockIndexDetailedView.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockDetailed.h"
#import "JCLStockDetailedCell.h"
#import "JCLStockDetailedModel.h"
#import "JCLDateObj.h"

@interface JCLStockDetailed()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collect;
@property (nonatomic, strong) NSMutableArray *arrM;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL isCount;
@end

@implementation JCLStockDetailed
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) { self.backgroundColor = JCL_Bg_COL; } return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.collect == nil) {
        self.collect = [JCLKitObj JCLCollect:self target:self frame:CGRectMake(0, 0, self.width, self.height) cell:[JCLStockDetailedCell class] ident:@"StockDetailedCell" style:0];
        self.collect.backgroundColor = JCL_Bg_COL;
        if (!self.isScroll) { self.collect.scrollEnabled = NO; }
//        self.collect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{ self.page = 0; [self setNeedsDate:NO]; }];
//        self.collect.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            if (self.isCount) {
//                self.page += self.number; [self setNeedsDate:YES];
//            } else {
//                [self.collect.mj_header endRefreshing]; [self.collect.mj_footer endRefreshing];
//            }
//        }];
        self.page = 0, self.number = 40;
    }
    
    [self setNeedsDate:NO];
}

-(NSMutableArray *)arrM{ if (_arrM) return _arrM; return _arrM = [[NSMutableArray alloc]init]; }
-(void)setNeedsDate:(BOOL)is{
    if (self.code.length) {
        [JCLStockDataObj JCLGetStockDetailInfo:JCLMarketURL code:self.code page:[NSString stringWithFormat:@"%ld", (long)self.page] number:@"100" success:^(id obj) {
            NSArray *arr = [JCLStockDetailedModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
//            if (arr.count) {
//                is ? : [self.arrM removeAllObjects]; self.isCount = YES;
                [self.arrM removeAllObjects];
                [self.arrM addObjectsFromArray:arr];
//            } else {
//                self.isCount = NO; self.page -= 20;
//            }
            [self.collect reloadData];
            [self.collect.mj_header endRefreshing]; [self.collect.mj_footer endRefreshing];
        } failure:^(NSError *error) { [self.collect.mj_header endRefreshing]; [self.collect.mj_footer endRefreshing]; }];
    }
}

#pragma mark ---- 3.DataSource/Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{ return self.arrM.count; }
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JCLStockDetailedCell *cell = [JCLStockDetailedCell cellWithCollect:collectionView idxPath:indexPath];
    if (indexPath.row % 4 == 2 || indexPath.row % 4 == 3){
        cell.backgroundColor = JCL_Cell_COL;
    } else {
        cell.backgroundColor = JCL_Cell_COL;
    }
    JCLStockDetailedModel *model = self.arrM[indexPath.row];
    cell.time.text = [JCLDateObj JCLTime:model.minute];
    cell.price.text = [JCLMarketObj JCLMarketUnit:model.now decimal:self.decimal style:1];
    cell.price.textColor = [JCLMarketObj JCLMarketColor:model.now close:self.infoArr[1]];
    cell.number.text = [JCLMarketObj JCLMarketUnit:model.nowvol decimal:nil style:2];
    if (model.flag.integerValue == 1) {
        cell.type.text = @"S"; cell.type.textColor = JCLFALLRGB; cell.number.textColor = JCLFALLRGB;
    } else {
        cell.type.text = @"B"; cell.type.textColor = JCLMAINRGB; cell.number.textColor = JCLMAINRGB;
    }
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{ return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{ return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.isScroll ? CGSizeMake(0.5*(self.width - 1), 40) : CGSizeMake(0.5*(self.width - 1), self.height/5);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{ return UIEdgeInsetsMake(0, 0, 1.5, 0); }

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
