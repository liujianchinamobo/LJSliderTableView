//
//  LJSliderView.h
//  自定义控件
//
//  Created by liujian on 16/4/8.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  用来装多个tableView的容器
 *  和LJScrollView不同的地方是没有tableView的复用
 
 *  每个界面都实例化了一个tableView
 
 */

@class LJSliderView;
/**
 *  滑动视图回调方法
 */
@protocol LJSliderViewDelegate <NSObject>
@optional
-(void)LJSliderViewbeginScroll:(LJSliderView *)view;
-(void)LJSliderView:(LJSliderView *)view DidScrollPage:(NSInteger)page;
-(void)LJSliderView:(LJSliderView *)view tableView:(UITableView *)tableView HeaderRefreshAtPage:(NSInteger)page;
-(void)LJSliderView:(LJSliderView *)view tableView:(UITableView *)tableView FooterRefreshAtPage:(NSInteger)page;
@end

/**多表格切换视图*/
@interface LJSliderView : UIScrollView

//@property (nonatomic,strong)UITableView *tableView;

/**
 *  实例化视图容器大小
 *
 *  @param frame    容器大小 和表格大小相等
 *  @param count    包含表格数量
 *  @param delegate 代理
 *
 *  @return 容器实例
 */
-(instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count delegate:(id)delegate;
-(NSMutableArray *)datasourceArrayAtIndex:(NSInteger)index;
@end
