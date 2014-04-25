//
//  YKHttpRequest.m
//  testHTTP
//
//  Created by inzaghi on 10-11-17.
//  Copyright 2010 yek. All rights reserved.
//

#import "YKHttpRequest.h"


@implementation YKHttpRequest
@synthesize requestDelegate;
-(void) dealloc{
	[requestDelegate release];
	[super dealloc];
}

+(ASIFormDataRequest*) buildRequest:(NSURL *)url params:(NSDictionary *)params  extraHeaders:(NSDictionary*) extraHeaderDic{
	NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
	ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:url];
	NSArray* keys=[params allKeys];
	for(id key in keys){
		id val=[params objectForKey:key];
		[request setPostValue:val forKey:key];
	}
	if(extraHeaderDic!=nil){
		NSArray* keys2=[extraHeaderDic allKeys];
		for(id key in keys2){
			id val=[extraHeaderDic objectForKey:key];
			[request addRequestHeader:key value:val];
		}
	}
	[pool release];
	return [request autorelease];
}
+(NSDictionary *) loadUrlresponseDic:(NSURL *)url params:(NSDictionary *)params  extraHeaders:(NSDictionary*) extraHeaderDic{
	//NSLog(@"%@ +(NSString *) loadUrl:(NSURL *)url=%@ params:(NSDictionary *)params=%@ enter... ",[YKHttpRequest class],url,params);
	NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
	NSDictionary* dic=nil;
	ASIFormDataRequest *request = [YKHttpRequest buildRequest:url params:params extraHeaders:extraHeaderDic];
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		NSDictionary *response = [request responseHeaders];
		dic=[response copy];
	}else{
		NSLog(@"%@::loadUrl:%@ params:%@ error:%@",[YKHttpRequest class],url, params, error);
		dic=nil;
	}
	[pool release];
	return [dic autorelease];
}
+(NSString *) loadUrl:(NSURL *)url params:(NSDictionary *)params  extraHeaders:(NSDictionary*) extraHeaderDic{
	//NSLog(@"%@ +(NSString *) loadUrl:(NSURL *)url=%@ params:(NSDictionary *)params=%@ enter... ",[YKHttpRequest class],url,params);
	NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
	NSString* ret=nil;
	ASIFormDataRequest *request = [YKHttpRequest buildRequest:url params:params extraHeaders:extraHeaderDic];
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
		ret=[response copy];
	}else{
		NSLog(@"%@::loadUrl:%@ params:%@ error:%@",[YKHttpRequest class],url, params, error);
		ret=nil;
	}
	[pool release];
	return [ret autorelease];
}


+(NSString *) loadUrl:(NSURL *)url params:(NSDictionary *)params{
	return [YKHttpRequest loadUrl:url params:params extraHeaders:nil];
}
+(NSString *) loadUrlString:(NSString *)urlString params:(NSDictionary *)params   extraHeaders:(NSDictionary*) extraHeaderDic{
	return [YKHttpRequest loadUrl:[NSURL URLWithString:urlString] params:params extraHeaders:extraHeaderDic];
}
+(NSString *) loadUrlString:(NSString *)urlString params:(NSDictionary *)params{
	return [YKHttpRequest loadUrlString:urlString params:params extraHeaders:nil];
}
+(void) startLoadUrl:(NSURL *)url delegate:(id <YKHttpRequestDelegate>)delegate params:(NSDictionary *)params extraHeaders:(NSDictionary*) extraHeaderDic{
	NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];

#ifndef NDEBUG
    NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    NSLog(@"(NSDictionary *)extraHeaderDic=%@",extraHeaderDic);
    NSLog(@"(NSDictionary *)paramsDic=%@",params);
    NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
#endif

	YKHttpRequest* asidelegate=[[YKHttpRequest alloc] init];
	ASIFormDataRequest *request = [YKHttpRequest buildRequest:url params:params extraHeaders:extraHeaderDic];
    // 请求秒数
	request.timeOutSeconds=30;
//    [request setPersistentConnectionTimeoutSeconds:30];
	asidelegate.requestDelegate=delegate;
	[request setNumberOfTimesToRetryOnTimeout:1];
    [request setAllowCompressedResponse:YES];    // 支持gzip的格式
	[request setDelegate:asidelegate];
	[request startAsynchronous];
	[pool release];
}

+(void) startLoadUrl:(NSURL *)url delegate:(id <YKHttpRequestDelegate>)delegate params:(NSDictionary *)params{
	[YKHttpRequest startLoadUrl:url delegate:delegate params:params extraHeaders:nil];
}

+(void) startLoadUrlString:(NSString *)urlString delegate:(id <YKHttpRequestDelegate>)delegate params:(NSDictionary *)params extraHeaders:(NSDictionary*) extraHeaderDic{
	[YKHttpRequest startLoadUrl:[NSURL URLWithString:urlString] delegate:delegate params:params extraHeaders:extraHeaderDic];
}
+(void) startLoadUrlString:(NSString *)urlString delegate:(id <YKHttpRequestDelegate>)delegate params:(NSDictionary *)params{
	[YKHttpRequest startLoadUrlString:urlString delegate:delegate params:params extraHeaders:nil];
}

-(void) requestFinished:(ASIHTTPRequest *)request{
	if(requestDelegate!=nil){
        if ([requestDelegate respondsToSelector:@selector(sendASIHTTPRequestOBJ:)]) {
            [requestDelegate sendASIHTTPRequestOBJ:request];
        }
		if([requestDelegate respondsToSelector:@selector(onLoadFinished:)]){
			[requestDelegate onLoadFinished:[request responseString]];
		}
	}
	[self release];
}
-(void) requestFailed:(ASIHTTPRequest *)request{
	if(requestDelegate!=nil){
		if([requestDelegate respondsToSelector:@selector(onLoadFailed:)]){
			[requestDelegate onLoadFailed:[request error]];
		}
	}
	[self release];
}


@end
