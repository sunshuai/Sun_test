//
//  NSDictionary+GetData.h
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GetData)

-(NSString *)getString:(NSString *)key;
-(NSString *)getArray:(NSString *)key;
-(NSDictionary *)getDictionary:(NSString *)key;

@end
