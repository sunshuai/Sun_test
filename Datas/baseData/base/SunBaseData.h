//
//  SunBaseData.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SunStringUtility.h"
#import "BaseData.h"

@interface SunBaseData : BaseData 

/**
 *	@brief	解析json数据
 *	
 *	对aResponse进行解析,子类必须重写此方法,否则无法完成解析并返回NSError
 *
 *	@param 	aResponse 	要解析的数据
 *
 *	@return	如果json数据错误,返回nil,如果结果是错误代码,返回NSError,否则返回数据对象
 */
+ (id)onParseResponse:(id)aResponse;

+ (void)parseObject:(id)object withJsonValue:(id)jsonValue;

@end
