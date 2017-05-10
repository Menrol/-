# NewsBar
### 提供简单的接口实现今日头条效果
模仿今日头条上面的新闻栏以及下面的视图，需要传入两个参数，一个是标题的数组，一个是视图的数组，标题与相对应的视图在数组中的下标需要一致。
#### 代码示例
```objective-c
    NSArray *titleArray = [NSArray arrayWithObjects:@"热点", @"推荐", @"娱乐", @"视频", @"健康", @"国际", @"前沿技术", nil];
    
    NSMutableArray *viewArray = [NSMutableArray arrayWithCapacity:titleArray.count];
    
    for (int i = 0; i < titleArray.count; i++) {
        UIView *view = [[UIView alloc]init];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, 150, 100, 100)];
        label.text = titleArray[i];
        [view addSubview:label];
        [viewArray addObject:view];
    }
    
    WRQNewsBar *newsTabbar = [[WRQNewsBar alloc]initWithFrame:CGRectMake(0, 20, W, [UIScreen mainScreen].bounds.size.height-20) viewArray:viewArray titleArray:titleArray];
    [self.view addSubview:newsTabbar];
```
