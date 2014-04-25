//
//  UINavigationBar+CustomNavBar.m
//  Sun_test
//
//  Created by Shuai Sun on 12-7-18.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "UINavigationBar+CustomNavBar.h"

@implementation UINavigationBar (CustomNavBar)


-(void)drawRect:(CGRect)rect
{
    if (self.tag) {
        NSString *imageName = [NSString stringWithFormat:@"navbar_background_tag_%d",self.tag];
        UIImage *backgroudImageForTag = [UIImage imageNamed:imageName];
        [backgroudImageForTag drawInRect:self.bounds];// 视图绘制
    }
    
//    //颜色填充
//    UIColor *color = [UIColor redColor];
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColor(context,CGColorGetComponents([color CGColor]));
//    
//    CGContextFillRect(context,rect);
//    
//    self.tintColor = color;
//    
//    
//    
//    //图片填充
//    UIColor *color2 = [UIColor colorWithRed:46.0f/255.0f green:87.0f/255.0f blue:29.0f/255.0f alpha:1.0f];
//    
//    UIImage *img = [UIImage imageNamed:@"bg.png"];
//    
//    [img drawInRect:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
//    
//    self.tintColor = color2;
    
    
// 方法二：
////    自定义图片背景以下两句代码是关键：
//    UIImage *img = [UIImage imageNamed:@"bg.png"];
//    
//    [img drawInRect:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
////    或者：
//    CGPoint point = {0,0};
//    [img drawAtPoint:point];
////    或者：
//    
//    //加入旋转坐标系代码
//    
//    
//    
//    // Drawing code
//    
//    
//    
//    UIImage *navBarImage = [UIImage imageNamed:@"LOGO_320×44.png"];
//    
//    
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    
//    
//    CGContextTranslateCTM(context, 0.0, self.frame.size.height);
//    
//    
//    
//    CGContextScaleCTM(context, 1.0, -1.0);
//    
//    
//    
//    CGPoint center=self.center;
//    
//    
//    
//    CGImageRef cgImage= CGImageCreateWithImageInRect(navBarImage.CGImage,CGRectMake(0, 0, 1, 44));
//    
//    
//    
//    CGContextDrawImage(context, CGRectMake(center.x-160-80, 0, 80,self.frame.size.height), cgImage);
//    
//    
//    
//    CGContextDrawImage(context, CGRectMake(center.x-160, 0, 320,self.frame.size.height), navBarImage.CGImage);
//    
//    
//    
//    CGContextDrawImage(context, CGRectMake(center.x+160, 0, 80,self.frame.size.height), cgImage);

}


-(void)layoutSubviews
{
    NSLog(@"navgationBar ==== self.frame (%f,%f,%f,%f)",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
    [super layoutSubviews];
    // do something to adjust subview position
    float dissireBacgroundImageIndex = 0;
    if (IOS_VERSION < 5.0 ) {
        
    }else {
        dissireBacgroundImageIndex = 1;
    }
    
    if (self.tag) {
        //#warning this image name format should be put in a globle config file
        // this image name format should be put in a global config file
        NSString *imageName = [NSString stringWithFormat:@"navbar_background_tag_%d",self.tag];
        
        UIImage *backgroundImageForTag = [UIImage imageNamed:imageName];
        
        UIImageView *custombackgroundImageView  = (UIImageView*)[self viewWithTag:CUNTOM_BACKGROUNDIMAGEVIEW];
        if (custombackgroundImageView == nil) {
            custombackgroundImageView = [[UIImageView alloc] initWithImage:backgroundImageForTag];
            
            //Debug
            // customBacgroundImageView.backgroundColor = [UIColor redColor];
            custombackgroundImageView.frame = self.bounds;
            custombackgroundImageView.tag = CUNTOM_BACKGROUNDIMAGEVIEW;
            custombackgroundImageView.clipsToBounds = YES;
            custombackgroundImageView.contentMode = UIViewContentModeScaleToFill;
            
            custombackgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            
            [self insertSubview:custombackgroundImageView atIndex:dissireBacgroundImageIndex];
        }else {
            [custombackgroundImageView setImage:backgroundImageForTag];
        }
        // Debug
        //CALayer *imageLayer = customBackgroundImageView.layer;
        //imageLayer.borderWidth = 1.0f;        
        
    }
    
    for (UIView *view in self.subviews ) {
        if (view.tag == CUNTOM_BACKGROUNDIMAGEVIEW) {
            int indexOfCustomImageView = [self.subviews indexOfObject:view];
            if (indexOfCustomImageView != dissireBacgroundImageIndex) {
                [self exchangeSubviewAtIndex:indexOfCustomImageView withSubviewAtIndex:dissireBacgroundImageIndex];
                break;
            }
        }
    }
    
    for (UIView *view in self.subviews) {
        NSLog(@"%@",view);
        CGRect rect = view.frame;
        rect.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(rect))/2;
        NSLog(@"自身view 的rect.orgin.y = %f",rect.origin.y);
        view.frame = rect;
    }
}

-(CGSize)sizeThatFits:(CGSize)size
{
    CGSize resultSize = [super sizeThatFits:size];
    
    // get images for different ViewControllers,identify is self.tag
    if (self.tag) {
        NSString *imageName = [NSString stringWithFormat:@"navbar_background_tag_%d",self.tag];
        
        UIImage *backgroundImageForTag = [UIImage imageNamed:imageName];
        
        if (backgroundImageForTag) {
            resultSize.height = backgroundImageForTag.size.height;
        }
        NSLog(@">>>>>>>>>>>>>>CustomNavigationBarSize ; (%f,%f)",resultSize.width,resultSize.height);
        [self setNeedsLayout];
    }
    return resultSize;
}

-(void)setTag:(NSInteger)tag
{
    [super setTag:tag];
    [self setNeedsLayout];
}



@end
