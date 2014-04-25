//
//  CustomMiddleLineLabel.m
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "CustomMiddleLineLabel.h"

@implementation CustomMiddleLineLabel

@synthesize enabled_middleLine;

- (void)drawRect:(CGRect)rect {
	
	if ( enabled_middleLine == YES) {
		CGSize sizeToDraw = [self.text sizeWithFont:self.font];
		CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIColor *uicolor = self.textColor;
        CGFloat R, G, B;
        CGColorRef color = [uicolor CGColor];
        int numComponents = CGColorGetNumberOfComponents(color);
        
        if (numComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents(color);
            R = components[0];
            G = components[1];
            B = components[2];
            NSLog(@"r==%f,g==%f,b==%f",R,G,B);
            CGContextSetRGBStrokeColor(ctx, R, G, B, 1.0f); // RGBA
        }
        else
        {
            CGContextSetRGBStrokeColor(ctx, 152.0/255.0, 154.0/255.0, 158.0/255.0, 1.0f); // RGBA
        }
		
		CGContextSetLineWidth(ctx, 1.0f);
		float x_start = 0 ;
		if ( self.textAlignment == UITextAlignmentLeft) {
			x_start = 0;
		}else if ( self.textAlignment == UITextAlignmentCenter) {
			x_start = ( self.bounds.size.width-sizeToDraw.width )/2;
		}else if ( self.textAlignment == UITextAlignmentRight){
			x_start = ( self.bounds.size.width-sizeToDraw.width );
		}
        
		CGContextMoveToPoint(ctx, x_start, self.bounds.size.height/2 );
		CGContextAddLineToPoint(ctx, sizeToDraw.width+x_start, self.bounds.size.height/2 );
		
		CGContextStrokePath(ctx);
	} 
    [super drawRect:rect];  
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
