//
//  JCLManager.h
//  Jincelue_iOS
//
//  Created by 刘虎超 on 2017/1/18.
//  Copyright © 2017年 ruixue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCLManager : NSObject
+ (instancetype)shareManager;
@property(nonatomic,strong)NSMutableArray *main_flag;
@property(nonatomic,strong)NSMutableArray *Holder;
@property(nonatomic,strong)NSMutableArray *CCDataArray;
@property(nonatomic,strong)NSMutableArray *CDDataArray;
@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,copy)NSArray *array;
@property(nonatomic,copy)NSString *bank_name;
@end
