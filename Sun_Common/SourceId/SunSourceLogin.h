//
//  SunSourceLogin.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SunJudgeAppTimeOut.h"

#define KEY_SOURCE						@"sourceid"					// 客户端来源标识
#define	KEY_SUBSOURCE					@"subsourceid"				// 客户端来源子标识

/**
 程序超时时间
 */

#define	APP_TEST_TIMEOUT		@"2012-12-20 23:59:59"
#define	APP_TEST_VERSION		@"v0.1.010"


//====================================================================
//MARK: - sourceID相关

#if (defined(TEST_FOR_CUSTOMER) || defined(TEST_URL))
//#ifndef RELEASE_FOR_APPSTORE

#define VALUE_SOURCE                         TEST_SOURCEID

#else

//TODO:: 打包时修改
#define VALUE_SOURCE                         @"yek_iphone_test"

#endif

#define VALUE_SUBSOURCE                      VALUE_SOURCE

//MARK: sourceID相关
@interface SunSourceLogin : NSObject

+(NSString *)getSourceId;
+(NSString *)getSubSourceId;
+(BOOL)isTestSourceId;
+(void)reSetSourceId;

@end
