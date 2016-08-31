//
//  LJSliderView.m
//  自定义控件
//
//  Created by liujian on 16/4/8.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import "LJSliderView.h"
#import "MJRefresh.h"
#import "LJSliderTableView.h"

@interface LJSliderView()<UIScrollViewDelegate>
{
    NSMutableArray *pageIndex;
    NSInteger _count;
    id _delegate;
}
@end

@implementation LJSliderView

-(instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count delegate:(id)delegate
{
    if (self = [super initWithFrame:frame]) {
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.contentSize = CGSizeMake(self.frame.size.width * count, self.frame.size.height);
        pageIndex = [NSMutableArray arrayWithCapacity:count];
        _count = count;
        _delegate = delegate;
        [self setupTableViewWithPage:0];
    }
    
    return self;
}

/**通过 setContentOffset animation 来移动*/
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / self.frame.size.width;
    
    [self setupTableViewWithPage:page];
    if (_delegate && [_delegate respondsToSelector:@selector(LJSliderView:DidScrollPage:)]) {
        [_delegate LJSliderView:self DidScrollPage:page];
    }
    
    
}

/**通过手指滑动来移动*/
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / self.frame.size.width;
    
     [self setupTableViewWithPage:page];
    if (_delegate && [_delegate respondsToSelector:@selector(LJSliderView:DidScrollPage:)]) {
        [_delegate LJSliderView:self DidScrollPage:page];
    }
    
   
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(LJSliderViewbeginScroll:)]) {
        [_delegate LJSliderViewbeginScroll:self];
    }
}

-(NSMutableArray *)datasourceArrayAtIndex:(NSInteger)index
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[LJSliderTableView class]] && view.tag == index) {
            LJSliderTableView * table = (LJSliderTableView *)view;
            return table.dataSourceArray;
        }
    }
    return nil;
}

/**根据位置创建表格*/
-(void)setupTableViewWithPage:(NSInteger)page
{
    // 判断当前位置是否已经存在tableView，不存在则创建
    if (![pageIndex containsObject:@(page)]) {
        
        LJSliderTableView *tableView = [[LJSliderTableView alloc] initWithFrame:CGRectMake(self.frame.size.width * page, 0, self.frame.size.width, self.frame.size.height)];
 
        tableView.delegate = _delegate;
        tableView.dataSource = _delegate;
        tableView.estimatedRowHeight = 100;
        tableView.tag = page;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.dataSourceArray = [NSMutableArray array];
        
        // 添加下拉上拉控件
        MJNormalGifHeader *header = [MJNormalGifHeader headerWithRefreshingBlock:^{
            if ([_delegate respondsToSelector:@selector(LJSliderView:tableView:HeaderRefreshAtPage:)]) {
                [_delegate LJSliderView:self tableView:tableView HeaderRefreshAtPage:tableView.tag];
            }
        }];
        tableView.mj_header = header;
        
        // 排行榜页面不添加上拉加载更多功能
        if (![_delegate isKindOfClass:NSClassFromString(@"RankViewController")]) {
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                if ([_delegate respondsToSelector:@selector(LJSliderView:tableView:FooterRefreshAtPage:)]) {
                    [_delegate LJSliderView:self tableView:tableView FooterRefreshAtPage:tableView.tag];
                }
            }];

            tableView.mj_footer = footer;
        }
        
        [pageIndex addObject:@(page)];
        [self addSubview:tableView];
    }
    
}

@end
