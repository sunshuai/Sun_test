//
//  LaunchAction.m
//  Sun_test
//
//  Created by sun on 12-12-20.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "LaunchAction.h"

const NSString *TAG_LAUNCH_VERSION = @"TAG_LAUNCH_VERSION";
const NSString *TAG_LAUNCH_LOADING = @"TAG_LAUNCH_LOADING";
const NSString *TAG_LAUNCH_SERVERTIME = @"TAG_LAUNCH_SERVERTIME";

@implementation LaunchAction


- (void)requestVersion{
    
    [self requestURL:(NSString *)YK_URL_CHECK_VERSION params:nil requestTag:[NSString stringWithFormat:@"%@",TAG_LAUNCH_VERSION]];
}
- (void)requestLoadingImage{
    
    [self requestURL:(NSString *)YK_URL_LOADING_IMG params:nil requestTag:[NSString stringWithFormat:@"%@",TAG_LAUNCH_LOADING]];
}

- (void)requestServerTime{
    
    [self requestURL:(NSString *)YK_URL_SERVER_TIME params:nil requestTag:[NSString stringWithFormat:@"%@",TAG_LAUNCH_SERVERTIME]];
}

@end
