//
//  SunBaseAction.m
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "SunBaseAction.h"
#import "ASIHTTPRequest.h"
#import "SunStringUtility.h"
#import "DataWorld.h"// 头信息
#import "NSString+SBJSON.h"
#import "NSDictionary+GetData.h"

#define SUN_REQUEST_TAG  @"RequestTag"

@interface SunBaseAction(PrivateMethod)

- (void)onResponse:(ASIHTTPRequest *)aRequest;
- (void)onFailed:(ASIHTTPRequest *)aRequest;
- (NSMutableDictionary *)getPostParams:(NSDictionary *)aDict;
- (NSString *)getTimeStamp;

@end

@implementation SunBaseAction

@synthesize delegate;


-(id)initWithDelegate:(id<SunActionDelegate>)aDelegate
{
    self = [self init];
    if (self) {
        self.delegate = aDelegate;
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

- (SunResult *)validResponse:(id)aResponse
{
    if (aResponse == nil || [aResponse isKindOfClass:[NSError class]] || ![aResponse isKindOfClass:[NSObject class]]) {
        return aResponse;
    }
    
    id json = [aResponse JSONValue];
    if (nil == json) {
        return nil;
    }
    id result_response = [json objectForKey:@"result"];
    
    if (result_response == nil) {
        NSLog(@"[error] response no success_response ");
        return nil;
    }
    SunResult *result = [[SunResult alloc] init];
    if(![result_response isEqual:@"0"]) {
        result.isSuccess = NO;
    }
    else {
        result.isSuccess = YES;
    }

    result.message = [json objectForKey:@"message"];
    result.resultCode = result_response;

    return [result autorelease];
}

#pragma mark - 回调及执行代理方法
-(void)onResponse:(ASIHTTPRequest *)aRequest
{
    SunResult *result = [self validResponse:[aRequest responseString]];
    if ([delegate respondsToSelector:@selector(onActionResponse:requestTag:result:)]) {
        NSString *r_tag = [aRequest.userInfo getString:SUN_REQUEST_TAG];
        [delegate onActionResponse:[aRequest responseString] requestTag:r_tag result:result];
    }
}

-(void)onFailed:(ASIHTTPRequest *)aRequest
{
    if ([delegate respondsToSelector:@selector(onActionFailed:requestTag:)]) {
        NSString *r_tag = [aRequest.userInfo getString:SUN_REQUEST_TAG];
        [delegate onActionFailed:aRequest.error requestTag:r_tag];
    }
}


#pragma mark - 参数拼装和发送请求
- (NSString *)getTimeStamp
{
    NSDate *date = [[NSDate new] autorelease];
    int timeStamp = (int)[date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%d",timeStamp];
}

-(NSMutableDictionary *)getPostParams:(NSDictionary *)aDict
{
    // 根据接口文档定义的签名规则进行签名
    NSMutableDictionary *temp_dict = [NSMutableDictionary dictionaryWithDictionary:aDict];
    [temp_dict setObject:[self getTimeStamp] forKey:@"timeStamp"];
    NSArray *allkey = [[[temp_dict allKeys] sortedArrayUsingSelector:@selector(compare:)] retain];
    
    NSString *appSecret = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"GSAppSecret"];
    
    NSMutableDictionary *ret_dict = [[NSMutableDictionary alloc] init];
    NSMutableString *signStr = [[NSMutableString alloc] initWithString:appSecret];
    for (id key in allkey) {
        [ret_dict setObject:[temp_dict objectForKey:key] forKey:key];
        [signStr appendFormat:@"%@%@",key,[ret_dict objectForKey:key]];
    }
    [ret_dict setObject:[SunStringUtility strOrEmpty:[SunStringUtility YKMD5:signStr]] forKey:@"sign"];
    [signStr release];
    [allkey release];
    return [ret_dict autorelease];
    
}

- (void)requestURL:(NSString *)aURL params:(NSDictionary *)aParamDict requestTag:(NSString *)aRequestTag
{
#ifdef TEST_DATA
    NSLog(@"[SYS]RequestUrl: %@ PostParam:\n%@",aURL,aParamDict);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonData" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *bejson = [dict objectForKey:aRequestTag];
    SunResult *result = [self validResponse:bejson];
    if ([delegate respondsToSelector:@selector(onActionResponse:requestTag:result:)]) {
        NSString *r_tag = aRequestTag;
        [delegate onActionResponse:bejson requestTag:r_tag result:result];
    }
#else
    NSDictionary *fixedParam = [self getPostParams:aParamDict];
    ASIHTTPRequest *request  = [[KDATAWORLD httpEngineGlamour] buildRequest:[NSString stringWithFormat:@"%@%@",YK_SERVER_PATH,aURL] getParams:fixedParam object:self onFinishedAction:@selector(onResponse:) onFailedAction:@selector(onFailed:)];
    NSMutableDictionary *m_dict = [NSMutableDictionary dictionaryWithDictionary:request.userInfo];
    [m_dict setObject:aRequestTag forKey:SUN_REQUEST_TAG];
    request.userInfo = m_dict;
    [request startAsynchronous];
    
#endif
}







@end
