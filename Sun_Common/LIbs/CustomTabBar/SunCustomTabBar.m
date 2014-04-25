//
//  SunCustomTabBar.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-6.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "SunCustomTabBar.h"

@implementation SunCustomTabBar

-(UIImage *) tabBarImage:(UIImage *)startImage size:(CGSize)targetSize backgroundImage:(UIImage *)backgroundImage
{
    return startImage;
}

- (void)selectItemAtIndex:(NSInteger)index{
    [super selectItemAtIndex:index];
    UIButton* button = [buttons objectAtIndex:index];
	
    if ([delegate respondsToSelector:@selector(touchDownAtItemAtIndex:)])
		[delegate touchDownAtItemAtIndex:[buttons indexOfObject:button]];
}

- (UIButton*) buttonAtIndex:(NSUInteger)itemIndex width:(CGFloat)width
{
	// Create a new button with the right dimensions
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0.0, 0.0, width, self.frame.size.height);
	
	// Ask the delegate for the button's image
	UIImage* rawButtonImage = [delegate imageFor:self atIndex:itemIndex];
	// Create the normal state image by converting the image's background to gray
	UIImage* buttonImage = [self tabBarImage:rawButtonImage size:button.frame.size backgroundImage:nil];
	// And create the pressed state image by converting the image's background to the background image we get from the delegate
    
    UIImage* buttonPressedImage = nil;
    
    if ([delegate respondsToSelector:@selector(selectedItemBackgroundImage2AtIndex:)]) {
        buttonPressedImage = [delegate selectedItemBackgroundImage2AtIndex:itemIndex];
    }
	// add by sun shuai : add the title of button
    if ([delegate respondsToSelector:@selector(selectedItemTitile2AtIndex:)]) {
        NSString *titleButton = [delegate selectedItemTitile2AtIndex:itemIndex];
        [button setTitle:titleButton forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    // ended by sun shuai 
    
	// Set the gray & blue images as the button states
	[button setImage:buttonImage forState:UIControlStateNormal];
	[button setImage:buttonPressedImage forState:UIControlStateHighlighted];
	[button setImage:buttonPressedImage forState:UIControlStateSelected];
	
	// Ask the delegate for the highlighted/selected state image & set it as the selected background state
    if ([delegate respondsToSelector:@selector(selectedItemImage2:)]) {
        [button setBackgroundImage:[delegate selectedItemImage2:self] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[delegate selectedItemImage2:self] forState:UIControlStateSelected];
    }
    else
    {
        [button setBackgroundImage:[delegate selectedItemImage] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[delegate selectedItemImage] forState:UIControlStateSelected];
    }
	
	button.adjustsImageWhenHighlighted = NO;
	
	return button;
}

@end
