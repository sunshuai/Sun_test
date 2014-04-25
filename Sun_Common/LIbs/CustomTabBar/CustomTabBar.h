
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE
//

@class CustomTabBar;
@protocol CustomTabBarDelegate<NSObject>
- (UIImage*) selectedItemBackgroundImage2AtIndex:(NSUInteger)itemIndex;
-(NSString *)selectedItemTitile2AtIndex:(NSUInteger)itemIndex;
- (UIImage*) imageFor:(CustomTabBar*)tabBar atIndex:(NSUInteger)itemIndex;
- (UIImage*) backgroundImage;
- (UIImage*) selectedItemBackgroundImage;
- (UIImage*) glowImage;
- (UIImage*) selectedItemImage;
- (UIImage*) tabBarArrowImage;

@optional
- (UIImage*) selectedItemImage2:(CustomTabBar*)customTabBar;

- (void) touchUpInsideItemAtIndex:(NSUInteger)itemIndex;
- (void) touchDownAtItemAtIndex:(NSUInteger)itemIndex;
@end


@interface CustomTabBar : UIView
{
	NSObject <CustomTabBarDelegate> *delegate;
	NSMutableArray* buttons;
    
    NSInteger       m_CurIndexToInit;             // yh 当前初始化的button序号
}

@property (nonatomic, retain) NSMutableArray* buttons;
@property(nonatomic,readonly)NSInteger  m_CurIndexToInit;

- (id) initWithItemCount:(NSUInteger)itemCount itemSize:(CGSize)itemSize tag:(NSInteger)objectTag delegate:(NSObject <CustomTabBarDelegate>*)customTabBarDelegate;

- (void) selectItemAtIndex:(NSInteger)index;
- (void) glowItemAtIndex:(NSInteger)index;
- (void) removeGlowAtIndex:(NSInteger)index;

@end
