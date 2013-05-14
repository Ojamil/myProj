//
//  ViewController.m
//  StoryboardTutorial-UITableViews1
//
//  Created by xxd on 12-3-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDetailsViewController.h"
#import "NewsCellStyle.h"
@interface NewsViewController ()
- (void)loadVisiblePage;
@end

@implementation NewsViewController
@synthesize photoList;
@synthesize keys;
@synthesize datasource;
@synthesize _scrollView,_pageControl;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self setupArray];
    [super viewDidLoad];
    
    //设置ScrollView的整体触摸与显示区域
    //注意 宽 高不要超过 320X480
    //否则会出现无法滚动的情况
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320,189)];
    
    //设置ScrollView滚动内容的区域
    //它通常是需要大于ScrollerView的显示区域的
    //这样才有必要在ScrollerView中滚动它
    [_scrollView setContentSize:CGSizeMake(320 * 4, 189)];
    
    //开启滚动分页功能，如果不需要这个功能关闭即可
    [_scrollView setPagingEnabled:YES];
    
    //隐藏横向与纵向的滚动条
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    
    //在本类中代理scrollView的整体事件
    [_scrollView setDelegate:self];
  
    //这里添加图片
    self.photoList = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"Unknown.jpg"],
                      [UIImage imageNamed:@"1.jpg"],
                      [UIImage imageNamed:@"Unknown.jpg"],
                      [UIImage imageNamed:@"1.jpg"],
                      nil];
    
    for (int i =0; i<photoList.count; i++)
    {
        
        //在这里给每一个ScrollView添加一个图片
        UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(i * 320,0,320,189)];
        [imageView setImage: [photoList objectAtIndex:i]];
        //把每页需要显示的VIEW添加进ScrollerView中
        [_scrollView addSubview:imageView];
       
    }
    
    //整体再将ScrollerView显示在窗口中
    [self.view addSubview:_scrollView];
    
    //页面控制小工具
    //它会在底部绘制小圆点标志当前显示页面
    self._pageControl.currentPage=0;
    //设置页面的数量
    [_pageControl setNumberOfPages:photoList.count];
    //监听页面是否发生改变
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)setupArray{
    //obtain the rray
    
    keys = [[NSMutableDictionary alloc]init];
    [keys setObject:@"content1" forKey:@"key1"];
    [keys setObject:@"content2" forKey:@"key2"];
    [keys setObject:@"content3" forKey:@"key3"];
    
    datasource = [keys allKeys];
    
}

#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [keys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCellIdentifier";
    static BOOL nibsRegistered = NO;

        UINib *nib = [UINib nibWithNibName:@"NewsCellStyle" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    
    
        NewsCellStyle *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        NSUInteger row = [indexPath row];
        cell.titleLabel.text= [datasource objectAtIndex:row];
        cell.subtitleLabel.text = [keys objectForKey:cell.titleLabel.text];
    
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsDetailsViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsDetails"];
    detail.key = [datasource objectAtIndex:indexPath.row];
    detail.content = [keys objectForKey:detail.key];
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - scroll view page control
- (void)changePage:(id)sender
{
    NSInteger page = [sender currentPage];
    self._pageControl.currentPage=page;
}


//手指离开屏幕后ScrollView还会继续滚动一段时间只到停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSLog(@"结束滚动后缓冲滚动彻底结束时调用");
}

-(void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
    NSLog(@"结束滚动后开始缓冲滚动时调用");
}

-(void)scrollViewDidScroll:(UIScrollView*)scrollView

{
    //页面滚动时调用，设置当前页面的ID
    [_pageControl setCurrentPage:fabs(scrollView.contentOffset.x/self.view.frame.size.width)];
    NSLog(@"视图滚动中X轴坐标%f",scrollView.contentOffset.x);
    NSLog(@"视图滚动中X轴坐标%f",scrollView.contentOffset.y);
}

-(void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    NSLog(@"滚动视图开始滚动，它只调用一次");
}

-(void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"滚动视图结束滚动，它只调用一次");
    
}




@end
