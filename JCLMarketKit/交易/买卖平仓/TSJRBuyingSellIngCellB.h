//
//  TSJRBuyingSellIngCellB.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/15.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMChangeQuantityView.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSJRBuyingSellIngCellB : UITableViewCell
@property (nonatomic,strong) UILabel *titleA;
@property (nonatomic,strong) MMChangeQuantityView *changeQuantityView;
@property (nonatomic,strong)UILabel *linbottom;
@end

NS_ASSUME_NONNULL_END
