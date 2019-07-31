//
//  StockIndexPlateCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockPlateCell : UICollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, weak) UIView *bg;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *subTitle;
@property (nonatomic, weak) UILabel *ratio;
@property (nonatomic, weak) UILabel *subRatio;

@property(nonatomic, copy) void (^actionBlock)();
@property (nonatomic, assign) BOOL isScroll;
@end
