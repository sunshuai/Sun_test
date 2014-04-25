//
//  ServerTimeUtility.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-7.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "SunBaseData.h"
#import "LaunchAction.h"


@interface ServerTimeUtility : SunBaseData <SunActionDelegate>
{
        
}



/**
 *	@brief	请求服务器时间
 *
 *	需要在程序启动返回前台时执行
 */
+(void)requestServerTime;

/**
 *	@brief	获取当前服务器时间
 *
 *	根据服务器和本地时间差计算服务器时间
 *
 *	@return	服务器时间
 */
+(NSDate *)currentDate;

-(void)retry;
@end
