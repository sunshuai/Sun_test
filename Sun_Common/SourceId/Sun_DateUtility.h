//
//  Sun_DateUtility.h
//  Sun_test
//
//  Created by sun on 12-10-16.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum _YKDatePrecisionWords{
	YKDayCalendarUnit = 0,
	YKNSHourCalendarUnit,
	YKNSMinuteCalendarUnit,
}YKDatePrecisionWords;

@interface Sun_DateUtility : NSObject

+(NSDate*)sysTime;
+(void)setSysTime:(NSDate*)date;

+(BOOL)isOverDue:(NSString*)dateStr withDateFormat:(NSString*)dateFormat;
+(BOOL)isNotBegin:(NSString*)dateStr withDateFormat:(NSString*)dateFormat;
+(NSDate*)NSStringDateToNSDate:(NSString *)string withDateFormat:(NSString*)dateFormat;
+(NSDate *)NSStringDateToNSDateTrimWhiteSpace:(NSString *)string withDateFormat:(NSString*)dateFormat;//功能同上，自动去除string里的所有空格
+(NSString*)NSDateToNSString:(NSDate*)date withDateFormat:(NSString*)dateFormat;
+(NSDateComponents*)NSDateToNSDateComponents:(NSDate*)date;
+(NSDateComponents*)DateTransformation:(int)second withPrecision:(int)precision;
+(NSTimeInterval)systemUptime;

@end
