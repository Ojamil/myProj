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
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(11, 11, 298, 340)];//继续调。。。
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.navigationItem.title = @"公益新鲜事";
    
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.frame = CGRectMake(0,0,20,20);
    [leftButton setBackgroundImage:[UIImage imageNamed: @"pin.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(pickCity:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.exclusiveTouch = YES; // 保证左右按钮不会同时按下
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] init];
    rightButton.frame = CGRectMake(0,0,20,20);
    [rightButton setBackgroundImage:[UIImage imageNamed: @"refresh.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.exclusiveTouch = YES; // 保证左右按钮不会同时按下
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    //设置ScrollView的整体触摸与显示区域
    //注意 宽 高不要超过 320X480
    //否则会出现无法滚动的情况
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 298,224)];
    
    //设置ScrollView滚动内容的区域
    //它通常是需要大于ScrollerView的显示区域的
    //这样才有必要在ScrollerView中滚动它
    [_scrollView setContentSize:CGSizeMake(320 * 4, 224)];
    
    //开启滚动分页功能，如果不需要这个功能关闭即可
    [_scrollView setPagingEnabled:YES];
    
    //隐藏横向与纵向的滚动条
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    
    //在本类中代理scrollView的整体事件
    [_scrollView setDelegate:self];
  
    //这里添加图片
    self.photoList = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"1.jpg"],
                      [UIImage imageNamed:@"2.jpg"],
                      [UIImage imageNamed:@"3.jpg"],
                      [UIImage imageNamed:@"4.jpg"],
                      nil];
    
    for (int i =0; i<photoList.count; i++)
    {
        
        //在这里给每一个ScrollView添加一个图片
        UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(i *298,0,298,224)];
        [imageView setImage: [photoList objectAtIndex:i]];
        //把每页需要显示的VIEW添加进ScrollerView中
        [_scrollView addSubview:imageView];
       
    }
    
    //整体再将ScrollerView显示在窗口中
    [_tableView setTableHeaderView:_scrollView];
    
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
    [keys setObject:@"广州市越秀区学雷锋志愿服务队" forKey:@"心随我行，情奉大塘"];
    [keys setObject:@"广州市青宫社会工作服务中心" forKey:@"快乐暑期课堂"];
    [keys setObject:@"广州青年志愿者协会" forKey:@"城市主题公益徒步活动"];
    
    datasource = [keys allKeys];
    
}

- (void) setValue:(NSString *) value
{
    city=value;
    NSLog(@"this is%@",city);
    self.navigationItem.title=city;
    NSLog(@"%@",self.navigationItem);
}

- (IBAction)pickCity:(id)sender
{
    PickCityViewController *dest=[self.storyboard instantiateViewControllerWithIdentifier:@"PickCity"];
    dest.passDelegate=self;
    [self presentModalViewController:dest animated:NO];
}

- (IBAction)refresh:(id)sender {
    
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
    return 41;
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



-(void)scrollViewDidScroll:(UIScrollView*)scrollView

{
    //页面滚动时调用，设置当前页面的ID
    [_pageControl setCurrentPage:fabs(scrollView.contentOffset.x/self.tableView.frame.size.width)];
    NSLog(@"%f %f %f ",scrollView.contentOffset.x, self.view.frame.size.width, scrollView.contentOffset.x/self.view.frame.size.width);

}




@end
