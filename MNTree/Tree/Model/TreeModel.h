//
//  TreeModel.h
//  Tree
//
//  Created by 毛闹 on 2017/3/8.
//  Copyright © 2017年 毛闹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeModel : NSObject

/**
 处于哪一层
 */
@property (nonatomic) NSInteger level;

/**
 子Model
 */
@property (nonatomic, strong) NSMutableArray *subItems;

@property (copy, nonatomic) NSString * name;

@property (copy, nonatomic) NSString *ID;

/**
 展开折叠 默认NO 折叠
 */
@property(nonatomic) BOOL show;


/**
 是否被选中  只有没有subItems的时候才能被选中
 */
@property(nonatomic) BOOL selected;

//@property(strong, nonatomic) TreeModel * parentModel;
@end
