//
//  UIPullToReloadFooterView.h
//  Untitled
//
//  Created by YuHui on 10-12-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#import "UIPullToReload.h"

@interface UIPullToReloadFooterView : UIView {
@private
	UIPullToReloadStatus		status;
	UILabel						*statusLabel;
	UIImageView					*arrowImage;
	UIImageView					*logoImgView;
	UIActivityIndicatorView		*activityView;
	SystemSoundID				popSound, pull1Sound, pull2Sound;
}

@property (nonatomic, readonly) UIPullToReloadStatus status;

- (void)setStatus:(UIPullToReloadStatus)status animated:(BOOL)animated;

// call when start loading
- (void) startReloading:(UITableView *)tableView animated:(BOOL)animated;

// call when finish loading
- (void) finishReloading:(UITableView *)tableView animated:(BOOL)animated;


@end
