//
//  TSJRQueryAssetCell.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/4/25.
//  Copyright © 2019 卢杨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSJRQueryAssetCell : UITableViewCell
@property(nonatomic,strong) UIImageView *imagV;
@property(nonatomic,strong) UILabel *titleLB;
@property(nonatomic,strong) UILabel *subTitle;

@property(nonatomic,strong) UIImageView *imagVA;
@property(nonatomic,strong) UILabel *titleLBA;
@property(nonatomic,strong) UILabel *subTitleA;

@property(nonatomic,strong) UIImageView *imagVB;
@property(nonatomic,strong) UILabel *titleLBB;
@property(nonatomic,strong) UILabel *subTitleB;

@property(nonatomic,strong) UIButton *openAccount;
@end

NS_ASSUME_NONNULL_END
