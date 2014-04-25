//
//  StartUpView.m
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "StartUpView.h"

@implementation StartUpView

@synthesize m_imgView_animation = _m_imgView_animation;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundImage.image = [UIImage imageNamed:@"启动的动画"];
        [self addSubview:backgroundImage];
        [backgroundImage release];
        
        _m_imgView_animation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 310, 320, 16)];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for (int i = 1; i < 13; i++) {
            [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"welcome%d.png",i]]];
        }
        _m_imgView_animation.animationImages = array;
        [array release];
        _m_imgView_animation.animationDuration = 3;
        _m_imgView_animation.animationRepeatCount = 0;
        
        [self addSubview:_m_imgView_animation];
        
        [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:3];
        [self.m_imgView_animation startAnimating];
    }
    return self;
}

- (void)stopAnimation
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self.m_imgView_animation stopAnimating];
    [self removeFromSuperview];
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         

- (void)dealloc {
    self.m_imgView_animation = nil;
    [super dealloc];
}


@end
