//
//  NSDictionary+GetData.m
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "NSDictionary+GetData.h"

@implementation NSDictionary (GetData)

-(NSString *)getString:(NSString *)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    else {
        return nil;
    }
}


-(NSArray *)getArray:(NSString *)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSArray class]]) {
        return obj;
    }else {
        return nil;
    }
}

-(NSDictionary *)getDictionary:(NSString *)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }else {
        return nil;
    }
}

@end
