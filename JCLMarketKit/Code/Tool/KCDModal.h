//
//  KCDModal.h
//  交易
//
//  Created by 刘虎超 on 2016/11/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCDModal : NSObject
//可撤单
@property(nonatomic,strong)NSString *stock_code;
@property(nonatomic,assign)double entrust_price;
@property(nonatomic,assign)int entrust_vol;
@property(nonatomic,copy)NSString *entrust_time;
@property(nonatomic,strong)NSString *entrust_date;
@property(nonatomic,assign)int entrust_type;
@property(nonatomic,strong)NSString *stock_name;
@property(nonatomic,assign)int entrust_no;
@property(nonatomic,assign)int exchange_type;
@property(nonatomic,assign)int business_vol;
@property (nonatomic,assign) NSInteger entrust_bs;
@end

@interface JCLMyCC : NSObject
@property(nonatomic,strong)NSString *stock_code;
@property(nonatomic,strong)NSString *stock_name;
@property(nonatomic,assign)int current_vol;
@property(nonatomic,assign)double entrust_price;
@property(nonatomic,assign)double keep_cost_price;
@property(nonatomic,assign)double income_balance;
@property(nonatomic,assign)double last_price;
@property(nonatomic,assign)double enable_vol;
@property(nonatomic,strong)NSString *position;
@end


@interface LoginModal : NSObject
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *headPicture;
@property(nonatomic,strong)NSString *telephone;
@property(nonatomic,strong)NSString *ucname;
@property(nonatomic,strong)NSString *openid;
@property(nonatomic,strong)NSString *registfrom;
@end


@interface PHBModal : NSObject
@property(nonatomic,strong)NSString *client_id;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,assign)NSInteger subscribenum;
@property(nonatomic,assign)NSInteger sort;
@property(nonatomic,assign)double  total_rate;
@property(nonatomic,assign)double  total_balance;
@property(nonatomic,assign)double  position_rate;
@property(nonatomic,strong)NSString *max_stock;
@property(nonatomic,assign)double week_profit;
@property(nonatomic,assign)double day_profit;
@property(nonatomic,assign)double data;
@end

@interface MyDS : NSObject
@property(nonatomic,strong)NSString *headPicture;
@property(nonatomic,strong)NSString *regionName;
@property(nonatomic,strong)NSString *startTime;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,assign)NSInteger totalPeople;
@property(nonatomic,strong)NSString *gameId;
@property(nonatomic,strong)NSString *status;
@end

@interface SCModal : NSObject
@property(nonatomic,strong)NSString *average_rate;
@property(nonatomic,strong)NSString *createdate;
@property(nonatomic,strong)NSString *game_id;
@property(nonatomic,strong)NSString *game_name;
@property(nonatomic,strong)NSString *gameusers;
@property(nonatomic,strong)NSString *sort;
@end


@interface OtherModal : NSObject
@property(nonatomic,strong)NSString *headPicture;
@property(nonatomic,strong)NSString *integration;
@property(nonatomic,strong)NSString *openid;
@property(nonatomic,strong)NSString *registfrom;
@property(nonatomic,strong)NSString *telephone;
@property(nonatomic,strong)NSString *ucname;
@property(nonatomic,strong)NSString *username;
@end

@interface GSBModal : NSObject
@property(nonatomic,strong)NSString *client_id;
@property(nonatomic,strong)NSString *game_id;
@property(nonatomic,strong)NSString *game_name;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,assign)int sort;
@property(nonatomic,assign)int subscribenum;
@property(nonatomic,assign)double success_rate;
@property(nonatomic,assign)double withdraw;
@property(nonatomic,assign)double rate10;
@property(nonatomic,assign)double  total_rate;
@end
//策略排行榜Modal
@interface CLRankModel : NSObject
@property(nonatomic,copy)NSString *client_id;
@property(nonatomic,assign)double rate;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *photoName;
@end

//我的观点Model
@interface JCLViewPointModel : NSObject
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)int  docContentId;
@property(nonatomic,assign)int  titleShow;
@end
