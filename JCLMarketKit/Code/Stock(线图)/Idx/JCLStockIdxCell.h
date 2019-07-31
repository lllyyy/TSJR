//
//  JCLStockIdxCell.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 10/11/16.
//  Copyright © 2016 ruixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLStockIdxCell : UICollectionViewCell
@property (nonatomic, weak) UILabel *code;
@property (nonatomic, weak) UILabel *price;
@property (nonatomic, weak) UILabel *range;
@property (nonatomic, weak) UILabel *scale;
@property (nonatomic, weak) UIButton *action;
@end
