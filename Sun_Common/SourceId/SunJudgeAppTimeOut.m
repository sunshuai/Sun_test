//
//  SunJudgeAppTimeOut.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "SunJudgeAppTimeOut.h"


@interface SunJudgeAppTimeOut(hidden)

+(BOOL)checkDevice:(NSString*)name;
+(NSTimeInterval)getNowTime;
+(NSDate*)getDateFromStr:(NSString*)timestr formate:(NSString*)formatestr;
+(NSTimeInterval)getTimeIntervalFromStr:(NSString*)timestr formate:(NSString*)formates;
+(BOOL)isTestSourceID:(NSString*)sourceId;

@end


@implementation SunJudgeAppTimeOut

/**
 判断设备类型
 @param name 设备描述字符串
 @returns 是否是此类设备
 */
+(BOOL)checkDevice:(NSString*)name
{
    NSString* deviceType = [UIDevice currentDevice].model;  
    NSLog(@"deviceType = %@", deviceType);  
	
    NSRange range = [deviceType rangeOfString:name];  
    return range.location != NSNotFound;  
}

+(NSTimeInterval)getNowTime
{
    NSTimeInterval servertime = [[NSDate date] timeIntervalSince1970];
    return servertime;
}

+(NSDate*)getDateFromStr:(NSString*)timestr formate:(NSString*)formatestr
{
	if (timestr == nil) {
		return nil;
	}
	if (formatestr == nil) 
	{
		formatestr = @"yyyy-MM-dd HH:mm:ss";
	}
	
	NSDateFormatter* dateFormat=[[NSDateFormatter alloc] init];
	
	[dateFormat setDateFormat:formatestr];
	
	NSDate* date = [dateFormat dateFromString:timestr];
	[dateFormat release];
	
	return date;
}

+(NSTimeInterval)getTimeIntervalFromStr:(NSString*)timestr formate:(NSString*)formatestr
{
	NSDate* time = [[self class] getDateFromStr:timestr formate:formatestr];
	if (time)
	{
		return [time timeIntervalSince1970];
	}
	return 0;
}

+(BOOL)isTestSourceID:(NSString*)sourceId
{
	return [sourceId isEqualToString:YK_TEST_SOURCEID];
}

+(BOOL)JudgeTimeout:(NSString*)timeLimit sourceId:(NSString*)sourceId
{
	if (![[self class] checkDevice:@"Simulator"])
	{
		//判断是在真机上运行
		NSTimeInterval nowtime = [[self class] getNowTime];
		NSTimeInterval timeout = [[self class] getTimeIntervalFromStr:timeLimit formate:nil];
		if (nowtime >= timeout && [[self class] isTestSourceID:sourceId])
		{
			return YES;
		}
		return NO;
	}
	return NO;
}


@end
