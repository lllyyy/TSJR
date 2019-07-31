//
//  JCLStockMsgDetail.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/5/11.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//  公告和研报详情

#import "YSTableList.h"

@interface JCLStockMsgDetail : YSTableList
//0是公告 1是研报
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) NSString *code;
@end
