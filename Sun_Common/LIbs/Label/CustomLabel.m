//
//  CustomLabel.m
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

@synthesize verticalAlignment = verticalAlignment_;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
        self.verticalAlignment = VerticalAlignmentTop;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
	verticalAlignment_ = verticalAlignment;
	[self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
	CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
	switch (self.verticalAlignment) {
		case VerticalAlignmentTop:
			textRect.origin.y = bounds.origin.y;
			break;
		case VerticalAlignmentBottom:
			textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
			break;
		case VerticalAlignmentMiddle:
			// Fall through.
		default:
			textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
	}
	return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
	CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
	[super drawTextInRect:actualRect];
}


@end
