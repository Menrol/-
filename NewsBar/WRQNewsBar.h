//
//  WRQNewsBar.h
//  今日头条工具
//
//  Created by Apple on 2017/5/9.
//  Copyright © 2017年 WRQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#define unselected 15
#define selected   17

@interface WRQNewsBar : UIView<UIScrollViewDelegate>
{
    //上半部分标题栏
    UIScrollView *_upScrollView;
    //下半部分view
    UIScrollView *_downScrollView;
    //当前button
    UIButton *_preButton;
    //frame
    CGRect _frame;
    //title数组
    NSArray *_titleArray;
    //width数组
    NSMutableArray *_widthArray;
    //contsize.width
    CGFloat _sumwidth;
}

- (instancetype)initWithFrame:(CGRect)frame
                    viewArray:(NSArray *)viewArray
                   titleArray:(NSArray *)titleArray;


@end
