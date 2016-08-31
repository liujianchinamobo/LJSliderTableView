//
//  LJScrollView.h
//  自定义控件
//
//  Created by liujian on 16/4/8.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>


/**用来装多个tableView的容器
 
 里面用到了两个tableView来循环复用
 
 好处是可以节省内存
 
 坏处是显示效果不连续，并且每次都要刷新表格，即使是旧的表格
 
 
 */

@interface LJScrollView : UIScrollView

@property (nonatomic, weak) id tableViewDelegate;
-(instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count;
@end
