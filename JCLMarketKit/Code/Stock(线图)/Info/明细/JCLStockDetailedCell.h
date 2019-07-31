//
//  StockIndexDetailedCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockDetailedCell : UICollectionViewCell
+(instancetype)cellWithCollect:(UICollectionView *)collect idxPath:(NSIndexPath *)idxPath;
@property (nonatomic, weak) UILabel *time;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UILabel *number;
@property (nonatomic, weak) UILabel *type;
@end
