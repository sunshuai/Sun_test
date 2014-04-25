//
//  YPCategory.h
//  YouPin
//
//  Created by chenjie on 12-8-9.
//  Copyright (c) 2012年 yek.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sun_DataBase.h"
@interface YPCategoryData : Sun_RetDataBase
@property(nonatomic,readonly)NSArray* firstCategoryList;
@end

@interface YPCategoryInfoData : Sun_DataBase 
@property(nonatomic,readonly)NSString* itemId;
@property(nonatomic,readonly)NSString* name;
@property(nonatomic,readonly)NSString* imgUrl;
@end

@interface YPFirstCategoryData : YPCategoryInfoData 
@property(nonatomic,readonly)NSArray* secondCategoryList;
@end

@interface YPSecondCategoryData : YPCategoryInfoData 
@property(nonatomic,readonly)NSArray* thirdCategoryList;
@end
@interface YPThirdCategoryData : YPCategoryInfoData

@end