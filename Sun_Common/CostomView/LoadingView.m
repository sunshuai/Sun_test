//
//  LoadingView.m
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

@synthesize m_imgView_animation = _m_imgView_animation;
- (id)initWithFrame:(CGRect)frame comment:(NSString *)aTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] init];
        _m_imgView_animation = [[UIImageView alloc] init];
        _m_imgView_animation.animationDuration = 3;
        _m_imgView_animation.animationRepeatCount = 0;
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 30; i>=1; i--) {
            if (i == 10 ||i ==11) {
                continue;
            }
            [array addObject:[UIImage imageNamed:
                              [NSString stringWithFormat:@"loading_%d.png",i]]];
        }
        _m_imgView_animation.animationImages = array;
        [array release];
        if (frame.size.width < 100 || frame.size.height <100) {
            _m_imgView_animation.frame = CGRectMake(0.0, 0.0, 15, 13);
            label.frame = CGRectMake(0.0, 0.0, 50, 15);
            label.font = [UIFont systemFontOfSize:10];
        }else{           
            _m_imgView_animation.frame = CGRectMake(0.0, 0.0, 30, 25);
            label.frame = CGRectMake(0.0, 0.0, 100, 30);
            label.font = [UIFont systemFontOfSize:14];
        }
        
        _m_imgView_animation.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        label.center = CGPointMake(self.center.x, self.center.y+_m_imgView_animation.frame.size.height/2+label.frame.size.height/2);
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.text = aTitle;
        [self addSubview:_m_imgView_animation];
        [self addSubview:label];
        [label release];
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame comment:nil];
}
- (void)startAnimation{
    self.hidden = NO;
    if ([self.m_imgView_animation isAnimating]) {
        return;
    }
    [self.m_imgView_animation startAnimating];
}
- (void)stopAnimation{
    self.hidden = YES;
    if ([self.m_imgView_animation isAnimating]) {
        [self.m_imgView_animation stopAnimating];
    }
}
- (void)dealloc {
    self.m_imgView_animation = nil;
    [super dealloc];
}

@end
