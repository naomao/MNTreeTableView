//
//  TreeCell.h
//  cts
//
//  Created by MacBook on 2017/3/10.
//  Copyright © 2017年 reining. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeModel.h"
@interface TreeCell : UITableViewCell

@property(strong, nonatomic) TreeModel * treeModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
