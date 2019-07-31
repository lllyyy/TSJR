//
//  TSJRTradingMainHeaderView.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/3/14.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSJRTradingMainHeaderView : UIView
@property (nonatomic,strong)UIButton *bgBtn;
@property (nonatomic,strong)UIImageView *imagev;
@property (nonatomic,strong)UILabel *titleA;
@property (nonatomic,strong)UILabel *currency;
@property (nonatomic,strong)UILabel *market;
@property (nonatomic,strong)UILabel *unrealizedPnl;
@property (nonatomic,strong)UIImageView *rightMore;

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *linA;
@property (nonatomic,strong) UILabel *titleB;
@property (nonatomic,strong) UIButton *titleC;
@property (nonatomic,strong) UILabel *titleD;
@property (nonatomic,strong) UIButton *titleE;

-(void)setData:(id)model;
@end

NS_ASSUME_NONNULL_END
