//
//  TSJRTradingMainCell.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/22.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSJRTradingMainCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleA;
@property (nonatomic, strong) UILabel *titleB;
@property (nonatomic, strong) UILabel *titleC;
@property (nonatomic, strong) UILabel *titleD;
@property (nonatomic, strong) UILabel *titleE;
@property (nonatomic, strong) UILabel *titleF;
@property (nonatomic, strong) UILabel *titleG;
@property (nonatomic, strong) UILabel *titleH;
-(void)setTradingOrderModel:(id)idModel;
@end

NS_ASSUME_NONNULL_END
