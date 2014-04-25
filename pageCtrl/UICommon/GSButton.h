//
//  GSButton.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-7.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GSButtonTypeLeftLine,
    GSButtonTypeRightLine,
    GSButtonTypeNoneLine
}GSButtonType;



@interface GSButton : UIButton

+ (GSButton*)buttonWithImage:(UIImage*)aImage highlightBackgroundImage:(UIImage *)aBackgroundImage type:(GSButtonType)aType;

@end
