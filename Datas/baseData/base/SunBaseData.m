//
//  SunBaseData.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "SunBaseData.h"


@implementation SunBaseData

+ (id)onParseResponse:(id)aResponse{
    
    return [NSError errorWithDomain:@"cn.com.Sun_test" 
                               code:10000 
                           userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@ %@",[[self class] description],@"没有重写onParseResponse方法"] forKey:@"message"]];
}

+ (void)parseObject:(id)object withJsonValue:(id)jsonValue{
    
    for (id key in [jsonValue allKeys]) {
        if ([[jsonValue objectForKey:key] isKindOfClass:[NSString class]]) {
            @try {
                [object setValue:[jsonValue objectForKey:key] forKey:[SunStringUtility stripWhiteSpaceAndNewLineCharacter:[NSString stringWithFormat:@"m%@",key]]];
            }
            @catch (NSException *exception) {
                NSLog(@"[ERR]%@\n%@",key,exception);
            }
        }
        else if([[jsonValue objectForKey:key] isKindOfClass:[NSDecimalNumber class]] || [[jsonValue objectForKey:key] isKindOfClass:[NSNumber class]]){
            
            @try {
                [object setValue:[[jsonValue objectForKey:key] stringValue] forKey:[SunStringUtility stripWhiteSpaceAndNewLineCharacter:[NSString stringWithFormat:@"m%@",key]]];
            }
            @catch (NSException *exception) {
                NSLog(@"[ERR]%@\n%@",key,exception);
            }
        }
        else if([[jsonValue objectForKey:key] isKindOfClass:[NSNull class]]){
            @try {
                [object setValue:@"" forKey:[SunStringUtility stripWhiteSpaceAndNewLineCharacter:[NSString stringWithFormat:@"m%@",key]]];
            }
            @catch (NSException *exception) {
                NSLog(@"[ERR]%@\n%@",key,exception);
            }
        }
    }
}

@end
