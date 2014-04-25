//
//  Sun_UserData.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "Sun_UserData.h"

#import "DataWorld.h"

static Sun_UserData *g_currentUserData;

const NSString *NOTIFICATION_USER_LOGOUT = @"NOTIFICATION_USER_LOGOUT";


@implementation Sun_UserData

@synthesize memail;
@synthesize muserId;
@synthesize muserToken;
@synthesize muserName;

- (void)dealloc
{
    [memail release];
    [muserId release];
    [muserToken release];
    [muserName release];
    [super dealloc];
}

+(SunBaseData *)currentUserData
{
    if (g_currentUserData == nil) {
        g_currentUserData = [[[Sun_UserData allObjects] lastObject] retain];
    }
    return g_currentUserData;
}

+ (NSError *)loginWithUserData:(Sun_UserData *)aUserData
{
    // 检查userId和userToken, 保存在数据库中
    for (Sun_UserData *item in [Sun_UserData allObjects] ) {
        [item deleteObject];
    }
    [g_currentUserData release];
    g_currentUserData = [aUserData retain];
    [g_currentUserData save];
    
    [DataWorld saveCookie];
    NSError *error = nil;
    
    return error;
}

+ (NSError *) logout
{
    for (Sun_UserData *_item in [Sun_UserData allObjects] ) {
        [_item deleteObject];
    }
    [g_currentUserData release];g_currentUserData = nil;
    [DataWorld clearCookie];
    [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)NOTIFICATION_USER_LOGOUT object:nil];
    
    NSError *error = nil;
    
    return error;
}


+ (id)onParseResponse:(id)aResponse
{
    id userInfoJson = [[aResponse JSONValue] objectForKey:@"userInfo"];
    if (userInfoJson == nil) {
        return nil;
    }
    Sun_UserData *ret_userData = [[Sun_UserData alloc] init];
    [[self class] parseObject:ret_userData withJsonValue:userInfoJson];
    return [ret_userData autorelease];
}




















@end
