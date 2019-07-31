//
//  StockIndexPriceCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockPriceCell : UICollectionViewCell
+(instancetype)cellWithCollect:(UICollectionView *)collect idxPath:(NSIndexPath *)idxPath;

@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UILabel *number;
@property (nonatomic, assign) UILabel *ratio;

@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, assign) CGFloat buyVal;
@property (nonatomic, assign) CGFloat sellVal;
@end
