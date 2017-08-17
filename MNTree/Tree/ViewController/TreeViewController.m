//
//  ViewController.m
//  Tree
//
//  Created by 毛闹 on 2017/3/8.
//  Copyright © 2017年 毛闹. All rights reserved.
//

#import "TreeViewController.h"
#import "TreeModel.h"
#import "TreeCell.h"

@interface TreeViewController ()
@property(strong, nonatomic) NSMutableArray * mDatas;


@end

@implementation TreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    self.tableView.tableFooterView = [[UIView alloc]init];
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mDatas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TreeCell * cell = [TreeCell cellWithTableView:tableView];
    TreeModel * tree = self.mDatas[indexPath.row];
    cell.treeModel = tree;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TreeModel * tree = self.mDatas[indexPath.row];
#pragma mark - 展开
    if (tree.subItems.count && !tree.show) {
        //先改变点击行数据源
        tree.show = YES;
        [self.mDatas replaceObjectAtIndex:indexPath.row withObject:tree];
        //再添加新数据并展开
        NSArray *subTrees = tree.subItems;
        NSMutableArray * mIndexPaths = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < subTrees.count; i ++) {
            [self.mDatas insertObject:subTrees[i] atIndex:indexPath.row + i + 1];
            NSIndexPath * indexPathItem = [NSIndexPath indexPathForRow:indexPath.row + i + 1 inSection:0];
            [mIndexPaths addObject:indexPathItem];
        }
        
        [self.tableView insertRowsAtIndexPaths:mIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
        return;
    }
    
#pragma mark - 关闭
    if (tree.subItems.count && tree.show) {
        //先改变点击行数据源
        tree.show = NO;
        [self.mDatas replaceObjectAtIndex:indexPath.row withObject:tree];
        //再递归移除子数据
        NSMutableArray * mIndexPaths = [NSMutableArray arrayWithCapacity:0];
        NSArray * subTrees = tree.subItems;
        NSInteger index = 1;//记录移除了哪些数据
        
        for (NSInteger i = 0; i < subTrees.count; i ++) {
            TreeModel *subTree = subTrees[i];
            //先移外层
            [self.mDatas removeObject:subTree];
            NSIndexPath * indexPath0 = [NSIndexPath indexPathForRow:indexPath.row + index inSection:0];
            [mIndexPaths addObject:indexPath0];
            index ++;//每成功移除一个 都要记录
            //再移内层
            NSArray *subSubTrees = subTree.subItems;
            if (subSubTrees.count && subTree.show) {
                
                //把当前层所有的子数据都成功移除后，不要忘了重置这一层的数据
                subTree.show = NO;
                [tree.subItems replaceObjectAtIndex:i withObject:subTree];
                
                for (NSInteger j = 0; j < subSubTrees.count ; j ++) {
                    TreeModel * subSubTree = subSubTrees[j];
                    
                    [self.mDatas removeObject:subSubTree];
                    
                    NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:indexPath.row + index inSection:0];
                    [mIndexPaths addObject:indexPath1];
                    index ++;
                }
            }
        }
        [self.tableView deleteRowsAtIndexPaths:mIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
        return;
    }
    
    if (!tree.subItems.count) {
        // 获取点击数据处理
        NSLog(@"点击行的ID：%@",tree.ID);
    }
}
#pragma mark = private method
- (void)prepareData
{
    TreeModel * model_1_1_1 = [[TreeModel alloc]init];
    model_1_1_1.level = 3;
//    model_1_1_1.parentModel = model_1_1;
    model_1_1_1.subItems = [NSMutableArray array];
    model_1_1_1.name = @"三级1";
    model_1_1_1.ID = @"321";
    
    TreeModel * model_1_2 = [[TreeModel alloc]init];
    model_1_2.level = 2;
//    model_1_2.parentModel = nil;
    model_1_2.subItems = [NSMutableArray array];
    model_1_2.name = @"二级2";
    model_1_2.ID = @"22";
    
    
    TreeModel * model_1_1 = [[TreeModel alloc]init];
    model_1_1.level = 2;
//    model_1_1.parentModel = nil;
    model_1_1.subItems = [NSMutableArray arrayWithObjects: model_1_1_1,nil];
    model_1_1.name = @"二级1";
    model_1_1.ID = @"21";

    TreeModel * model_1 = [[TreeModel alloc]init];
    model_1.level = 1;
//    model_1.parentModel = nil;
    model_1.subItems = [NSMutableArray arrayWithObjects:model_1_1, model_1_2 ,nil];
    model_1.name = @"一级1";
    model_1.ID = @"1";
    
    TreeModel * model_2 = [[TreeModel alloc]init];
    model_2.level = 1;
//    model_2.parentModel = nil;
    model_2.subItems = [NSMutableArray array];
    model_2.name = @"一级2";
    model_2.ID = @"2";
    
    TreeModel * model_3 = [[TreeModel alloc]init];
    model_3.level = 1;
    //    model_2.parentModel = nil;
    model_3.selected = YES;
    model_3.subItems = [NSMutableArray array];
    model_3.name = @"全部";
    model_3.ID = @"3";

    NSArray * array = @[model_3, model_1, model_2];
    self.mDatas = [NSMutableArray arrayWithArray:array];
}
#pragma mark - setters && getters
- (NSMutableArray *)mDatas
{
    if (!_mDatas) {
        _mDatas = [NSMutableArray arrayWithCapacity:0];
    }
    return _mDatas;
}
@end
