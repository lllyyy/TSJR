//
//  StockIndexHandicapCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/14/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockHandicapCell : UICollectionViewCell
+(instancetype)cellWithCollect:(UICollectionView *)collect idxPath:(NSIndexPath *)idxPath;
@property (nonatomic, weak) UILabel *key1;
@property (nonatomic, weak) UILabel *key2;
@property (nonatomic, weak) UILabel *val;
@end
