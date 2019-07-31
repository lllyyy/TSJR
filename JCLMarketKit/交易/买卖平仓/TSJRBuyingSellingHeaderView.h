//
//  TSJRBuyingSellingCell.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/15.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSJRSearchStockView.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSJRBuyingSellingHeaderView : UIView


@property (nonatomic,strong)TSJRSearchStockView *searchStockView;

@property (nonatomic,strong)UILabel *buyingA;
@property (nonatomic,strong)UILabel *linA;
@property (nonatomic,strong)UILabel *linB;
@property (nonatomic,strong)UILabel *bglin;
@property (nonatomic,strong)UILabel *selling;
@property (nonatomic,strong)UILabel *linC;
@property (nonatomic,strong)UILabel *linD;

@property (nonatomic,strong)UILabel *bglinA;

@property (nonatomic,strong)UIButton *buyingB;
@property (nonatomic,strong)UILabel *bglinB;
@property (nonatomic,strong)UIButton *buyingC;
@property (nonatomic,strong)UILabel *linbottom;

@end

NS_ASSUME_NONNULL_END
