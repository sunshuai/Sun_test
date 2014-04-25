//
//  Sun_DataBase.h
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//
// 项目数据基类

#import <Foundation/Foundation.h>
#import "NSDictionary+GetData.h"

@interface Sun_DataBase : NSObject
{
    NSDictionary  * m_Dictionary;
}

@property (nonatomic, readonly) NSDictionary *m_Dictionary;

-(id)initWithJsonObject:(id)jsonData;

@end


@interface Sun_RetDataBase : Sun_DataBase
{
    NSString *message;
    NSString *success;
}

@property (nonatomic, readonly) NSString *message; 
@property (nonatomic, readonly) NSString *success; 

@end