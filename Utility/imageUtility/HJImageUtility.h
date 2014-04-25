//
//  HJImageUtility.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-6.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJManagedImageV.h"

@interface HJImageUtility : NSObject

static void addRoundedRectToPath(CGContextRef context, CGRect rect, 
								 float ovalWidth,float ovalHeight) ;

- (UIImage *) roundCorners: (UIImage*) img;
- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage ;
+(UIImageView *) getUIImageView:(UIImage *)img;
+(UIImage *)getUIImage:(NSString *) filePath;
+(UIImage *)getUIImage_releaseVersion:(NSString *) filePath;
+ (UIImage*)imageByCropping:(UIImage *)imageToCrop toEllipseInRect:(CGRect)rect;//按椭圆切图
/*
 从网址中加载图片，会阻塞
 */
+(UIImage*) imageFromUrl:(NSString*) url;

+(void) queueLoadImageFromUrl:(NSString*) url imageView:(HJManagedImageV*) imageView;
+(void) queueLoadImageFromUrl:(NSString *)url object:(id) object action:(SEL) action  param:(id)param;
/*
 添加图片是否可以转动
 modify by chaosyan 2-20-2012
 */
+(void) queueLoadImageFromUrl:(NSString*) url imageView:(HJManagedImageV*) imageView userFilpAnimated:(BOOL)mUseFilpAnimated;


@end
