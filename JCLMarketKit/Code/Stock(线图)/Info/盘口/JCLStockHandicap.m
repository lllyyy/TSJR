//
//  StockIndexHandicapView.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import "JCLStockHandicap.h"
#import "JCLStockHandicapCell.h"
@interface JCLStockHandicap()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collect;
@property (nonatomic, strong) NSArray *keyArr1;
@property (nonatomic, strong) NSArray *keyArr2;
@property (nonatomic, strong) NSArray *valArr;
@end

@implementation JCLStockHandicap
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) { self.backgroundColor = JCL_Cell_COL; } return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.collect == nil) {
        self.collect = [JCLKitObj JCLCollect:self target:self frame:CGRectMake(0, 0, self.width, self.height) cell:[JCLStockHandicapCell class] ident:@"HandicapCell" style:0];
        self.collect.backgroundColor = JCL_Cell_COL;
        if (!self.isScroll) { self.collect.scrollEnabled = NO; }
    }
    
    if ([JCLMarketObj JCLMarketIdx:self.code]) {
        self.keyArr1 = @[@"昨", @"今", @"均",
                         @"最", @"最", @"振",
                         @"总", @"总", @"换",
                         @"上", @"平", @"下"];
        self.keyArr2 = @[@"收", @"开", @"价",
                         @"高", @"低", @"幅",
                         @"额", @"量", @"手",
                         @"涨", @"盘", @"跌"];
    } else {
        if(self.isScroll) {
            self.keyArr1 = @[@"昨", @"今", @"最", @"最",
                             @"振", @"均", @"总", @"换",
                             @"总", @"量", @"外", @"内",
                             @"委", @"委", @"市", @"市",
                             @"流", @"流", @"总", @"总"];
            self.keyArr2 = @[@"收", @"开", @"高", @"低",
                             @"幅", @"价", @"额", @"手",
                             @"量", @"比", @"盘", @"盘",
                             @"比", @"差", @"盈", @"净",
                             @"股", @"值", @"本", @"值"];
        } else {
            self.keyArr1 = @[@"昨", @"外", @"内",
                             @"总", @"委", @"委",
                             @"振", @"市", @"市",
                             @"换", @"流", @"流",
                             @"量", @"总", @"总"];
            self.keyArr2 = @[@"收", @"盘", @"盘",
                             @"额", @"比", @"差",
                             @"幅", @"盈", @"净",
                             @"手", @"股", @"值",
                             @"比", @"本", @"值"];
        }
    }
    [self setNeedsDate];
}

-(void)setNeedsDate{
    if (self.code.length) {
        [JCLStockDataObj JCLGetStockInfo:JCLMarketURL code:self.code success:^(NSArray *obj) {
            NSArray *numberArr = [JCLHttpsObj JCLHandleStr:obj begin:2 end:obj.count - 4];
            NSArray *arr = [JCLHttpsObj JCLHandleStr:obj begin:3 end:obj.count - 4];
            if (arr) {
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    // 0   1   2   3    4     5     6    7     8     9  10  11  12    13      14   15  16  17  18      19
                    //今开,昨收,最高,最低,最新价,成交量,成交额,量比, 换手率,振幅,内盘,外盘,市盈率,流通市值,均价,委比,委差,市净,流通股本,总股本
                    
                    NSString *v9 = [obj[9] floatValue]>0 ? [NSString stringWithFormat:@"%.2lf%%", [obj[9] floatValue]]: @"--";
                    NSString *v8 = [obj[8] floatValue]>0 ? [NSString stringWithFormat:@"%.2lf%%", [obj[8] floatValue]]: @"--";
                    NSString *v7 = [obj[7] floatValue]>0 ? [NSString stringWithFormat:@"%.2lf", [obj[7] floatValue]]: @"--";
                    NSString *v17 = [obj[17] floatValue]>0 ? [NSString stringWithFormat:@"%.2lf", [obj[17] floatValue]]: @"--";
                    NSString *v12 = [obj[12] floatValue]>0 ? [NSString stringWithFormat:@"%.2lf", [obj[12] floatValue]]: @"--";
                    NSString *v13 = [obj[13] floatValue]>0 ? [NSString stringWithFormat:@"%.2lf亿", [obj[13] floatValue]]: @"--";
                    if ([JCLMarketObj JCLMarketIdx:self.code]) {
                        self.valArr = @[[JCLMarketObj JCLMarketPrice:[obj[1] floatValue] decimal:self.decimal],
                                        [JCLMarketObj JCLMarketPrice:[obj[0] floatValue] decimal:self.decimal],
                                        [JCLMarketObj JCLMarketUnit:obj[14] decimal:self.decimal style:1],
                                        [JCLMarketObj JCLMarketPrice:[obj[2] floatValue] decimal:self.decimal],
                                        [JCLMarketObj JCLMarketPrice:[obj[3] floatValue] decimal:self.decimal],
                                        v9,
                                        [JCLMarketObj JCLMarketUnit:obj[6] decimal:self.decimal style:1],
                                        [JCLMarketObj JCLMarketUnit:obj[5] decimal:self.decimal style:1],
                                        v8,
                                        [NSString stringWithFormat:@"%@家", [self RangeStr:numberArr[0][1]]],
                                        [NSString stringWithFormat:@"%@家", [self RangeStr:numberArr[0][3]]],
                                        [NSString stringWithFormat:@"%@家", [self RangeStr:numberArr[0][2]]]];
                    }else{
                        if(self.isScroll) {
                            self.valArr = @[[JCLMarketObj JCLMarketPrice:[obj[1] floatValue] decimal:self.decimal],
                                            [JCLMarketObj JCLMarketPrice:[obj[0] floatValue] decimal:self.decimal],
                                            [JCLMarketObj JCLMarketPrice:[obj[2] floatValue] decimal:self.decimal],
                                            [JCLMarketObj JCLMarketPrice:[obj[3] floatValue] decimal:self.decimal],
                                            
                                            v9,
                                            [JCLMarketObj JCLMarketPrice:[obj[14] floatValue] decimal:self.decimal],
                                            [JCLMarketObj JCLMarketUnit:obj[6] decimal:self.decimal style:1],
                                            v8,
                                            [JCLMarketObj JCLMarketUnit:obj[5] decimal:self.decimal style:1],
                                            v7,
                                            [JCLMarketObj JCLMarketUnit:obj[11] decimal:self.decimal style:2],
                                            [JCLMarketObj JCLMarketUnit:obj[10] decimal:self.decimal style:2],
                                            [NSString stringWithFormat:@"%.2lf%%", [obj[15] floatValue]],
                                            [JCLMarketObj JCLMarketUnit:obj[16] decimal:self.decimal style:1],
                                            v12,
                                            v17,
                                            
                                            [JCLMarketObj JCLMarketUnit:[NSString stringWithFormat:@"%f", [obj[18] floatValue]*10000] decimal:self.decimal style:1],
                                            v13,
                                            [JCLMarketObj JCLMarketUnit:[NSString stringWithFormat:@"%f", [obj[19] floatValue]*10000] decimal:self.decimal style:1],
                                            [JCLMarketObj JCLMarketUnit:[NSString stringWithFormat:@"%f", [obj[19] floatValue]*[obj[4] floatValue]*10000] decimal:self.decimal style:1]];
                        } else {
                            self.valArr = @[[JCLMarketObj JCLMarketUnit:obj[1] decimal:self.decimal style:1],
                                            [JCLMarketObj JCLMarketUnit:obj[11] decimal:self.decimal style:2],
                                            [JCLMarketObj JCLMarketUnit:obj[10] decimal:self.decimal style:2],
                                            [JCLMarketObj JCLMarketUnit:obj[6] decimal:self.decimal style:1],
                                            [NSString stringWithFormat:@"%.2lf%%", [obj[15] floatValue]],
                                            [JCLMarketObj JCLMarketUnit:obj[16] decimal:self.decimal style:1],
                                            v9,
                                            v12,
                                            v17,
                                            v8,
                                            
                                            [JCLMarketObj JCLMarketUnit:[NSString stringWithFormat:@"%f", [obj[18] floatValue]*10000] decimal:self.decimal style:1],
                                            v13,
                                            v7,
                                            [JCLMarketObj JCLMarketUnit:[NSString stringWithFormat:@"%f", [obj[19] floatValue]*10000] decimal:self.decimal style:1],
                                            [JCLMarketObj JCLMarketUnit:[NSString stringWithFormat:@"%f", [obj[19] floatValue]*[obj[4] floatValue]*10000] decimal:self.decimal style:1]];
                        }
                    }
                    
                }];
                [self.collect reloadData];
            }
        } failure:^(NSError *error) { }];
    }
}
-(NSString *)RangeStr:(NSString *)str{ return [str substringFromIndex:[str rangeOfString:@"="].location + 1]; }

#pragma mark ---- 3.DataSource/Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{ return self.keyArr1.count; }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JCLStockHandicapCell *cell = [JCLStockHandicapCell cellWithCollect:collectionView idxPath:indexPath];
    if (self.isScroll == NO) {
        if (indexPath.row  % 6 == 4 ||  indexPath.row  % 6 == 5 || indexPath.row  % 6 == 3){
            cell.backgroundColor = JCL_Cell_COL;
        } else {
            cell.backgroundColor = JCL_Cell_COL;
        }
    } else {
        if (indexPath.row  % 4 == 3 ||  indexPath.row  % 4 == 2){
            cell.backgroundColor = JCL_Cell_COL;
        } else {
            cell.backgroundColor = JCL_Cell_COL;
        }
    }
    
    if (indexPath.row == 1 ||  indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 0) {
        cell.key1.backgroundColor = JCLRGBA(250, 155, 0, 1);
    } else if (indexPath.row == 8 ||  indexPath.row == 9 || indexPath.row == 10 || indexPath.row == 11) {
        cell.key1.backgroundColor = JCLRGBA(249, 127, 22, 1);
    } else if (indexPath.row == 12 ||  indexPath.row == 13 || indexPath.row == 14 || indexPath.row == 15) {
        cell.key1.backgroundColor = JCLRGBA(236, 75, 54, 1);
    } else if (indexPath.row == 5) {
        cell.key1.backgroundColor = JCLRGBA(0, 120, 0, 1);
    } else {
        cell.key1.backgroundColor = JCLMAINRGB;
    }
    cell.key1.text = self.keyArr1[indexPath.row]; cell.key2.text = self.keyArr2[indexPath.row]; cell.val.text = self.valArr[indexPath.row];
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{ return 0; }
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{ return 1; }
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.isScroll ? CGSizeMake((self.width - 1)/2, 40) : CGSizeMake((self.width - 3*1)/3, (self.height - 1)/(self.keyArr1.count/3));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{ return UIEdgeInsetsMake(1, 0, 1.5, 0); }
@end
