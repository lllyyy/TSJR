

#ifdef DEBUG //线下
    #define SERVICE_URL  @"http://service.zmmedical.cn/"
    #define SHARE_URL    @"http://tc2.zmmedical.cn/"
#else
    #define SERVICE_URL @"https://service.zuimeimami.com/"
    #define SHARE_URL   @"https://tc.lejiayy.com"
#endif


//static NSString *const InisetJsonUrl = @"test/mami_admin/Iniset/iniset.json";
static NSString *const InisetJsonUrl = @"mami_admin/Iniset/iniset.json";

static NSString *const ONLINEVIDEO_URL = @"http://api.cogonline.com.cn/";
static NSString *const RongClond_URL = @"http://api.cn.ronghub.com/";
static NSString *const ossUrl = @"https://oss.zuimeimami.com/";


#define hostURl @"http://app.angl999.com"
 
#define customerapi @"customerapi"
#define accountapi  @"accountapi"
#define quoteapi    @"quoteapi"
#define tradeapi    @"tradeapi"
#define dataapi     @"dataapi"


#define customerApiapiUrl  [NSString stringWithFormat:@"tsjr/%@", customerapi]
#define accountApiapiUrl   [NSString stringWithFormat:@"tsjr/%@", accountapi]
#define quoteApiapiUrl     [NSString stringWithFormat:@"tsjr/%@", quoteapi]
#define tradeApiapiUrl     [NSString stringWithFormat:@"tsjr/%@", tradeapi]
#define dataapiApiUrl     [NSString stringWithFormat:@"tsjr/%@" , dataapi]

#define baseApiURlA [NSString stringWithFormat:@"%@/%@", hostURl, customerApiapiUrl]
#define baseApiURlB [NSString stringWithFormat:@"%@/%@", hostURl, accountApiapiUrl]
#define baseApiURlC [NSString stringWithFormat:@"%@/%@", hostURl, quoteApiapiUrl]
#define baseApiURlD [NSString stringWithFormat:@"%@/%@", hostURl, tradeApiapiUrl]
#define baseApiURlE [NSString stringWithFormat:@"%@/%@", hostURl, dataapiApiUrl]

////头像/////
#define imageURl @"avatar"
#define avatarURL [NSString stringWithFormat:@"%@/%@", hostURl, imageURl]
///////////////////
 
