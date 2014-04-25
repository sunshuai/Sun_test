//
//  CustomLabel.h
//  Sun_test
//
//  Created by Shuai Sun on 12-9-12.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum VerticalAlignment {
	VerticalAlignmentTop,//垂直居上
	VerticalAlignmentMiddle,//垂直居中
	VerticalAlignmentBottom,//垂直居下
} VerticalAlignment;

@interface CustomLabel : UILabel
{
@private
	VerticalAlignment verticalAlignment_;
}
@property (nonatomic, assign) VerticalAlignment verticalAlignment;
//设置YKCustomLabel文字的垂直排布方式
- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment;

@end
