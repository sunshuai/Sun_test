//
//  LaunchCount.h
//  Sun_test
//
//  Created by sun on 12-10-16.
//  只要在 application didFinishLaunchingWithOptions 调用addLaunchCount就可以了
//  想知道启动次数调用getLaunchCount方法就可以了
//  次数保存在library → Preferences → com.apple.PeoplePicker.plist

#import <Foundation/Foundation.h>

@interface LaunchCount : NSObject



- (BOOL)shouldShowAlertView;
- (void)stopShowAlertViewAnyMore;
- (void)addLaunchCount;
- (NSInteger)getLaunchCount;
+ (LaunchCount*)sharedLaunchCount;

@end
