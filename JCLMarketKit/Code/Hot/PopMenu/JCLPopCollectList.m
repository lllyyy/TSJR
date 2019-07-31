//
//  JCLPopMenu.m
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/6/23.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLPopCollectList.h"
#import "JCLPopCollectCell.h"
#import "JCLStockMain.h"

@interface JCLPopCollectList()
@property(nonatomic, weak) UILabel *title;
@end

@implementation JCLPopCollectList
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 8; self.layer.borderWidth = 1.4; self.layer.borderColor = JCLRGBA(237, 142, 52, 1).CGColor;
        self.title = [JCLKitObj JCLLable:self font:14 color:nil alignment:1]; self.title.text = @"参与个股";
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.title.frame = self.title.frame = CGRectMake(0, 0, self.width, 34);

    self.collect = [JCLKitObj JCLCollect:self target:self frame:CGRectMake(0, self.title.maxY, self.width, self.height-self.title.maxY) style:2];
    self.collect.backgroundColor = [UIColor whiteColor];
    [self.collect registerClass:[JCLPopCollectCell class] forCellWithReuseIdentifier:@"cell"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{ return self.arr.count; }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JCLPopCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.text.text = self.arr[indexPath.row][0];
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{ return CGSizeMake(0.5*(self.width - 2), 30); }

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 2, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBar.selectedViewController;
    JCLStockMain *list = [[JCLStockMain alloc]init]; list.arr = self.arr[indexPath.row];
    [nav pushViewController:list animated:YES];
}

@end
