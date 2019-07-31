//
//  JCLMarketOptionModel.h
//  Jincelue_iOS
//
//  Created by 邢昭俊 on 2017/3/24.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLMarketOptionModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *riseFall;
@property (nonatomic,strong) NSString *zdycode;
@property (nonatomic,strong) NSString *zdyname;
@property (nonatomic,strong) NSString *stockcode;
@property (nonatomic,strong) NSString *setcode;
@property (nonatomic, assign) BOOL isEdit;
@end
