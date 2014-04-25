//
//  DataWorld.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#define KDATAWORLD [DataWorld shareData]

#import "SunHttpEngine.h"
#import <Foundation/Foundation.h>


@interface DataWorld : NSObject
{
    SunHttpEngine *m_glamourHttpEngine;  // 请求数据的引擎
    NSString      *deviceToken;          // 用于push的deviceToken
    
}

@property (nonatomic, retain) NSString *deviceToken;


//初始化对象
+ (DataWorld *)shareData;

//封装头信息，根据头信息创建请求引擎
- (SunHttpEngine *)httpEngineGlamour;


+(void)saveCookie;
+(void)recoverCookie;
+(void)clearCookie;

+(BOOL)isReceivePush;
+(void)setReceivePush:(BOOL)aRecievePush;

@end
