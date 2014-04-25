//
//  DataWorld.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "DataWorld.h"

#import "SunSourceLogin.h"
#import "CookieData.h"

#import "Sun_TestAppDelegate.h"
#import "UIDevice+IdentifierAddition.h"


static DataWorld *s_dataWorld;

@implementation DataWorld

@synthesize deviceToken;


+(DataWorld *)shareData
{
    @synchronized(self){
        if (s_dataWorld == nil) {
            s_dataWorld = [[DataWorld alloc] init];
        }
    }
    return s_dataWorld;
}

-(id)init
{
    self = [super init];
    if ( self ) {
        
    }
    return self;
}

-(SunHttpEngine *)httpEngineGlamour
{
    @synchronized(self){
        if (m_glamourHttpEngine == nil ) {
            /*
             参数名称			类型	    是否可为空	    说明
             头信息：
             */
            NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[DataInterface commonParam:YK_KEY_SCREENSIZE], YK_KEY_SCREENSIZE,
            YK_VALUE_PLATFORM,YK_KEY_PLATFORM,
            [[[UIDevice currentDevice] macaddress] stringByReplacingOccurrencesOfString:@":" withString:@""],YK_KEY_UDID,
            YK_VALUE_CLIENT_VER,YK_KEY_CLIENT_VER,
            YK_VALUE_PROTOCOL_VER,YK_KEY_PROTOCOL_VER,
            [SunSourceLogin getSourceId],KEY_SOURCE,
            [SunSourceLogin getSubSourceId],KEY_SUBSOURCE,
            [SunStringUtility  strOrEmpty:[[UIDevice currentDevice] model]],YK_KEY_MODEL,
            [SunStringUtility strOrEmpty:[DataInterface getCarrierName]] ,YK_KEY_CARRIER,
            nil];
            m_glamourHttpEngine = [[SunHttpEngine engineWithHeaderParams:headerParams] retain];
            [m_glamourHttpEngine setM_timeInterval_timeout:30.0f];

        }
    }
    return m_glamourHttpEngine;
}

-(void)dealloc
{
    [deviceToken release];
    [m_glamourHttpEngine release];
    [super dealloc];
}

#pragma mark cookie相关
/**
 *	@brief	保存cookie信息
 *	
 *	登陆成功后保存
 */

+(void)saveCookie
{
    for (CookieData *_d in [CookieData allObjects]) {
        [_d deleteObject];
    }
    NSHTTPCookieStorage *sharedHTTPCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_cookies=[sharedHTTPCookie cookies];
    for (int i=0; i<[_cookies count]; i++) {
        NSHTTPCookie *_cookie=[_cookies objectAtIndex:i];
        CookieData *_cookieData=[[CookieData alloc] init];
        _cookieData.mname=[_cookie name];
        _cookieData.mvalue=[_cookie value];
        _cookieData.mpath=[_cookie path];
        _cookieData.mdomain=[_cookie domain];
        [_cookieData save];
        [_cookieData release];
    }
}

/**
 *	@brief	恢复cookie信息
 *	
 *	请求weblogid时恢复
 */
+(void)recoverCookie{
    
    
    NSHTTPCookieStorage *sharedHTTPCookie=[NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_cookiesDB=[CookieData allObjects];
    for (int i=0; i<[_cookiesDB count]; i++) {
        CookieData *_cookieData=[_cookiesDB objectAtIndex:i];
        //Create a cookie
        NSDictionary *properties = [[[NSMutableDictionary alloc] init] autorelease];
        [properties setValue:_cookieData.mvalue forKey:NSHTTPCookieValue];
        [properties setValue:_cookieData.mname forKey:NSHTTPCookieName];
        [properties setValue:_cookieData.mdomain forKey:NSHTTPCookieDomain];
        [properties setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
        [properties setValue:_cookieData.mpath forKey:NSHTTPCookiePath];
        NSHTTPCookie *cookie = [[[NSHTTPCookie alloc] initWithProperties:properties] autorelease];
        [sharedHTTPCookie setCookie:cookie];
    }
}


+(void)clearCookie{
    for (CookieData *_d in [CookieData allObjects]){
        [_d deleteObject];
    }
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

+(BOOL)isReceivePush{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults objectForKey:IS_RECEIVE_PUSH];
    if ([defaults objectForKey:IS_RECEIVE_PUSH] == nil ||[[defaults objectForKey:IS_RECEIVE_PUSH] isEqualToString:@"1"]) {
        
        return YES;
    }
    else{
        return NO;
    }
}

+(void)setReceivePush:(BOOL)aRecievePush{    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    if (aRecievePush) {
        [defaults setObject:@"1" forKey:IS_RECEIVE_PUSH];
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)]; 
    }
    else{
        [defaults setObject:@"0" forKey:IS_RECEIVE_PUSH];
        [[UIApplication sharedApplication] unregisterForRemoteNotifications]; 
    }
}

@end
