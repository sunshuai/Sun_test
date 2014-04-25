//
//  CustomUnderLineLabel.m
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "CustomUnderLineLabel.h"

@implementation CustomUnderLineLabel

- (void)drawRect:(CGRect)rect {
	
	CGSize sizeToDraw = [self.text sizeWithFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:14.0]];
	
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	const CGFloat *colorArray = CGColorGetComponents([self.textColor CGColor]);
    CGContextSetRGBStrokeColor(ctx, colorArray[0], colorArray[1], colorArray[2], 1.0f); // RGBA
    CGContextSetLineWidth(ctx, 1.0f);
	float x_start = 0 ;
	if ( self.textAlignment == UITextAlignmentLeft) {
		x_start = 0;
	}else if ( self.textAlignment == UITextAlignmentCenter) {
		x_start = ( self.bounds.size.width-sizeToDraw.width )/2;
	}else if ( self.textAlignment == UITextAlignmentRight){
		x_start = ( self.bounds.size.width-sizeToDraw.width );
	}
	
    CGContextMoveToPoint(ctx, x_start, sizeToDraw.height + 2 );
    CGContextAddLineToPoint(ctx, sizeToDraw.width, sizeToDraw.height );
	
    CGContextStrokePath(ctx);
	
    [super drawRect:rect];  
}


@end
