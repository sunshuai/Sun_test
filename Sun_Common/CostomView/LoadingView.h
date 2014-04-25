//
//  LoadingView.h
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
{
    UIImageView *_m_imgView_animation;
}
@property (nonatomic, retain) UIImageView *m_imgView_animation;
//启动动画
- (void)startAnimation;
//停止动画
- (void)stopAnimation;
- (id)initWithFrame:(CGRect)frame comment:(NSString *)aTitle;

@end
