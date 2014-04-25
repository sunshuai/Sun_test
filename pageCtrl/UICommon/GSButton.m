//
//  GSButton.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-7.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "GSButton.h"

@implementation GSButton

+ (GSButton*)buttonWithImage:(UIImage *)aImage highlightBackgroundImage:(UIImage *)aBackgroundImage type:(GSButtonType)aType
{
    GSButton *navBackButon = [[[NSBundle mainBundle] loadNibNamed:@"GSButton" owner:nil options:nil] objectAtIndex:0];
    
    [navBackButon setImage:aImage forState:UIControlStateNormal];
    [navBackButon setImage:aImage forState:UIControlStateHighlighted];
    
    [navBackButon setBackgroundImage:aBackgroundImage forState:UIControlStateHighlighted];
    
    if (aType != GSButtonTypeNoneLine) {
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
        imgV.tag = 3001;
        imgV.center = navBackButon.center;
        imgV.highlightedImage = [UIImage imageNamed:@"line_selected.png"];
        CGRect oldFrame = imgV.frame;
        if (aType == GSButtonTypeLeftLine) {
            imgV.frame = CGRectMake(0, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height);
        }else if (aType == GSButtonTypeRightLine ) {
            imgV.frame = CGRectMake(navBackButon.frame.size.width-2, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height);
        }
        [navBackButon addSubview:imgV];
        [imgV release];
    }
    return navBackButon;
}


-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    UIImageView *imgV = (UIImageView*)[self viewWithTag:3001];
    [imgV setHighlighted:highlighted];
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
