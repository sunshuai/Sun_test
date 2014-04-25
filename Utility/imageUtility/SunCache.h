//
//  SunCache.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-6.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <Foundation/Foundation.h>



/*
 缓存
 */
@protocol SunCache <NSObject>
/*
 缓存对象
 参数列表
 value:
 对象
 key:
 对象标识
 expireDate:
 过期日期
 
 */
-(void) setObject:(id<NSCoding>)object forKey:(id)key expireDate:(NSDate*) expireDate;
/*
 缓存对象永不过期，除非调用[self removeObjectForKey:key];
 */
-(void) setObject:(id<NSCoding>)object forKey:(id)key;
/*
 获取缓存对象
 返回：
 如果有对象则返回对象，没有的话返回nil
 */
-(id) objectForKey:(id)key;
/*
 删除缓存
 */
-(void) removeObjectForKey:(id) key;

@end


/*
 !!!!未测试
 //TODO:TEST
 */
@interface SunMemoryCache : NSObject<SunCache> {
	NSMutableDictionary* dic;
	
}
@end


/*
 缓存object到临时目录的文件中
 主要用于缓存网络数据
 */
@interface SunFileCache : NSObject<SunCache>
{
    NSMutableDictionary* dic;
	NSString* dicFilePath;
	NSTimer* saveTimer;	//定时保存dic到dicFilePath
	BOOL needSave;		//是否需要保存dic到dicFilePath
}

-(id) initWithFileName:(NSString*) fileName;
-(void) save;
+(void) test;

@end


extern NSString* documentFilePath(NSString* fileName);

