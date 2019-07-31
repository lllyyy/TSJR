//
//  StockIndexFiveCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockFiveCell : UICollectionViewCell
+(instancetype)cellWithCollect:(UICollectionView *)collect idxPath:(NSIndexPath *)idxPath;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UILabel *number;
@property (nonatomic, assign) BOOL isScroll;

@property(nonatomic, weak) UIView *scale;
@property (nonatomic, assign) CGFloat w;

@property (nonatomic, weak) UIView *line;
@property (nonatomic, assign) BOOL isLine;
@end
