//
//  UINavigationBar+CustomNavBar.h
//  Sun_test
//
//  Created by Shuai Sun on 12-7-18.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

#define CUNTOM_BACKGROUNDIMAGEVIEW  200

@interface UINavigationBar (CustomNavBar)


@end



////此方法转载自：http://www.cnblogs.com/moshengren/archive/2010/10/18/1855202.html
////
////方法四：通过导入QuartzCore框架绘制CALayer层来自定义
//
//#import <QuartzCore/QuartzCore.h>
//
//
//
//@interface DDNavigationViewController : UINavigationController<UINavigationControllerDelegate> {
//    
//    
//    
//    CALayer *_barBackLayer;
//    
//    
//    
//}
//
//
//
//@end
//
//
//
//
//@implementation DDNavigationViewController
//
// 
//
// - (id)initWithRootViewController:(UIViewController *)rootViewController {
//    
//
//    
//   self = [super initWithRootViewController:rootViewController];
//    
//
//    
//   self.delegate = self;
//    
//
//    return self;
//    
//}
//
//
// - (void)loadView {
//
// [super loadView];
//
//  UINavigationBar *bar = self.navigationBar;
//
//   CALayer*layer = [CALayer layer];
//
// UIImage *navBarImage = [UIImage imageNamed:@"navigationBarBackground.png"];
//
//     layer.contents = (id)navBarImage.CGImage;
//
//  layer.frame= CGRectMake(0, 0, 320, navBarImage.size.height);
//
//    
//   [bar.layer insertSublayer:layer atIndex:0];
//
//   _barBackLayer = layer;
//
//}  
//
//
//
//
// #pragma mark UINavigationControllerDelegate
//
// - (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    
//   [_barBackLayer removeFromSuperlayer];
//    
//    [navigationController.navigationBar.layer insertSublayer:_barBackLayer atIndex:0];
//
//    
// }
// @end
