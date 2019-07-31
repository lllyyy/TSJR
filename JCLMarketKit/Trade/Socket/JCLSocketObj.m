//
//  JCLSocketObj.m
//  JCLMarketKit
//
//  Created by 邢昭俊 on 2017/7/19.
//  Copyright © 2017年 邢昭俊. All rights reserved.
//

#import "JCLSocketObj.h"
#import "GCDAsyncSocket.h"
#import "JCLTradeDefine.h"
#import "zlib.h"
static NSString *IP = @"106.14.166.229";
static const uint16_t Port = 19999;
@interface JCLSocketObj()<GCDAsyncSocketDelegate>
@property (strong, nonatomic) GCDAsyncSocket *socket;
@property (nonatomic, assign) NSInteger idx;
@end
@implementation JCLSocketObj
+(instancetype)share{
    static JCLSocketObj *client;
    static dispatch_once_t _onceToken;
    dispatch_once(&_onceToken, ^{
        client = [[self alloc]init];
    });
    return client;
}

-(GCDAsyncSocket *)socket{
    if (!_socket) {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _socket;
}

#pragma mark - 对外的一些接口
- (BOOL)connect{ return  [self.socket connectToHost:IP onPort:Port error:nil]; }
- (void)disConnect{ [self.socket disconnect]; }

//连接成功调用
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithCapacity:3];
    [settings setObject:@YES forKey:GCDAsyncSocketManuallyEvaluateTrust]; //允许自签名证书手动验证
    [sock startTLS:settings]; // 配置 SSL/TLS 设置信息开始SSL握手
}

-(void)socket:(GCDAsyncSocket *)sock didReceiveTrust:(SecTrustRef)trust completionHandler:(void (^)(BOOL))completionHandler{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rootca" ofType:@"cer"]];
    OSStatus status = -1;
    SecTrustResultType result = kSecTrustResultDeny;
    if(data) {
        SecCertificateRef cert = SecCertificateCreateWithData(NULL, (__bridge_retained CFDataRef) data);
        SecTrustSetAnchorCertificates(trust, (__bridge CFArrayRef)[NSArray arrayWithObject:(__bridge id)cert]);
        status = SecTrustEvaluate(trust, &result); // 验证服务器证书和本地证书是否匹配
    }
    if ((status == noErr && (result == kSecTrustResultProceed || result == kSecTrustResultUnspecified))) {
        completionHandler(YES); // 成功通过验证，证书可信
    } else {
        completionHandler(NO);
    }
    completionHandler(YES);
}
- (void)socketDidSecure:(GCDAsyncSocket *)sock{
    [sock readDataWithTimeout:1000 tag:self.idx];
}
//断开连接的时候调用
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err{
    [self.socket connectToHost:IP onPort:Port error:nil];
}

// 发送请求
-(void)JCLSocketRequst:(NSDictionary *)dic idx:(NSInteger)idx{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
    NSInteger    dataLen = jsonData.length;
    NSString *jsonStr=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    const char *szTmp1 = [jsonStr cStringUsingEncoding:NSUTF8StringEncoding];

    self.idx = idx;
    [self sendDataWithDataLen:dataLen sendData:szTmp1];
}
-(void)sendDataWithDataLen:(int)dataLen sendData:(void*)pSendData{
    int sendBuflen = sizeof(JCLSocketHeader) + dataLen;
    void  *pSendBuf = alloca(sendBuflen);
    memset(pSendBuf, 0x00, sendBuflen);
    JCLSocketHeader * pPackInfo = (JCLSocketHeader*)pSendBuf;
    pPackInfo->cookie =0;
    pPackInfo->version = 7;
    pPackInfo->compressed = 0;
    pPackInfo->encrypt = 0;
    pPackInfo->synID = 0;
    pPackInfo->assisID = 123456;
    pPackInfo->rawLen = dataLen;
    pPackInfo->packLen = dataLen;
    pPackInfo->funcID = self.idx;
    
    //头
    memcpy(pSendBuf+sizeof(JCLSocketHeader), pSendData, dataLen);
    char* str = alloca(sendBuflen - sizeof(pPackInfo->hash64));
    memset(str, 0x00, sendBuflen - sizeof(pPackInfo->hash64));
    memcpy(str, pSendBuf + sizeof(pPackInfo->hash64), sendBuflen - sizeof(pPackInfo->hash64));
    pPackInfo->hash64 = GenHash64((const char*)str, sendBuflen - sizeof(pPackInfo->hash64));
    NSData * data = [NSData dataWithBytes:pSendBuf length:sendBuflen];
    
    [self.socket writeData:data withTimeout:10000 tag:self.idx];
}

unsigned long long GenHash64(const char* str, unsigned int len){
    unsigned long long ret = 0;
    ret = GenHash((unsigned char *)str,len,31);
    ret <<= 32;
    ret += GenHash((unsigned char *)str,len,131);
    return ret;
}

unsigned int GenHash(unsigned char* str, unsigned int len,unsigned int seed){
    unsigned int hash = 0;
    unsigned int i	 = 0;
    for(i = 0; i < len; str++, i++){
        hash = (hash * seed) + (*str);
    }
    return hash;
}

// 接收数据
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{ [self.socket readDataWithTimeout:10000 tag:tag]; }
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    JCLSocketHeader *head = (JCLSocketHeader *)data.bytes;
    void *byte;
    if (head->compressed ==1) {
        byte = alloca(head->rawLen);
        memset(byte, 0x00, head->rawLen);
        uLong uLen = head->rawLen;
        if (Z_OK == uncompress((Bytef *)byte, &uLen, data.bytes+sizeof(JCLSocketHeader), head->packLen)){}
    } else {
        byte = alloca(head->packLen);
        memcpy(byte, head->packdata, head->packLen);
    }
    
    char *vals = (char *)byte;
    vals[head->rawLen]=0;
    if(vals==NULL) return;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[[[NSString alloc]initWithUTF8String:vals] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves  error:nil];
    !self.socketActionBlock ? : self.socketActionBlock(json, head->funcID);
}
@end
