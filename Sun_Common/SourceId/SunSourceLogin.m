//
//  SunSourceLogin.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "SunSourceLogin.h"


@interface SunSourceLogin(hidden)

+(void)setSourceId:(NSString*)sourceId subSourceId:(NSString*)subSourceId;

@end

@implementation SunSourceLogin

+(NSString *)getSourceId
{
	NSString* sourceid = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_SOURCE];
	if (sourceid && [sourceid length] > 0) 
	{
		return sourceid;
	}
	[self reSetSourceId];
	return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_SOURCE];
}

+(NSString *)getSubSourceId
{
	NSString* subsourceid = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_SUBSOURCE];
	if (subsourceid && [subsourceid length] > 0) {
		return subsourceid;
	}
	[self reSetSourceId];
	
	subsourceid = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_SUBSOURCE];
	return subsourceid;
}

+(BOOL)isTestSourceId
{
	NSString* sourceid = [self getSourceId];
	return [sourceid isEqualToString:YK_TEST_SOURCEID];
}

+(void)reSetSourceId
{
	[self setSourceId:VALUE_SOURCE subSourceId:VALUE_SUBSOURCE];
}

+(void)setSourceId:(NSString*)sourceId subSourceId:(NSString*)subSourceId
{
	NSString* source_id = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_SOURCE];
	NSString* subsource_id = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_SUBSOURCE];
	if (source_id && [source_id length] && subsource_id && [subsource_id length])
	{
		return;
	}
	[[NSUserDefaults standardUserDefaults] setValue:sourceId forKey:KEY_SOURCE];
	[[NSUserDefaults standardUserDefaults] setValue:subSourceId forKey:KEY_SUBSOURCE];
	[[NSUserDefaults standardUserDefaults] synchronize];
}


@end
