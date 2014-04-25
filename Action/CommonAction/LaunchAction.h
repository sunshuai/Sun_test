//
//  LaunchAction.h
//  Sun_test
//
//  Created by sun on 12-12-20.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SunBaseAction.h"

extern const NSString *TAG_LAUNCH_VERSION;
extern const NSString *TAG_LAUNCH_LOADING;
extern const NSString *TAG_LAUNCH_SERVERTIME;

@interface LaunchAction : SunBaseAction

- (void)requestVersion;
- (void)requestLoadingImage;
- (void)requestServerTime;

@end
