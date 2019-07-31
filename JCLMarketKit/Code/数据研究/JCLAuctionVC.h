//
//  JCLAuctionVC.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/3/30.
//  Copyright © 2017年 刘虎超. All rights reserved.
//  集合竞价

#import "JCLBaseVC.h"

@interface JCLAuctionVC : JCLBaseVC
@property (nonatomic,copy )  void(^AuctionAction)(NSArray *array);
- (void)loadData;
@end
