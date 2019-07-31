#ifndef MMDoctor_TSJRConstants_h
#define MMDoctor_TSJRConstants_h



///------
/// NSLog
///------
#ifdef DEBUG
   // #define NSLog(...) NSLog(__VA_ARGS__)
    //#define NSLog(format, ...)  printf("\n[%s] %s [第%zd行] 💕 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
    #define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);



#else
 // #define NSLog(format, ...)  printf("\n[%s] %s [第%zd行] 💕 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
   //#define NSLog(...) NSLog(__VA_ARGS__)
   // #define NSLog(...) {}

 
#endif

#define MMLogError(error) NSLog(@"Error: %@", error)

 
///------
/// Block
///------

typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);

typedef void (^NetWorkBlock)(BOOL netConnetState);
//////////////////////////////

typedef void (^VoidBlock)();
typedef BOOL (^BoolBlock)();
typedef int  (^IntBlock) ();
typedef id   (^IDBlock)  ();

typedef void (^VoidBlock_int)(int);
typedef BOOL (^BoolBlock_int)(int);
typedef int  (^IntBlock_int) (int);
typedef id   (^IDBlock_int)  (int);

typedef void (^VoidBlock_string)(NSString *);
typedef BOOL (^BoolBlock_string)(NSString *);
typedef int  (^IntBlock_string) (NSString *);
typedef id   (^IDBlock_string)  (NSString *);

typedef void (^VoidBlock_id)(id);
typedef BOOL (^BoolBlock_id)(id);
typedef int  (^IntBlock_id) (id);
typedef id   (^IDBlock_id)  (id);

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define MM_WS(ws) __weak typeof(self)weakSelf = ws;
#define MM_SS(ss) __weak typeof(self)strongSelf = ss;




//自适应高度
#define STRING_SIZE_FONT(_width_, _string_, _fsize_) [_string_ boundingRectWithSize:CGSizeMake(_width_, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:_fsize_]} context:nil].size;


#define STRING_WIDTH_FONT(_height, _string_, _fsize_) [_string_ boundingRectWithSize:CGSizeMake(MAXFLOAT,_height ) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:_fsize_]} context:nil].size;

// 判断是否是iPhone X
#define isX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneXS_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)


// 状态栏高度
#define STATUS_BAR_HEIGHT (isX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (isX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (isX ? (49.f+34.f) : 49.f)
// home indicator
#define SafeAreaBottomHeight (isX ? 34.f : 0.f)
#define ScrollTabbar  45.f


#define BottomViewHeight  45 //( 0.065 * kScreenHeight) 
#define RightViewWidth  ( kScreenWidth - 60)

// tableView cell layout
#define CELL_PADDING_10 10
#define CELL_PADDING_8 8
#define CELL_PADDING_6 6
#define CELL_PADDING_4 4
#define CELL_PADDING_2 2
#define RETURN_OK 1
//圆角
#define CornerRadius 5
 

#define MRC_ALERT_TITLE @"提示"
#define MBPROGRESSHUD_LABEL_TEXT @"加载中..."
///------------
/// Color
///------------

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//#define JCLRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a] // 获取RGB颜色值
#define JCLBGRGB JCLRGBA(244, 244, 244, 1)


///----------------------
/// Persistence Directory
///----------------------

#define MM_DOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
// App DocumentDirectory 文件夹路径
#define MMDocumentDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject]



////------------
/// UMengSocial
///
#define UMENG_APPKEY @"5c3e89dff1f5565a39000de5"
#define WXKEY @"wxcc73e652d89f71b5"
#define WXSecret @"03092a9f829b33cb3417b81394b48efa"

#define QQKEY @"100480340"
#define QQSecret @"1f01256159d5392be23ef5fd521390b1"
///------------
/// MEIQIA
///
#define MeiQia_APPKEY @"e9bd11a5856e6a2c9bb3e19514b4d3d0"
#define MeiQia_SecretKEY @"$2a$12$X2RmOBJIsnUWkFOhOH/ICOjnBmvOy1A5ZvPwZn.bIp8OgvdP4occG"


///---------
/// App Info
///---------

#define MMApplicationVersionKey @"MMApplicationVersionKey"

#define MM_APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define MM_APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define MM_APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

///-----
/// FMDB
///-----

//#define MM_FMDB_PATH [NSString stringWithFormat:@"%@/%@.db", MM_DOCUMENT_DIRECTORY, MM_APP_NAME]
//#define MMLogLastError(db) NSLog(@"lastError: %@, lastErrorCode: %d, lastErrorMessage: %@", [db lastError], [db lastErrorCode], [db lastErrorMessage]);

///--------
/// Bugtags
///--------

#define TSJR_BUGTAGS_APP_ID @"7804730fab"
#define MM_BUGTAGS_APP_SECRET @"f5b908e83e51b9f4cb8e3c89976f68ce"


//登录
#define JCLLOGIN JCLUserLoginList *list = [[JCLUserLoginList alloc] init];\
[self.navigationController pushViewController:list animated:YES];
//登录
#define JCLLOGINPRESENT JCLUserLoginList *list = [[JCLUserLoginList alloc] init];\
[self presentViewController:list animated:YES completion:nil];

//#define SeverDate @"webDate" // 存放服务器时间
//
////字符串是否为空
#define JCLIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 || [str isEqualToString:@"<null>"] ? YES : NO )

#define JCLInfoIdx @"infoIdx"
#define isTrade @"trade"



#pragma mark ---- NSUserDefaults
#define CachesFile(value) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:value]
#define TmpFile(value) [NSTemporaryDirectory() stringByAppendingPathComponent:value]

#define FileRead(key) [NSMutableArray arrayWithContentsOfFile:key];
#define FileWrite(value, key) [key writeToFile:value atomically:YES];

#define JCLUserInfo @"UserInfo" // 存放用户信息
#define JCLTradeInfo @"TradeInfo" // 存放用户信息
#define Online @"Online"

#define PreRead(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define PreWrite(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]

#pragma mark ---- UIDevice
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iPhone XR
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iPhone XS
#define iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否是iPhone X Max
#define iPhoneXMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define New_Device ((iPhoneX==YES || iPhoneXR ==YES || iPhoneXS== YES || iPhoneXMax== YES) ? YES : NO)
#pragma mark ---- UIScreen
#define JCLBOUNDS [UIScreen mainScreen].bounds
#define JCLSIZE [UIScreen mainScreen].bounds.size
#define JCLWIDTH [UIScreen mainScreen].bounds.size.width
#define JCLHEIGHT [UIScreen mainScreen].bounds.size.height
#define JCLSTATUS (New_Device ? 44 : 20)
#define JCLNAVI (New_Device ? 88 : 64)
#define JCLSCROLL JCLHEIGHT - JCLNAVI
#define JCLTABHEIGHT (New_Device ? 83 : 49)

#define JCLRiseRGB JCLRGB(235, 0, 52)
#define JCLFallRGB JCLRGB(60, 211, 137)


//使用以下颜色背景
#define MAIN_COLOR UIColorHex(528ef2)

#define ViewBG UIColorHex(f5f7fa)
///字体1号色
#define TitleAColor UIColorHex(333333)
///字体2号色
#define TitleBColor UIColorHex(848fa1)
///字体3号色
#define TitleCColor UIColorHex(c0c6cf)
///字体4号色
#define TitleDColor UIColorHex(bad2fa)
///分隔线色号01
#define SeparatorLineAColor UIColorHex(f0f2f5)
///分隔线色号02
#define SeparatorLineBColor UIColorHex(dfe2e8)
 
#define LineAColor UIColorHex(EEEEEE)
#define JCLAccountRGB JCLRGB(129, 129, 156)



/////////定义 数字 常量 颜色  ，红涨， 绿跌 ，灰平//////////
#define RoseColor UIColorHex(FF0000)
#define FallColor UIColorHex(90EE90)
#define GreyColor UIColorHex(D3D3D3)



#define iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define iPad ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define iOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)


#define TextColor JCLRGB(143, 143, 150)
#define QUANT [JCLSocket sharedJCLSocket]
#define USER ([UserManager shareUser])
#endif
 
