//
//  TreeCell.m
//  cts
//
//  Created by MacBook on 2017/3/10.
//  Copyright © 2017年 reining. All rights reserved.
//

#import "TreeCell.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define MARGINEDGE 12

@interface TreeCell ()
@property(strong, nonatomic) UIView * bgView;

@property(strong, nonatomic) UIImageView * titleImage;

@property(strong, nonatomic) UILabel * titleLbl;

@property (nonatomic, strong) UIImageView *detailImage;
@end
@implementation TreeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"TreeCell";
    TreeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier ];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(MARGINEDGE, 10, kWidth - 150, 24)];
    [self.contentView addSubview:self.bgView];
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 3, 18, 18)];
    [self.bgView addSubview:self.titleImage];
    
    self.titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(28, 3, kWidth - 150 - 40, 18)];
    self.titleLbl.font = [UIFont systemFontOfSize:12];
    [self.bgView addSubview:self.titleLbl];
    
}
- (void)setTreeModel:(TreeModel *)treeModel
{
    _treeModel = treeModel;
    NSLog(@"level:%ld", treeModel.level);

    self.bgView.frame = CGRectMake(MARGINEDGE + 24*(treeModel.level - 1), 10, kWidth - 150, 24);
    switch (treeModel.level) {
        case 1:
            self.titleImage.image = [UIImage imageNamed:@"groupIcon1"];
            break;
        case 2:
            self.titleImage.image = [UIImage imageNamed:@"groupIcon2"];
            break;
        case 3:
            self.titleImage.image = [UIImage imageNamed:@"groupIcon3"];
            break;
        default:
            break;
    }
    self.titleLbl.text = treeModel.name;
    if (treeModel.subItems.count)
        self.detailImage.image = [UIImage imageNamed:@"home_btn_down"];
    else
        self.detailImage.image = [UIImage imageNamed:@""];
    
    
}
- (UIImageView *)detailImage
{
    if (_detailImage == nil) {
        _detailImage = [[UIImageView alloc] init];
        _detailImage.frame = CGRectMake(0, 0, 10, 6);
        self.accessoryView = _detailImage;
    }
    return _detailImage;
}


@end
