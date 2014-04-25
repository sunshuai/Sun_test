//
//  SunBaseAction.h
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SunStringUtility.h"


@class SunResult;
@protocol SunActionDelegate <NSObject>
// 请求成功
- (void)onActionResponse:(id)aResponse requestTag:(NSString *)aRequestTag result:(SunResult *)aResult;
// 请求失败
- (void)onActionFailed:(NSError *)aError requestTag:(NSString *)aRequestTag;
@end

@interface SunBaseAction : NSObject
{
    id<SunActionDelegate> delegate;
}

@property (nonatomic, assign) id<SunActionDelegate> delegate;

-(id)initWithDelegate:(id<SunActionDelegate>)aDelegate;

- (void)requestURL:(NSString *)aURL params:(NSDictionary *)aParamDict requestTag:(NSString *)aRequestTag;

@end


@interface SunResult : NSObject
{
    BOOL isSuccess;
    NSString *resultCode;
    NSString *message;
}


@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, retain) NSString *resultCode;
@property (nonatomic, retain) NSString *message;

@end