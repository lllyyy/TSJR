
#import "MMDBBaseStore.h"
#import "JCLCodeNameModel.h"

@interface TSJRDBCodeStore : MMDBBaseStore
#pragma mark - 添加
/**
 *  添加记录
 */
- (BOOL)addMessageNotice:(JCLCodeNameModel *)model;

#pragma mark - 查询
/**
 *  所有消息
 */
- (NSArray *)fetchMessage;

/*
 *  未读消息
 */
- (int)countUnreadMessage;

#pragma mark - 删除
/**
 *  删除消息
 */
- (BOOL)deleteMessageNotice:(int)idd;

#pragma mark - 更新
/**
 *  更新消息为已读
 */
- (BOOL)updateReadNoticeMessage:(int)idd;
    

- (NSString *)fetchMessage:(NSString *)codeStr  ;

- (BOOL)deleteTable;
@end
