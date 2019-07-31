
#import "TSJRDBCodeStore.h"
#import "MMDBMessageNoticeStoreSQL.h"

@implementation TSJRDBCodeStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [MMDBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            NSLog(@"DB: 消息通知表创建失败");
        }
    }
    return self;
}


- (BOOL)createTable
{
    
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_MESSAGE_NOTICE_TABLE, MESSAGE_NOTICE_TABLE_NAME];
    return [self createTable:MESSAGE_NOTICE_TABLE_NAME withSQL:sqlString];
}

- (BOOL)addMessageNotice:(JCLCodeNameModel *)model {
  
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_MESSAGE_NOTICE, MESSAGE_NOTICE_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        model.name, model.symbol, nil];
    NSLog(@"arrPara %@",model.name);
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    if (ok) {
        NSLog(@"保存成功");
        [JCLUserSession setDB:@"保存成功"];
    }
    return ok;
}




- (NSString *)fetchMessage:(NSString *)codeStr {
//    __block NSMutableArray *messages = @[].mutableCopy;
    __block NSString *str = @"";
    NSString *sqlString = [NSString stringWithFormat: SQL_SELECT_CODE, MESSAGE_NOTICE_TABLE_NAME,codeStr];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
 
        while ([retSet next]) {
 
//             NSLog(@"retSet  %@",retSet.resultDictionary);
            JCLCodeNameModel *message = [JCLCodeNameModel modelWithDictionary: retSet.resultDictionary];
            str = message.name;
//            [messages addObject:message.name];
//            NSLog(@"retSet  %@",messages);
 
        }
        [retSet close];
    }];
//     NSLog(@"strstrstr  %@",str);
    return str;
}

- (NSArray *)fetchMessage {
    __block NSMutableArray *messages = @[].mutableCopy;
    
    NSString *sqlString = [NSString stringWithFormat: SQL_SELECT_MESSAGE_NOTICE, MESSAGE_NOTICE_TABLE_NAME];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
           // NSLog(@"retSet  %@",retSet.resultDictionary);
            JCLCodeNameModel *message = [JCLCodeNameModel modelWithDictionary: retSet.resultDictionary];
            NSLog(@"------- %@",message.name);
            [messages addObject:message];
        }
        [retSet close];
    }];
    return messages;
}

- (int)countUnreadMessage {
    __block  int count = 0;
    
    NSString *sqlString = [NSString stringWithFormat: SQL_COUNT_MESSAGE_NOTICE, MESSAGE_NOTICE_TABLE_NAME];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        if ([retSet next]) {
            count = [retSet intForColumnIndex:0];
        }
        [retSet close];
    }];
    return count;
    
}

- (BOOL)deleteMessageNotice:(int)idd {
    
    NSString *sqlString = [NSString stringWithFormat:SQL_DELECT_MESSAGE_NOTICE, MESSAGE_NOTICE_TABLE_NAME, idd];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
    
}

- (BOOL)updateReadNoticeMessage:(int)idd {
    
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_MESSAGE_NOTICE, MESSAGE_NOTICE_TABLE_NAME, 1, idd];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
    
}
- (BOOL)deleteTable{
    
    NSString *sqlString = [NSString stringWithFormat: SQL_DELECT_TABLE, MESSAGE_NOTICE_TABLE_NAME];
    BOOL ok = [self excuteSQL:sqlString];
    return ok;
}
@end
