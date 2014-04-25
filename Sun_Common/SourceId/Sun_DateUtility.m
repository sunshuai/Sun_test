//
//  Sun_DateUtility.m
//  Sun_test
//
//  Created by sun on 12-10-16.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "Sun_DateUtility.h"
#import <mach/mach.h>
#import <mach/mach_time.h>


@implementation Sun_DateUtility

static NSDate* s_date;
static NSDate* s_nowDate;
+(void)setSysTime:(NSDate*)date{
	[date retain];
	if (s_date) {
		[s_date release];
	}
	s_date = date;
	
	if (s_nowDate) {
		[s_nowDate release];
	}
	s_nowDate = [NSDate date];
	[s_nowDate retain];
}

+(NSDate*)sysTime{
	NSTimeInterval _second = [[NSDate date] timeIntervalSinceDate:s_nowDate];// 计算时间差
	_second = fabs(_second);
	if (_second>1.0) {
		_second = 1.0;
	}
	NSDate *_date = [s_date dateByAddingTimeInterval:fabs(_second)];
	[[self class] setSysTime:_date];
	return s_date;
}

+(BOOL)isOverDue:(NSString*)dateStr withDateFormat:(NSString*)dateFormat{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	NSDate* _endDate = [Sun_DateUtility NSStringDateToNSDate:dateStr withDateFormat:dateFormat];
	
	NSDate* _nowDate = [NSDate date];
	int _second = [_endDate timeIntervalSinceDate:_nowDate];
    
	if (_second<0) {
		[pool drain];
		return YES;
	}else {
		[pool drain];
		return NO;
	}
}

+(BOOL)isNotBegin:(NSString*)dateStr withDateFormat:(NSString*)dateFormat{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	NSDate* _startDate = [Sun_DateUtility NSStringDateToNSDate:dateStr withDateFormat:dateFormat];
	
	NSDate* _nowDate = [NSDate date];
	int _second = [_startDate timeIntervalSinceDate:_nowDate];
	
	if (_second<0) {
		[pool drain];
		return NO;
	}else {
		[pool drain];
		return YES;
	}
}

+(NSDate *)NSStringDateToNSDate:(NSString *)string withDateFormat:(NSString*)dateFormat{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    //#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd'T'HH:mm:ss'Z'")
    [formatter setDateFormat:dateFormat];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+(NSDate *)NSStringDateToNSDateTrimWhiteSpace:(NSString *)string withDateFormat:(NSString*)dateFormat{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    //#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd'T'HH:mm:ss'Z'")
    [formatter setDateFormat:dateFormat];
	NSString *afterTrimWhiteSpace = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDate *date = [formatter dateFromString:afterTrimWhiteSpace];
    return date;
}

+(NSString*)NSDateToNSString:(NSDate*)date withDateFormat:(NSString*)dateFormat{
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:dateFormat];
	NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+(NSDateComponents*)NSDateToNSDateComponents:(NSDate*)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = nil;
	NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
	NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	comps = [calendar components:unitFlags fromDate:date];
    [calendar release];
    return comps;
}

+(NSDateComponents*)DateTransformation:(int)_second withPrecision:(int)precision{
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	
	switch (precision) {
		case YKNSMinuteCalendarUnit:{
			int tmpTime = _second;
			
			int second = tmpTime%60;
			tmpTime = (tmpTime - second)/60;
			int minute = tmpTime/60;
			
			[comps setSecond:second];
			[comps setMinute:minute];
			break;
		}
		case YKNSHourCalendarUnit:{
			int tmpTime = _second;
			
			int second = tmpTime%60;
			tmpTime = (tmpTime - second)/60;
			int minute = tmpTime%60;
			tmpTime = (tmpTime-minute)/60;
			int hour = tmpTime;
			
			[comps setSecond:second];
			[comps setMinute:minute];
			[comps setHour:hour];
			break;
		}
		case YKDayCalendarUnit:{
			int tmpTime = _second;
			
			int second = tmpTime%60;
			tmpTime = (tmpTime - second)/60;
			int minute = tmpTime%60;
			tmpTime = (tmpTime-minute)/60;
			int hour = tmpTime%24;
			int day = (tmpTime-hour)/24;
			
			[comps setSecond:second];
			[comps setMinute:minute];
			[comps setHour:hour];
			[comps setDay:day];
			break;
		}
		default:
			[comps setSecond:_second];
			break;
	}
	return [comps autorelease];
}

+(NSTimeInterval)systemUptime
{
	// get the timebase info -- different on phone and OSX
    mach_timebase_info_data_t info;
    mach_timebase_info(&info);
	
    // get the time
    uint64_t absTime = mach_absolute_time();
	
    // apply the timebase info
    absTime *= info.numer;
    absTime /= info.denom;
	
    // convert nanoseconds into seconds and return
    return (NSTimeInterval) ((double) absTime / 1000000000.0);
}

@end
