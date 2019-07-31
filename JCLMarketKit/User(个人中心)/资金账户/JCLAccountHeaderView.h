//
//  JCLAccountHeaderView.h
//  JCLMarketKit
//
//  Created by 卢杨 on 2019/2/18.
//  Copyright © 2019 邢昭俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCLAccountModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JCLAccountHeaderView : UITableViewCell
@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UILabel *baseLB;

@property (nonatomic, strong) UILabel *blogo;

@property (nonatomic, strong) UIImageView *moreRight;
@property (nonatomic, strong) UILabel *lin;

@property (nonatomic, strong) UILabel *titleA;
@property (nonatomic, strong) UILabel *digitalA;

@property (nonatomic, strong) UILabel *titleB;
@property (nonatomic, strong) UILabel *digitalB;

@property (nonatomic, strong) UILabel *titleC;
@property (nonatomic, strong) UILabel *digitalC;

@property (nonatomic, strong) UILabel *titleD;
@property (nonatomic, strong) UILabel *digitalD;

@property (nonatomic, strong) UILabel *titleE;
@property (nonatomic, strong) UILabel *digitalE;

@property (nonatomic, strong) UILabel *titleF;
@property (nonatomic, strong) UILabel *digitalF;

@property (nonatomic, strong) UILabel *titleG;
@property (nonatomic, strong) UILabel *digitalG;

@property (nonatomic, strong) UILabel *titleH;
@property (nonatomic, strong) UILabel *digitalH;


-(void)setDataModel:(JCLAccountModel *)model account:(NSInteger)account;


@end

NS_ASSUME_NONNULL_END
