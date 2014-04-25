//
//  BadgeView.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-6.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeView : UIView
{
	NSMutableArray*	nums;
	UIImage*		bg_img;
	UIImageView*	iv_bg;
	int badgeValue;
}

@property int badgeValue;

-(void)setBadge:(int)_badgeValue;


@end
