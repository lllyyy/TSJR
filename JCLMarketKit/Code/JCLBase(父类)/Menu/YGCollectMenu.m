//
//  YGCollectMenu.m
//  NongGe_iOS
//
//  Created by 邢昭俊 on 2017/6/25.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "YGCollectMenu.h"
#import "YGCollectMenuCell.h"

@implementation YGCollectMenu
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JCL_Bg_COL;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.collect = [JCLKitObj JCLCollect:self target:self frame:self.bounds style:2];
    self.collect.backgroundColor = JCL_Bg_COL;
    [self.collect registerClass:[YGCollectMenuCell class] forCellWithReuseIdentifier:@"cell"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{ return self.arr.count; }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YGCollectMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (self.isSever) {
        NSDictionary *dic = self.arr[indexPath.row];
        cell.text.text = [dic objectForKey:@"name"];
    } else {
        cell.text.text = self.arr[indexPath.row];
    }

    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{ return CGSizeMake(0.2*(self.width - 6*10), (self.height-6*10)/5); }
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSDictionary *dic;
    if (self.isSever) {
        dic = self.arr[indexPath.row];
    } else {
        dic = @{@"id" : [NSString stringWithFormat:@"%ld",indexPath.row], @"text" : self.arr[indexPath.row]};
    }
    !self.selectActionBlock ? : self.selectActionBlock(dic);
}
@end
