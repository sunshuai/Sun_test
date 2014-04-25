//
//  Sun_UserData.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SunBaseData.h"

@interface Sun_UserData : SunBaseData
{
    NSString *memail;
    NSString *muserId;
    NSString *muserToken;
    NSString *muserName;
}


@property (nonatomic, retain) NSString *memail;
@property (nonatomic, retain) NSString *muserId;
@property (nonatomic, retain) NSString *muserToken;
@property (nonatomic, retain) NSString *muserName;


/**
 *	@brief	获取当前的用户信息
 *	
 *	从本地数据库中读取GSUserData数据,并返回
 *
 *	@return	如果已登录则返回GSUserData实例,否则返回nil
 */
+ (Sun_UserData *)currentUserData;

/**
 *	@brief	使用指定的GSUserData进行登录
 *	
 *	对aUserData进行数据校验,无误后保存在本地
 *
 *	@param 	aUserData 	用户信息
 *
 *	@return	是否成功登录
 */
+ (NSError *)loginWithUserData:(Sun_UserData *)aUserData;

/**
 *	@brief	退出登录
 *	
 *	清空本地数据库和内存中的g_currentUserData实例
 *
 *	@return	是否成功登出
 */
+ (NSError *)logout;



@end
