//
//  UrlImageButton.h
//  test image
//
//  Created by Xuyan Yang on 8/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageCompat.h"
#import "SDWebImageManagerDelegate.h"

@interface UrlImageButton : UIButton <SDWebImageManagerDelegate> {	
    NSInteger iconIndex;

	CGSize scaleSize;
	BOOL    isScale;
	id      anyObjct;   //  button的任意属性
	BOOL    _animated;
	BOOL    _isBackgroundImage;
    NSString* picUrl;
    CGRect frame_final;
}
@property (nonatomic, retain) id anyObjct;
@property (nonatomic, assign) NSInteger iconIndex;
@property (nonatomic, retain) NSString* picUrl;

-(UIImage*) getDefaultImage;

- (void) setImageFromUrl:(BOOL)animated withUrl:(NSString *)iconUrl;
- (void) setBackgroundImageFromUrl:(BOOL)animated withUrl:(NSString *)iconUrl;

- (void)setImageWithURL:(NSURL *)url;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)cancelCurrentImageLoad;

@end


//使用方法
/*
UrlImageButton* playButton = [[UrlImageButton alloc]initWithFrame:CGRectMake(100, 65, 59, 59)];
[playButton setBackgroundImage:[UIImage imageNamed:@"02_star_video.png"] forState:UIControlStateNormal];
playButton.anyObjct = service;
[playButton addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
[img addSubview:playButton];
*/

