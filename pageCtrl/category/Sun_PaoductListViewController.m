//
//  Sun_PaoductListViewController.m
//  Sun_test
//
//  Created by Shuai Sun on 12-9-7.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "Sun_PaoductListViewController.h"

#import "HJImageUtility.h"
#import "CategoryListCell.h"
#import "JSON.h"



#define         titleViewWidth          70
#define         scrollViewTagpreNum     70000
#define         halfImageSender         30

@interface Sun_PaoductListViewController (Private)

-(void)secondButtonPressed:(id)sender;
-(void)thirdButtonPressed:(id)sender;

@end

@implementation Sun_PaoductListViewController

@synthesize table_Category;
@synthesize m_categoryData;
@synthesize mIndexDic;
@synthesize image_glass;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setCustomNavBackButtonHidden:YES];
    
    mIndexDic = [[NSMutableDictionary alloc] init];
    
    image_glass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"universe_triangle_up.png"]];
    image_glass.frame = CGRectMake(0*titleViewWidth+halfImageSender , 34 , 10, 6);
    // 初始化每一个tableview的所有分区的开关状态字典
    [mIndexDic setObject:[NSMutableSet set] forKey:[NSNumber numberWithInt:table_Category.tag]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.image_glass = nil;
    self.table_Category = nil;
    self.m_categoryData = nil;
    self.mIndexDic = nil;
}
-(void)dealloc
{
    self.image_glass = nil;
    self.table_Category = nil;
    self.m_categoryData = nil;
    self.mIndexDic = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"categaryData" ofType:@"json"];
    
    NSString *jsonStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //    NSDictionary *jsonData = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSDictionary *jsonData = [jsonStr JSONValue];
    NSLog(@"=======%@",jsonData);
    
    m_categoryData = [[YPCategoryData alloc] initWithJsonObject:jsonData];
}



// 判断是否展开
- (BOOL)isSection:(int)section ExpandOfTableView:(UITableView*)tableView{
    
    BOOL result = NO;
    NSMutableSet *expandedSectionsSet = [mIndexDic objectForKey:[NSNumber numberWithInt:tableView.tag]];
    
    if ( [expandedSectionsSet containsObject:[NSNumber numberWithInt:section]] ) {
        result = YES;
    }
    
    return result;
} 

// 展开的section保存到expandedSectionsSet里面
- (void)setSection:(int)section tableView:(UITableView*)tableView expand:(BOOL)expand{
    
    NSMutableSet *expandedSectionsSet = [mIndexDic objectForKey:[NSNumber numberWithInt:tableView.tag]];
    
    if ( expand ) {
        
        if ( ![expandedSectionsSet containsObject:[NSNumber numberWithInt:section]] ) {
            [expandedSectionsSet addObject:[NSNumber numberWithInt:section]];
        }
        
    }else{
        
        [expandedSectionsSet removeObject:[NSNumber numberWithInt:section]];
        
    }
    
}


-(void)headViewTouchUpIn:(id)sender
{
    
    int sectionIndex = ((UIButton *)sender).tag;
    
    NSLog(@"all key value === %@",mIndexDic);
//    NSMutableSet *expandedSectionsSet = [mIndexDic objectForKey:[NSNumber numberWithInt:table_Category.tag]];
//    for (NSNumber *ind in [expandedSectionsSet allObjects]) {
//        int number = [ind intValue];
//        if (number != sectionIndex) {
//            [self setSection:number tableView:table_Category expand:NO];
//            [table_Category reloadSections:[NSIndexSet indexSetWithIndex:number] withRowAnimation:UITableViewRowAnimationNone];
//        }
//    }
    
    BOOL expand = [self isSection:sectionIndex ExpandOfTableView:table_Category];
    if (expand) {
        // 关闭
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:[NSString stringWithFormat:@"%d",sectionIndex]];
        //        [table_Category insertRowsAtIndexPaths:[NSArray arrayWithObject: [NSIndexPath indexPathForRow:0 inSection:sectionIndex]] withRowAnimation:UITableViewRowAnimationFade];
        
        //        [m_table_Class deleteRowsAtIndexPaths:[NSArray arrayWithObject: [NSIndexPath indexPathForRow:0 inSection:sectionIndex]] withRowAnimation:UITableViewRowAnimationFade];
        
    }else {
        // 打开
        isPressedSecBtn = NO;
        secIndexItem = 0;
        section_Index = sectionIndex;
    }
    [self setSection:sectionIndex tableView:table_Category expand:!expand];
    
    [table_Category reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDelegate 
#pragma mark - UItableViewDataSourse
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    BOOL expand = [self isSection:section ExpandOfTableView:tableView];
    
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    sectionView.backgroundColor = [UIColor whiteColor];
    if (section >= 1 ) {
        
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.frame = sectionView.frame;
        [sectionView addSubview:bgImageView];
        [bgImageView release];
        
        if ( expand ) { // 展开
            
            bgImageView.image = [UIImage imageNamed:@"sort_main_title.png"];          
            UIImageView* bgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"universe_arrow_up.png"]];
			bgview.frame = CGRectMake(290, 15, 14, 10);
			[sectionView addSubview:bgview];
			[bgview release];
        }else {
            bgImageView.image = [UIImage imageNamed:@"sort_unfold.png"];
            UIImageView* bgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"universe_arrow_down.png"]];
			bgview.frame = CGRectMake(290, 15, 14, 10);
			[sectionView addSubview:bgview];
			[bgview release];
        }
    }else {
        UIImageView* bgview = [[UIImageView alloc] init];
		bgview.frame = CGRectMake(0, 0, 320, 44);
		[sectionView addSubview:bgview];
		[bgview release];
		
		if (section == 0) {
			if ( expand ) {
                
                bgview.image = [UIImage imageNamed:@"sort_main_title.png"];
				UIImageView* bgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"universe_arrow_up.png"]];
				bgview.frame = CGRectMake(290, 15, 14, 10);
				[sectionView addSubview:bgview];
				[bgview release];
			}else {
                bgview.image = [UIImage imageNamed:@"sort_unfold.png"];
				UIImageView* bgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"universe_arrow_down.png"]];
				bgview.frame = CGRectMake(290, 15, 14, 10);
				[sectionView addSubview:bgview];
				[bgview release];
			}
		}else {
			UIImageView* bgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"universe_universe_table_cell_02.png"]];
			bgview.frame = CGRectMake(290, 15, 14, 10);
			[sectionView addSubview:bgview];
			[bgview release];
		}
    }
    
    
    YPFirstCategoryData *m_firstInfoData = (YPFirstCategoryData*)[[m_categoryData firstCategoryList] objectAtIndex:section];
    
    
    HJManagedImageV *imageView1 = [[HJManagedImageV alloc] initWithFrame:CGRectMake(10, 5, 35, 30)];
    [HJImageUtility queueLoadImageFromUrl:m_firstInfoData.imgUrl imageView:imageView1];
    [sectionView addSubview:imageView1];
    
    //组头加上标题
	UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 320, 35)];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    titleLabel.text = m_firstInfoData.name;
    titleLabel.textAlignment = UITextAlignmentLeft;
    [sectionView addSubview:titleLabel];
    [titleLabel release];
    
    UIButton *abutton = [UIButton buttonWithType:UIButtonTypeCustom];
    abutton.frame = CGRectMake(0, 0, 320, 35);
    abutton.tag = section;
    [abutton addTarget:self action:@selector(headViewTouchUpIn:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView addSubview:abutton];
    
    return sectionView;
    
}
// 头信息个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [m_categoryData.firstCategoryList count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberRow=0;
    BOOL expand = [self isSection:section ExpandOfTableView:tableView];
    
    if (expand ) {
        YPFirstCategoryData *m_firstInfoData = (YPFirstCategoryData*)[m_categoryData.firstCategoryList objectAtIndex:section];
        YPSecondCategoryData *second_data = (YPSecondCategoryData*)[m_firstInfoData.secondCategoryList objectAtIndex:secIndexItem];
        item_count = [second_data.thirdCategoryList count];
        if (item_count>0) {
            numberRow = 1+1; 
        }else {
            numberRow = 2;
        }
    }
    else {
        numberRow= 0;
    }
    return numberRow;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *Cell = nil;
    if (indexPath.row == 0) {
        
        if (Cell == nil) {
            Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            Cell = [[[NSBundle mainBundle] loadNibNamed:@"CategoryListCell" owner:self options:nil] objectAtIndex:1];
        }
        SecondCategoryCell *secViewCell = (SecondCategoryCell *)Cell;
        secViewCell.m_scrollView.tag = 10010;
        secViewCell.m_scrollView.delegate = self;
        
//        [secViewCell.m_scrollView setContentOffset:CGPointMake(contentOffSetX, 0)];
        
        YPFirstCategoryData *firstCategarydata = (YPFirstCategoryData *)[m_categoryData.firstCategoryList objectAtIndex:indexPath.section];
        
        
        if (![secViewCell.m_titleView.subviews count] && firstCategarydata.secondCategoryList.count >0) {
            
            secViewCell.m_scrollView.bounces = YES;
            secViewCell.m_scrollView.contentSize  = CGSizeMake(titleViewWidth * firstCategarydata.secondCategoryList.count, 40);
            
            secViewCell.m_titleView.frame = CGRectMake(0, 0, titleViewWidth * firstCategarydata.secondCategoryList.count, 40);
            [secViewCell.m_scrollView addSubview:image_glass];
            image_glass.frame = CGRectMake(0*titleViewWidth+halfImageSender , 34 , 10, 6);
            
            for (NSInteger i = 0; i < firstCategarydata.secondCategoryList.count; i++) {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = scrollViewTagpreNum + i;
                button.frame = CGRectMake(0 + i* titleViewWidth, 0, titleViewWidth, 40);
                
                YPSecondCategoryData *secondCategary = (YPSecondCategoryData*)[firstCategarydata.secondCategoryList objectAtIndex:i];
                
                button.titleLabel.font = [UIFont systemFontOfSize:16];
                [button setTitle:[NSString stringWithFormat:@"%@",secondCategary.name] forState:UIControlStateNormal];
                [button setTitleColor:YPCustomFont forState:UIControlStateNormal];
                
                if (i==secIndexItem) {
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                }
                
                [button addTarget:self action:@selector(secondButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [secViewCell.m_titleView addSubview:button];
            }
        }
    }else if (indexPath.row == 1) {
        
        NSLog(@"====== indexPath.row === %d",indexPath.row);
        
        if (Cell == nil) {
            Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            Cell = [[[NSBundle mainBundle] loadNibNamed:@"CategoryListCell" owner:self options:nil] objectAtIndex:3];
        }
        YPFirstCategoryData *firstCategary = (YPFirstCategoryData *)[m_categoryData.firstCategoryList objectAtIndex:indexPath.section];
        
        OtherCategoryCell* infoCell = (OtherCategoryCell*)Cell;
        
        YPSecondCategoryData *m_secondCategory = (YPSecondCategoryData*)[firstCategary.secondCategoryList objectAtIndex:secIndexItem];
                
        if (m_secondCategory.thirdCategoryList.count > 0) {
            
            for (UIButton *tmp in [infoCell.otherView subviews]) {
                if ([tmp isKindOfClass:[UIButton class]]) {
                    [tmp removeFromSuperview];
                }
            }
            
            if (m_secondCategory.thirdCategoryList.count == 0) {
                infoCell.otherView.frame = CGRectMake(0, 0, 320, 80);
            }else {
                int hangShu = 0;
                hangShu = (m_secondCategory.thirdCategoryList.count-1)/3+1;
                
                if (hangShu <=3) {
                    infoCell.otherView.frame = CGRectMake(0, 0, 320, 90+10);
                }else {
                    infoCell.otherView.frame = CGRectMake(0, 0, 320, 30*hangShu+10);
                }
            }
            
//            bg_iamgeView.frame = thirdView.frame;
//            
//            bottomImg.frame = CGRectMake(0, thirdView.frame.size.height-4, 320, 4);
            [infoCell.otherView clipsToBounds];
            
            NSLog(@"第三级的按钮个数== %d",m_secondCategory.thirdCategoryList.count);
            for (int j = 0; j < m_secondCategory.thirdCategoryList.count; j ++ ) {
                YPThirdCategoryData *thirdInfo = (YPThirdCategoryData*)[m_secondCategory.thirdCategoryList objectAtIndex:j];
                
                ObjButton *btn = [ObjButton buttonWithType:UIButtonTypeCustom];
                
                btn.frame =  CGRectMake(20 + 100*(j%3), 6+30*(j/3), 80, 20);
                [btn setTitle:thirdInfo.name forState:UIControlStateNormal];
                btn.anyObjct = thirdInfo.itemId;
                btn.titleLabel.font=[UIFont fontWithName:YKSkinFont_Normal size:15];
                [btn setTitleColor:YPCustomFont forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(thirdButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [infoCell.otherView addSubview:btn];
                
            }
        }
        
    }
    
    Cell.clipsToBounds = YES;
    
    return Cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat rowHeight=0;
    BOOL expand = [self isSection:indexPath.section ExpandOfTableView:tableView];
    if (expand) {

        if (indexPath.row == 0) {
            return 40;
        }else {
        
        YPFirstCategoryData *m_firstInfoData = (YPFirstCategoryData*)[m_categoryData.firstCategoryList objectAtIndex:indexPath.section];
        YPSecondCategoryData *second_data = (YPSecondCategoryData*)[m_firstInfoData.secondCategoryList objectAtIndex:secIndexItem];
        item_count = [second_data.thirdCategoryList count];
        
        if (item_count >0 && item_count <= 9) {
            rowHeight=90+10;
        }else if (item_count > 9) {
            int hangShu = (item_count-1)/3+1;
            rowHeight=30*hangShu+10;
        }else if (item_count == 0) {
            rowHeight = 80;
        }
                
        }
    }else {
        rowHeight = 0;
    }
    return rowHeight;
}

-(void)secondButtonPressed:(id)sender
{
    UIButton *button =(UIButton *)sender;
    UIView *tmpTitileView = [button superview];
    UIScrollView *scrollView = (UIScrollView*)[button superview].superview;
    
    contentOffSetX = scrollView.contentOffset.x;
    
    for (UIButton *btn in [tmpTitileView subviews]) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn != button) {
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
    
    NSInteger tmpInt = button.tag%scrollViewTagpreNum;
    secIndexItem = tmpInt;
    
    isPressedSecBtn = YES;
    
    YPFirstCategoryData *m_firstInfoData = (YPFirstCategoryData*)[m_categoryData.firstCategoryList objectAtIndex:section_Index];
    int secItem_count = m_firstInfoData.secondCategoryList.count;
    
     [table_Category reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:section_Index]] withRowAnimation:UITableViewRowAnimationNone];
    
    if (secItem_count>=5) {
        CGPoint contentOff = [scrollView contentOffset];
        if (secIndexItem < 2) {
//            rightArrowImg.hidden = NO;
            contentOffSetX = 0;
//            [scrollView setContentOffset:CGPointMake(0, 0)];
        }
        else if (secIndexItem > item_count - 2) {
            contentOffSetX = titleViewWidth*(secIndexItem - 2);
//            [scrollView setContentOffset:CGPointMake(titleViewWidth*(secIndexItem - 2), 0)];
//            rightArrowImg.hidden = YES;
        }
        else {
            if (contentOff.x > (secIndexItem - 1)*titleViewWidth) {
                contentOffSetX = titleViewWidth*(secIndexItem - 1);
//                [scrollView setContentOffset:CGPointMake(titleViewWidth*(secIndexItem - 1), 0)];
            }
            else if (contentOff.x < (secIndexItem - 2)*titleViewWidth) {
                contentOffSetX = titleViewWidth*(secIndexItem - 2);
//                [scrollView setContentOffset:CGPointMake(titleViewWidth*(secIndexItem - 2), 0)];
            }
//            rightArrowImg.hidden = NO;
        }
        
    }
    
    [UIView beginAnimations:@"Flips1" context:self];
    [UIView setAnimationDuration:0.5];
    
    [scrollView setContentOffset:CGPointMake(contentOffSetX, 0)];
    image_glass.frame = CGRectMake(button.frame.origin.x + halfImageSender, 34 , 10, 6);
    [UIView commitAnimations];

}

-(void)thirdButtonPressed:(id)sender
{
    Sun_PaoductListViewController *productListVC = [[Sun_PaoductListViewController alloc] initWithNibName:@"Sun_PaoductListViewController" bundle:nil];
    [self.navigationController pushViewController:productListVC animated:YES];
    [productListVC release];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate) {
        if (scrollView.tag==10010) {
            contentOffSetX = scrollView.contentOffset.x;
        }
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView.tag==10010) {
        contentOffSetX = scrollView.contentOffset.x;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag==10010) {
        contentOffSetX = scrollView.contentOffset.x;
    }
}

@end