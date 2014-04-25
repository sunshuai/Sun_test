//
//  UrlImageButton.m
//  test image
//
//  Created by Xuyan Yang on 8/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UrlImageButton.h"
#import "SDWebImageManager.h"
#import "NSURLAdditions.h"

@implementation UrlImageButton

@synthesize iconIndex;
@synthesize picUrl;
@synthesize anyObjct;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		iconIndex = -1;
        frame_final=frame;
		isScale = NO;
	}
    return self;
}

- (void)dealloc {
    if (picUrl) {
        [picUrl release];
    }
    [anyObjct release]; anyObjct = nil;
	[super dealloc];
}


- (void)setImage:(BOOL)animated withUrl:(NSString *)iconUrl withIsBkg:(BOOL)isBkg
{       
	_animated = animated;
	_isBackgroundImage = isBkg;
	picUrl = [[NSString alloc] initWithString:iconUrl];
	if(isBkg)
	{
		[self setBackgroundImage:[self getDefaultImage] forState:UIControlStateNormal];
	}
	else {
		[self setImage:[self getDefaultImage] forState:UIControlStateNormal];
	}

	NSURL* tempUrl = [NSURL URLWithString:iconUrl];
	
	NSURL* finallyUrl = nil;
	if([NSURL isWebURL:tempUrl])
	{
		finallyUrl = tempUrl;
	}
	else {
	}
	
	[self setImageWithURL:finallyUrl];
}	

- (void) setBackgroundImageFromUrl:(BOOL)animated withUrl:(NSString *)iconUrl
{       
	[self setImage:animated withUrl:iconUrl withIsBkg:YES];
}	

- (void) setImageFromUrl:(BOOL) animated withUrl:(NSString *)iconUrl
{       
     [self performSelector:@selector(loadImage:) withObject:iconUrl afterDelay:0.1];
	
}	
-(void)loadImage:(id)sender{
     NSString *icon=(NSString *)sender;
    [self setImage:YES withUrl:icon withIsBkg:NO];
}
	
- (void)setImageWithURL:(NSURL *)url
{
	[self setImageWithURL:url placeholderImage:[self getDefaultImage]];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
	SDWebImageManager *manager = [SDWebImageManager sharedManager];
	
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
	
    if(_isBackgroundImage)
	{
	    [self setBackgroundImage:placeholder forState:UIControlStateNormal];
	}
	else {
		[self setImage:placeholder forState:UIControlStateNormal];
	}
	
    if (url)
    {
        [manager downloadWithURL:url delegate:self];
    }
}

- (void)cancelCurrentImageLoad
{
	[[SDWebImageManager sharedManager] cancelForDelegate:self];
}

-(UIImage*) getDefaultImage
{
	CGSize frameSize = self.frame.size;
	if(frameSize.width == 90 &&frameSize.height == 60)
	{
		return [UIImage  imageNamed:@"default_01.png"];
	}
	else if(frameSize.width == 90 && frameSize.height == 120){
		return [UIImage  imageNamed:@"default_02.png"];
	}
	else if(frameSize.width ==120&&frameSize.height==80){
		return [UIImage  imageNamed:@"default_03.png"];
	}
	else if(frameSize.width ==150&&frameSize.height==200){
		return [UIImage  imageNamed:@"default_04.png"];
	}
	else if(frameSize.width ==360&&frameSize.height==480){
		return [UIImage  imageNamed:@"default_05.png"];
	}
    else if(frameSize.width ==30&&frameSize.height==40){
		return [UIImage  imageNamed:@"default_06.png"];
	}
	return nil;
}



#pragma mark -

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
	if(_animated)
	{
        //self.frame=CGRectMake(frame_final.origin.x, frame_final.origin.y, 0, 0);
	    [UIView beginAnimations:nil context:nil];
	    [UIView setAnimationDuration:0.5];
        //self.frame=frame_final;
	    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
//        self.frame=CGRectMake(frame_final.origin.x+frame_final.size.width/2, frame_final.origin.y+frame_final.size.height/2, 0, 0);
//	    [UIView beginAnimations:nil context:nil];
//	    [UIView setAnimationDuration:0.5];
//        self.frame=frame_final;
//        [UIView commitAnimations];
	}
	
	if(_isBackgroundImage)
	{
	    [self setBackgroundImage:image forState:UIControlStateNormal];
	}
	else {
		[self setImage:image forState:UIControlStateNormal];
	}

	if(_animated)
	{
		[UIView commitAnimations];
	}
}

@end
