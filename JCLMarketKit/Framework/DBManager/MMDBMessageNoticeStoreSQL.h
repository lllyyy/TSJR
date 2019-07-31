 
#ifndef MMDBMessageNoticeStoreSQL_h
#define MMDBMessageNoticeStoreSQL_h

#define     MESSAGE_NOTICE_TABLE_NAME        @"codeName_Model"

#define     SQL_CREATE_MESSAGE_NOTICE_TABLE @"CREATE TABLE IF NOT EXISTS %@(\
                                            id INTEGER PRIMARY KEY AUTOINCREMENT,\
                                            name TEXT,\
                                            symbol TEXT)"

#define     SQL_ADD_MESSAGE_NOTICE  @"REPLACE INTO %@ (name, symbol) VALUES (?, ?)"

#define     SQL_SELECT_MESSAGE_NOTICE   @"SELECT * FROM %@ ORDER BY id DESC"
#define     SQL_DELECT_MESSAGE_NOTICE   @"DELETE FROM %@ WHERE id = %d"
#define     SQL_UPDATE_MESSAGE_NOTICE   @"UPDATE %@ SET isRead = %d WHERE id = %d"
#define     SQL_COUNT_MESSAGE_NOTICE    @"SELECT count(*) FROM %@"
#define     SQL_SELECT_CODE             @"SELECT * FROM %@ WHERE symbol = '%@'"
#define      SQL_DELECT_TABLE            @"DELETE FROM %@"
#endif /* MMDBMessageNoticeStoreSQL_h */
