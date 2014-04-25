//
//  Sun_CategoryViewController.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-6.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "Sun_CategoryViewController.h"
#import "Sun_PaoductListViewController.h"
#import "HJImageUtility.h"
#import "CategoryListCell.h"
#import "JSON.h"



#define         titleViewWidth          70
#define         scrollViewTagpreNum     70000

@interface Sun_CategoryViewController (Private)

-(void)secondButtonPressed:(id)sender;
-(void)thirdButtonPressed:(id)sender;

@end

@implementation Sun_CategoryViewController

@synthesize table_Category;
@synthesize m_categoryData;
@synthesize mIndexDic;

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
    
    // 初始化每一个tableview的所有分区的开关状态字典
    [mIndexDic setObject:[NSMutableSet set] forKey:[NSNumber numberWithInt:table_Category.tag]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    NSMutableSet *expandedSectionsSet = [mIndexDic objectForKey:[NSNumber numberWithInt:table_Category.tag]];
    for (NSNumber *ind in [expandedSectionsSet allObjects]) {
        int number = [ind intValue];
        if (number != sectionIndex) {
            [self setSection:number tableView:table_Category expand:NO];
            [table_Category reloadSections:[NSIndexSet indexSetWithIndex:number] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
    
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
    
    [table_Category reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
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
    
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 43)] autorelease];
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
		bgview.frame = CGRectMake(0, 0, 320, 43);
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
    BOOL expand = [self isSection:section ExpandOfTableView:tableView];
    
    if (expand ) {
       YPFirstCategoryData *m_firstInfoData = (YPFirstCategoryData*)[m_categoryData.firstCategoryList objectAtIndex:section];
        YPSecondCategoryData *second_data = (YPSecondCategoryData*)[m_firstInfoData.secondCategoryList objectAtIndex:secIndexItem];
        item_count = [second_data.thirdCategoryList count];
        if (item_count>0) {
            NSLog(@"＊＊＊＊＊＊＊＊＊＊一共有多少行 === %d",((item_count-1)/3+1)+1);
            return ((item_count-1)/3+1)+1; 
        }else {
            return 1;
        }
    }
    else {
        return 0;
    }
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
        
        [secViewCell.m_scrollView setContentOffset:CGPointMake(contentOffSetX, 0)];
        
         YPFirstCategoryData *firstCategarydata = (YPFirstCategoryData *)[m_categoryData.firstCategoryList objectAtIndex:indexPath.section];
        
        secViewCell.m_scrollView.bounces = YES;
        secViewCell.m_scrollView.contentSize  = CGSizeMake(titleViewWidth * firstCategarydata.secondCategoryList.count, 40);
        
        if (![secViewCell.m_titleView.subviews count] && firstCategarydata.secondCategoryList.count >0) {
            
            secViewCell.m_titleView.frame = CGRectMake(0, 0, titleViewWidth * firstCategarydata.secondCategoryList.count, 40);
            
            for (NSInteger i = 0; i < firstCategarydata.secondCategoryList.count; i++) {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = scrollViewTagpreNum + i;
                button.frame = CGRectMake(0 + i* titleViewWidth, 0, titleViewWidth, 40);

                YPSecondCategoryData *secondCategary = (YPSecondCategoryData*)[firstCategarydata.secondCategoryList objectAtIndex:i];
                    
                button.titleLabel.font = [UIFont systemFontOfSize:16];
                [button setTitle:[NSString stringWithFormat:@"%@",secondCategary.name] forState:UIControlStateNormal];
                button.titleLabel.font=[UIFont fontWithName:YKSkinFont_Normal size:17];
                [button setTitleColor:YPCustomFont forState:UIControlStateNormal];
                
                if (i==secIndexItem) {
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                }
                
                [button addTarget:self action:@selector(secondButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [secViewCell.m_titleView addSubview:button];
            }
        }
    }else if (indexPath.row > 0) {
        
        NSLog(@"====== indexPath.row === %d",indexPath.row);
        
        if (Cell == nil) {
            Cell.selectionStyle = UITableViewCellSelectionStyleNone;
            Cell = [[[NSBundle mainBundle] loadNibNamed:@"CategoryListCell" owner:self options:nil] objectAtIndex:2];
        }
        YPFirstCategoryData *firstCategary = (YPFirstCategoryData *)[m_categoryData.firstCategoryList objectAtIndex:indexPath.section];
        
        int row = indexPath.row-1;
        ThirdCategoryCell* infoCell = (ThirdCategoryCell*)Cell;
        YPSecondCategoryData *m_secondCategory = (YPSecondCategoryData*)[firstCategary.secondCategoryList objectAtIndex:secIndexItem];
        
        NSLog(@"第三极是图的 数量 === %d ====== row = %d indexPath.row = %d",m_secondCategory.thirdCategoryList.count,row,indexPath.row);
        
        if (m_secondCategory.thirdCategoryList.count > 0) {
            
            for (int i = 0; i <3; i++) {
                if (3*row+i< [m_secondCategory.thirdCategoryList count]) {
                    YPThirdCategoryData *thirdInfo = (YPThirdCategoryData*)[m_secondCategory.thirdCategoryList objectAtIndex:3*row + i];
                    if (i == 0) {
                        infoCell.leftButton.hidden = NO;
                        infoCell.leftButton.anyObjct = thirdInfo;
                        [infoCell.leftButton setTitle:thirdInfo.name forState:UIControlStateNormal];
                        [infoCell.leftButton addTarget:self action:@selector(thirdButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }else if (i==1) {
                        infoCell.middleButton.hidden = NO;
                        infoCell.middleButton.anyObjct = thirdInfo;
                        [infoCell.middleButton setTitle:thirdInfo.name forState:UIControlStateNormal];
                        [infoCell.middleButton addTarget:self action:@selector(thirdButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }else if (i==2) {
                        infoCell.rihgtButton.hidden = NO;
                        infoCell.rihgtButton.anyObjct = thirdInfo;
                        [infoCell.rihgtButton setTitle:thirdInfo.name forState:UIControlStateNormal];
                        [infoCell.rihgtButton addTarget:self action:@selector(thirdButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }
                }
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
            rowHeight = 30;
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
    
//    CGPoint contentOff = [scrollView contentOffset];
//    [UIView beginAnimations:@"Flips1" context:self];
//    [UIView setAnimationDuration:0.5];
//    if (item_count>=5) {
//        
//        
//        if (secIndexItem < 2) {
////            rightArrowImg.hidden = NO;
//            contentOffSetX = 0;
//            [scrollView setContentOffset:CGPointMake(contentOffSetX, 0)];
//        }
//        else if (secIndexItem > secIndexItem - 2) {
//            contentOffSetX = titleViewWidth*(secIndexItem - 3);
//            [scrollView setContentOffset:CGPointMake(contentOffSetX, 0)];
////            rightArrowImg.hidden = YES;
//        }
//        else {
//            if (contentOff.x > (secIndexItem - 1)*titleViewWidth) {
//                contentOffSetX = titleViewWidth*(secIndexItem - 1);
//                [scrollView setContentOffset:CGPointMake(contentOffSetX, 0)];
//            }
//            else if (contentOff.x < (secIndexItem - 2)*titleViewWidth) {
//                contentOffSetX = titleViewWidth*(secIndexItem - 2);
//                [scrollView setContentOffset:CGPointMake(contentOffSetX, 0)];
//            }
////            rightArrowImg.hidden = NO;
//        }
//        
//    }
//    [scrollView setContentOffset:CGPointMake(contentOffSetX, 0)];
//    image_glass.frame = CGRectMake(button.frame.origin.x + halfImageSender, 34 , 10, 6);
//    [UIView commitAnimations];
    
//    YPFirstCategoryData *firstCategary = (YPFirstCategoryData *)[m_categoryData.firstCategoryList objectAtIndex:section_Index];
//    YPSecondCategoryData *m_secondCategory = (YPSecondCategoryData*)[firstCategary.secondCategoryList objectAtIndex:secIndexItem];
//    int secondCount = m_secondCategory.thirdCategoryList.count;
//    
//    int rowNumber = ((secondCount-1)/3+1)+1;
//    
//    for (int m=1; m<=rowNumber; m++) {
//        [table_Category deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:m inSection:section_Index]] withRowAnimation:UITableViewRowAnimationFade]; 
//    }
    [table_Category reloadSections:[NSIndexSet indexSetWithIndex:section_Index] withRowAnimation:UITableViewRowAnimationNone];
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
