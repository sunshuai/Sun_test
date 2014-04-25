//
//  UIPullToReloadFooterView.m
//  Untitled
//
//  Created by YuHui on 10-12-10.
//  Copyright 2010 Seeyon ShangHai. All rights reserved.
//

#import "UIPullToReloadFooterView.h"
#import <QuartzCore/QuartzCore.h>

#define TEXT_COLOR [UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1.0]
#define BORDER_COLOR [UIColor colorWithRed:0/255.0 green:0/255.0 blue:128.0/255.0 alpha:1.0]
#define BACKGROUND_COLOR [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];

@interface UIPullToReloadFooterView()

- (SystemSoundID) createSound:(NSString*)soundName;
- (void)flipImage:(BOOL)flip animated:(BOOL)animated;
- (void)setActivityView:(BOOL)isON;

@end

#pragma mark -

@implementation UIPullToReloadFooterView
@dynamic status;
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		status = kPullStatusPullDownToReload;
		
		self.backgroundColor = [UIColor clearColor];;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		
		[activityView release];
		[statusLabel release];
		[arrowImage release];
		[logoImgView release];
		
		
		statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 8/*frame.size.height - 48.0f*/, 320.0f, 20.0f)];
		statusLabel.font = [UIFont boldSystemFontOfSize:12.0f];
		statusLabel.textColor = TEXT_COLOR;
		statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.opaque = YES;
		statusLabel.textAlignment = UITextAlignmentCenter;
		statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		statusLabel.text = NSLocalizedString(@"上拉可以加载更多...", @"label");		
		[self addSubview:statusLabel];
		
		arrowImage = [[UIImageView alloc] initWithFrame: CGRectMake(5.0f, 3, 41.0f, 35.0f)];
		arrowImage.contentMode = UIViewContentModeScaleAspectFit;
		arrowImage.image = [UIImage imageNamed:@"arrow_up.png"];
		[self addSubview:arrowImage];
		
		activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
		activityView.frame = CGRectMake(25.0f, 10/*frame.size.height - 38.0f*/, 20.0f, 20.0f);
		activityView.hidesWhenStopped = YES;
		[self addSubview:activityView];
		
		// load sound
		pull1Sound = [self createSound:@"pull1"];
		pull2Sound = [self createSound:@"pull2"];
		popSound = [self createSound:@"pop"];
    }
    return self;
}

- (void)dealloc {
	[activityView release];
	[statusLabel release];
	[arrowImage release];
	[logoImgView release];
	
	AudioServicesDisposeSystemSoundID(pull1Sound);
	AudioServicesDisposeSystemSoundID(pull2Sound);
	AudioServicesDisposeSystemSoundID(popSound);
	
    [super dealloc];
}

#pragma mark -

-(SystemSoundID) createSound:(NSString*)soundName {
	CFBundleRef mainBundle;
	SystemSoundID soundID;
	mainBundle = CFBundleGetMainBundle();
	CFURLRef alertSoundURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef)soundName, CFSTR("caf"), CFSTR("PullToReload.bundle"));
	AudioServicesCreateSystemSoundID(alertSoundURLRef, &soundID);
	CFRelease(alertSoundURLRef);
	return soundID;
}

- (void)flipImage:(BOOL)flip animated:(BOOL)animated {
	BOOL previousFlip = !CGAffineTransformIsIdentity(arrowImage.transform);
	if (flip == previousFlip) return;	// same
	if (animated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration: 0.18];
	}
	if (!flip) arrowImage.transform = CGAffineTransformIdentity;
	else arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
	if (animated) {
		[UIView commitAnimations];
	}
}

- (void)setActivityView:(BOOL)isON {
	if (isON) {
		if (!arrowImage.hidden) {
			[activityView startAnimating];
			arrowImage.hidden = YES;
		}
	}
	else {
		if (arrowImage.hidden) {
			[activityView stopAnimating];
			arrowImage.hidden = NO;
		}
	}
}

- (void)setStatus:(UIPullToReloadStatus)newStatus animated:(BOOL) animated {
	if (status == newStatus) return;	
	switch (newStatus) {
		case kPullStatusReleaseToReload:
			statusLabel.text = NSLocalizedString(@"松开即可加载...", @"label");
			[self flipImage:YES animated:animated];
			[self setActivityView: NO];
			if (animated) AudioServicesPlaySystemSound(pull1Sound);
			break;
		case kPullStatusPullDownToReload:
			statusLabel.text = NSLocalizedString(@"上拉可以加载更多...", @"label");
			[self flipImage:NO animated:animated];
			[self setActivityView: NO];
			if (animated) AudioServicesPlaySystemSound(pull2Sound);
			break;
		case kPullStatusLoading:
			statusLabel.text = NSLocalizedString(@"加载中...", @"label");
			[self flipImage:NO animated:animated];
			[self setActivityView: YES];
			break;
		default:
			break;
	}
	
	status = newStatus;
}

- (UIPullToReloadStatus) status {
	return status;
}

#pragma mark Loading, and finish loading

/* begin loading, set edge offset so that the loading will be shown */
- (void) startReloading:(UITableView *)tableView animated:(BOOL)animated {
	[self setStatus:kPullStatusLoading animated:animated];	
	if (animated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
	}
	tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
	if (animated) {
		[UIView commitAnimations];
	}
	AudioServicesPlaySystemSound(pull2Sound);
}

-(void) finishReloading:(UITableView *)tableView animated:(BOOL)animated {
	[self setStatus:kPullStatusPullDownToReload animated: animated];
	if (animated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.3];
	}
	[tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	if (animated) {
		[UIView commitAnimations];
	}
	AudioServicesPlaySystemSound(popSound);
}

@end
