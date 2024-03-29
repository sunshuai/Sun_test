//
//  UIPullToReloadHeaderView.m
//

/*
 
 Created by Water Lou | http://www.waterworld.com.hk
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import <QuartzCore/QuartzCore.h>
#import "UIPullToReloadHeaderView.h"

#define TEXT_COLOR [UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1.0]
#define BORDER_COLOR [UIColor colorWithRed:0/255.0 green:0/255.0 blue:128.0/255.0 alpha:1.0]
#define BACKGROUND_COLOR [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];

@interface UIPullToReloadHeaderView()

- (SystemSoundID) createSound:(NSString*)soundName;
- (void)flipImage:(BOOL)flip animated:(BOOL)animated;
- (void)setActivityView:(BOOL)isON;

@end

#pragma mark -

@implementation UIPullToReloadHeaderView

@synthesize m_lastUpdatedDate;
@dynamic status;

- (id)initWithFrame:(CGRect)frame {
    if ( (self = [super initWithFrame:frame]) ) {
		
		status = kPullStatusPullDownToReload;
		
		self.backgroundColor = [UIColor clearColor];;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		
		lastUpdatedLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0f, frame.size.height - 30.0f, 320.0f, 20.0f)];
		lastUpdatedLabel.font = [UIFont systemFontOfSize:12.0f];
		lastUpdatedLabel.textColor = TEXT_COLOR;
		lastUpdatedLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		lastUpdatedLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		lastUpdatedLabel.backgroundColor = [UIColor clearColor];
		lastUpdatedLabel.opaque = YES;
		lastUpdatedLabel.textAlignment = UITextAlignmentCenter;
		lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[self addSubview:lastUpdatedLabel];
		
		statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, 320.0f, 20.0f)];
		statusLabel.font = [UIFont boldSystemFontOfSize:12.0f];
		statusLabel.textColor = TEXT_COLOR;
		statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.opaque = YES;
		statusLabel.textAlignment = UITextAlignmentCenter;
		statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		statusLabel.text = NSLocalizedString(@"下拉可以刷新...", @"label");		
		[self addSubview:statusLabel];
		
		//arrowImage = [[UIImageView alloc] initWithFrame: CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f)];
		arrowImage = [[UIImageView alloc] initWithFrame: CGRectMake(5.0f, frame.size.height - 45.0f, 41.0f, 35.0f)];
		arrowImage.contentMode = UIViewContentModeScaleAspectFit;
		arrowImage.image = [UIImage imageNamed:@"PullToReload.bundle/arrow.png"];
		[self addSubview:arrowImage];
		
		activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
		activityView.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		activityView.hidesWhenStopped = YES;
		[self addSubview:activityView];
		
		//float left = ( self.frame.size.width - 70 ) / 2.0;
		//logoImgView = [[UIImageView alloc] initWithFrame: CGRectMake(left, 5.0f, 70.0f, 66.0f)];
		arrowImage.image = [UIImage imageNamed:@"arrow.png"];
		//[self addSubview:logoImgView];

		// load sound
		pull1Sound = [self createSound:@"pull1"];
		pull2Sound = [self createSound:@"pull2"];
		popSound = [self createSound:@"pop"];
    }
    return self;
}

- (void)dealloc
{
	[activityView release];
	[statusLabel release];
	[arrowImage release];
	[lastUpdatedLabel release];
	self.m_lastUpdatedDate = nil;
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

- (void)drawRect:(CGRect)rect {
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	CGContextDrawPath(context,  kCGPathFillStroke);
//	[BORDER_COLOR setStroke];
//	CGContextBeginPath(context);
//	CGContextMoveToPoint(context, 0.0f, self.bounds.size.height - 1);
//	CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height - 1);
//	CGContextStrokePath(context);
}

- (void)flipImage:(BOOL)flip animated:(BOOL)animated {
	BOOL previousFlip = !CGAffineTransformIsIdentity(arrowImage.transform);
	if (flip == previousFlip) return;	// same
	if (animated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration: 0.18];
	}
	
	if (!flip) {
		arrowImage.transform = CGAffineTransformIdentity;
	}
	else {
		arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
	}
	
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


- (void)setLastUpdatedDate:(NSDate *)newDate {
	if (newDate) {
		self.m_lastUpdatedDate = newDate;
		
		NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterShortStyle];
		[formatter setTimeStyle:NSDateFormatterShortStyle];
		lastUpdatedLabel.text = [NSString stringWithFormat:
								 NSLocalizedString(@"最后更新: %@", @"label"), [formatter stringFromDate:self.m_lastUpdatedDate]];
		[formatter release];
	}
	else {
		self.m_lastUpdatedDate = nil;
		lastUpdatedLabel.text = NSLocalizedString(@"最后更新: Never", @"label");
	}
}

- (void)setStatus:(UIPullToReloadStatus)newStatus animated:(BOOL) animated {
	if (status == newStatus) return;	
	switch (newStatus) {
		case kPullStatusReleaseToReload:
			statusLabel.text = NSLocalizedString(@"松开即可刷新...", @"label");
			[self flipImage:YES animated:animated];
			[self setActivityView: NO];
			if (animated) AudioServicesPlaySystemSound(pull1Sound);
			break;
		case kPullStatusPullDownToReload:
			statusLabel.text = NSLocalizedString(@"下拉可以刷新...", @"label");
			[self flipImage:NO animated:animated];
			[self setActivityView: NO];
			if (animated) AudioServicesPlaySystemSound(pull2Sound);
			break;
		case kPullStatusLoading:
			statusLabel.text = NSLocalizedString(@"载入中...", @"label");
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
