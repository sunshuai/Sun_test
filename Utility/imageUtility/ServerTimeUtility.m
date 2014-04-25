//
//  ServerTimeUtility.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-7.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "ServerTimeUtility.h"

@implementation ServerTimeUtility


static NSDate *requestDate;
static ServerTimeUtility *aDelegate;
static NSTimeInterval timeDiff;
static LaunchAction *launchAction;

+ (void)requestServerTime{
    
    if (requestDate == nil) {
        requestDate = [[NSDate date] retain];
    }
    else{
        [requestDate release];
        requestDate = [[NSDate date] retain];
    }
    if (aDelegate == nil) {
        aDelegate = [[ServerTimeUtility alloc] init];
    }
    if (launchAction == nil) {
        launchAction = [[LaunchAction alloc] initWithDelegate:aDelegate];
    }
    
    [launchAction requestServerTime];
}

+ (NSDate *)currentDate{
    NSDate *nowDate = [NSDate date];
    NSTimeInterval serverTime = [nowDate timeIntervalSince1970] + timeDiff;
    return [NSDate dateWithTimeIntervalSince1970:serverTime];
}

- (void)retry{
    [launchAction requestServerTime];
}

- (void)onActionFailed:(NSError *)aError requestTag:(NSString *)aRequestTag{
    
    [self performSelector:@selector(retry) withObject:nil afterDelay:1];
}

- (void)onActionResponse:(id)aResponse requestTag:(NSString *)aRequestTag result:(SunResult *)aResult{
    
    if (!aResult.isSuccess) {
        NSLog(@"请求服务器时间失败!");
        return;
    }
    NSDate *nowDate = [NSDate date];
    NSTimeInterval delayTime = [nowDate timeIntervalSinceDate:requestDate];
    NSTimeInterval serverTime = [[[aResponse JSONValue] objectForKey:@"serverTime"] doubleValue];
    NSTimeInterval fixedServerTime = serverTime + delayTime/2;
    timeDiff = fixedServerTime - [nowDate timeIntervalSince1970];
    
}

@end
