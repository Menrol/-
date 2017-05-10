//
//  WRQNewsBar.m
//  今日头条工具
//
//  Created by Apple on 2017/5/9.
//  Copyright © 2017年 WRQ. All rights reserved.
//

#import "WRQNewsBar.h"
#define W self.bounds.size.width
#define H self.bounds.size.height


@implementation WRQNewsBar


-(instancetype)initWithFrame:(CGRect)frame viewArray:(NSArray *)viewArray titleArray:(NSArray *)titleArray{
    self = [super initWithFrame:frame];
    if (self) {
        _sumwidth = 0;
        
        _titleArray = titleArray;
        
        [self calculateWidth];
        
        [self initupScrollView];
        
        [self initdownScrollView];
        
        [self initdownViewWithViews:viewArray];
        
    }
    return self;
}

#pragma mark - 计算宽度
- (void)calculateWidth{
    _widthArray = [NSMutableArray arrayWithCapacity:_titleArray.count];
    for (int i = 0; i < _titleArray.count; i++) {
        float titlewidth = [_titleArray[i] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:unselected]}].width;
        _sumwidth += titlewidth+W*0.05;
        NSNumber *value = [NSNumber numberWithFloat:titlewidth];
        [_widthArray addObject:value];
    }
}

#pragma mark - 上部分scrollView
- (void)initupScrollView{
    UIScrollView *upscollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(W*0.05, 0, W*0.9, H)];
    upscollerView.showsHorizontalScrollIndicator = NO;
    upscollerView.contentSize = CGSizeMake(_sumwidth, 44);
    [self addSubview:upscollerView];
    _upScrollView = upscollerView;
}

#pragma mark - 下部分scrollView
- (void)initdownScrollView{
    UIScrollView *downscollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, W, H-44)];
    downscollerView.showsHorizontalScrollIndicator = NO;
    downscollerView.contentSize = CGSizeMake(W*_titleArray.count, H-44);
    downscollerView.delegate = self;
    downscollerView.pagingEnabled = YES;
    [self addSubview:downscollerView];
    _downScrollView = downscollerView;
}

#pragma mark - 创建View和title按钮
- (void)initdownViewWithViews:(NSArray *)viewArray{
    float prewidth = 0;
    for (int i = 0; i < _titleArray.count; i++) {
        //添加button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pressWithButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:unselected];
        float titlewidth = [_widthArray[i] floatValue];
        NSLog(@"t = %f",titlewidth);
        btn.frame = CGRectMake(prewidth, 5, titlewidth + W * 0.05, 34);
        prewidth += (titlewidth + W * 0.05);
        NSLog(@"p = %f",prewidth);
        [_upScrollView addSubview:btn];
        if (i == 0) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:selected];
            _preButton = btn;
        }
        
        //添加View
        UIView * view = (UIView *)viewArray[i];
        view.frame = CGRectMake(i*W, 0, W, [UIScreen mainScreen].bounds.size.height-44);
        [_downScrollView addSubview:view];
    }
}

#pragma mark - action
- (void)pressWithButton:(UIButton *)btn{
    //button居中显示
    if (_preButton != btn) {
        if (btn.center.x > W*0.9*0.5) {
            [_upScrollView setContentOffset:CGPointMake(btn.center.x - W*0.9*0.5, 0) animated:YES];
        }
        if (btn.center.x < W*0.9*0.5 && _upScrollView.contentOffset.x!=0) {
            [_upScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
        //设置button选择状态
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:selected];
        [_preButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _preButton.titleLabel.font = [UIFont systemFontOfSize:unselected];
        [_downScrollView setContentOffset:CGPointMake((btn.tag-100)*W, 0) animated:NO];
        _preButton = btn;
    }
}

#pragma mark - scollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取当前是哪个button
    UIButton *btn = (UIButton *)[_upScrollView viewWithTag:(int)(scrollView.contentOffset.x/W+100)];
    
    //设置button居中显示
    if (_preButton != btn) {
        if (btn.center.x > W*0.9*0.5) {
            [_upScrollView setContentOffset:CGPointMake(btn.center.x - W*0.9*0.5, 0) animated:YES];
        }
        if (btn.center.x < W*0.9*0.5 && _upScrollView.contentOffset.x!=0) {
            [_upScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
        //设置button选中
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:selected];
        [_preButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _preButton.titleLabel.font = [UIFont systemFontOfSize:unselected];
        _preButton = btn;
    }
    
}

@end
