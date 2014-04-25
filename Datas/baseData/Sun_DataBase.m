//
//  Sun_DataBase.m
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "Sun_DataBase.h"

@implementation Sun_DataBase

@synthesize m_Dictionary;

-(id)initWithJsonObject:(id)jsonData
{
    if (self = [super init]) {
        m_Dictionary = (NSDictionary *)jsonData;
        [m_Dictionary retain];
    }
    return self;
}

-(void)dealloc
{
    [m_Dictionary release];
    m_Dictionary = nil;
    [super dealloc];
}

-(id)init
{
    if (self == [super init]) {
        m_Dictionary = [[NSDictionary alloc] init];
    }
    return self;
}

@end

@implementation Sun_RetDataBase

-(NSString *)message
{
    return [m_Dictionary getString:@"message"];
}

-(NSString *)success
{
    return [m_Dictionary getString:@"success"];
}

@end