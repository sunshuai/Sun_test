//
//  UrlImageButton.m
//  test image
//
//  Created by Xuyan Yang on 8/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UrlImageView.h"
#import "NSURLAdditions.h"
#import "SDWebImageManager.h"

@interface UIImage (scale)  

-(UIImage*)scaleToSize:(CGSize)size;  

@end  

@implementation UIImage (scale)  

-(UIImage*)scaleToSize:(CGSize)size  
{  
    // 创建一个bitmap的context  
    // 并把它设置成为当前正在使用的context  
    UIGraphicsBeginImageContext(size);  
	
    // 绘制改变大小的图片  
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];  
	
    // 从当前context中创建一个改变大小后的图片  
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();  
	
    // 使当前的context出堆栈  
    UIGraphicsEndImageContext();  
	
    // 返回新的改变大小后的图片  
    return scaledImage;  
}  

@end  

@implementation UrlImageView

@synthesize iconIndex;
@synthesize _animated;
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		iconIndex = -1;
        frame_final=frame;
		isScale= NO;
		_animated = NO;
		scaleSize = CGSizeZero;
	}
    return self;
}

- (void)dealloc {
	
    
    
	[super dealloc];
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
	else if(frameSize.width ==320&&frameSize.height==133){
		return [UIImage  imageNamed:@"default_05.png"];
	}
    else if(frameSize.width ==30&&frameSize.height==40){
		return [UIImage  imageNamed:@"default_06.png"];
	}
	return nil;
	
}


- (void) setImageFromUrl:(BOOL)animated withUrl:(NSString *)iconUrl;
{       	

	_animated = animated;
	
	NSURL* tempUrl = [NSURL URLWithString:iconUrl];


	NSURL* finallyUrl = nil;
	if([NSURL isWebURL:tempUrl])
	{
		finallyUrl = tempUrl;
	}
	else {
	}

	
	[self setImageWithURL:finallyUrl placeholderImage:[self getDefaultImage]];
	
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
	
    self.image = placeholder;
	_animated=NO;
    if (url)
    {
        [manager downloadWithURL:url delegate:self];
    }
	
}

- (void)cancelCurrentImageLoad
{
	[[SDWebImageManager sharedManager] cancelForDelegate:self];
}

-(void)scaleToSize:(CGSize)size 
{
	isScale= YES;
	scaleSize =size;
	UIImage* newImage = [self.image scaleToSize:size];
	self.image = newImage;
}
	

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
	if(_animated)
	{
//		[UIView beginAnimations:nil context:nil];
//		[UIView setAnimationDuration:1.0];
//		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
        self.frame=CGRectMake(frame_final.origin.x+frame_final.size.width/2, frame_final.origin.y+frame_final.size.height/2, 0, 0);
	    [UIView beginAnimations:nil context:nil];
	    [UIView setAnimationDuration:0.5];
        self.frame=frame_final;
	    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
        [UIView commitAnimations];
	}

    self.image = image;
	
	if(_animated)
	{
		[UIView commitAnimations];	
	}
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error
{

    if(_animated)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:1.0];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
	}
    self.image = [UIImage imageNamed:@""];

	if(_animated)
	{
		[UIView commitAnimations];	
	}
}


@end
