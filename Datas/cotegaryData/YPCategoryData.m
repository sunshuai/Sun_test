//
//  YPCategory.m
//  YouPin
//
//  Created by chenjie on 12-8-9.
//  Copyright (c) 2012年 yek.com. All rights reserved.
//

#import "YPCategoryData.h"

@implementation YPCategoryData
-(NSArray*)firstCategoryList
{
    NSMutableArray * result = [[[NSMutableArray alloc] init]autorelease];
    
    NSArray * items = [[m_Dictionary objectForKey:@"result"] objectForKey:@"firstCategoryList"];
    
    for (NSDictionary * dic in items) {
        YPFirstCategoryData * item = [[YPFirstCategoryData alloc]initWithJsonObject:dic];
        [result addObject:item];
        [item release];
    }
    return result;
}
@end

@implementation YPFirstCategoryData
-(NSArray*)secondCategoryList
{
    NSMutableArray * result = [[[NSMutableArray alloc] init]autorelease];
    
    NSArray * items = [m_Dictionary  objectForKey:@"secondCategoryList"];
    
    for (NSDictionary * dic in items) {
        YPSecondCategoryData * item = [[YPSecondCategoryData alloc]initWithJsonObject:dic];
        [result addObject:item];
        [item release];
    }
    return result;
}


@end
@implementation YPSecondCategoryData
-(NSArray*)thirdCategoryList
{
    NSMutableArray * result = [[[NSMutableArray alloc] init]autorelease];
    
    NSArray * items = [m_Dictionary  objectForKey:@"thirdCategoryList"];
    
    for (NSDictionary * dic in items) {
        YPThirdCategoryData * item = [[YPThirdCategoryData alloc]initWithJsonObject:dic];
        [result addObject:item];
        [item release];
    }
    return result;
}

@end
@implementation YPCategoryInfoData

-(NSString*)itemId
{
    return [m_Dictionary objectForKey:@"itemId"];
}
-(NSString*)name
{
    return [m_Dictionary objectForKey:@"name"];
}
-(NSString*)imgUrl
{
    return [m_Dictionary objectForKey:@"imgUrl"];
}
@end
@implementation YPThirdCategoryData


@end