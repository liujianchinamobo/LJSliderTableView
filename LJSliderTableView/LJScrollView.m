//
//  LJScrollView.m
//  自定义控件
//
//  Created by liujian on 16/4/8.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import "LJScrollView.h"
@interface LJScrollView()<UIScrollViewDelegate>
{
    NSMutableArray *tableViews;
}
@end

@implementation LJScrollView

-(instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count
{
    if (self = [super initWithFrame:frame]) {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.contentSize = CGSizeMake(self.frame.size.width * count, self.frame.size.height);
        tableViews  = [NSMutableArray arrayWithCapacity:2];
        
        [self setupTableView];
    }
    return self;
}

-(void)setupTableView
{
    
    // 初始化两个表格，用来复用
    for (int i = 0; i < 2; i ++) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        if (i == 0) {
            table.backgroundColor = [UIColor redColor];
        }else
        {
            table.backgroundColor = [UIColor blueColor];
        }
        table.delegate = self.tableViewDelegate;
        table.dataSource = self.tableViewDelegate;
        [tableViews addObject:table];
        [self addSubview:table];
        
    }
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / self.frame.size.width;
    
    [self updateTableViewWithPageIndex:pageIndex];

}

-(void)updateTableViewWithPageIndex:(NSInteger)index
{
    NSInteger arrayIndex = index % 2;
    
    CGRect frame = CGRectMake(index * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    
    UITableView *table = tableViews[arrayIndex];
    
    table.frame = frame;
    
    [table reloadData];
}
@end
