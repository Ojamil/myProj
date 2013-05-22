//
//  ActivitiesViewController.m
//  myProj
//
//  Created by sky on 13-5-15.
//
//

#import "ActivitiesViewController.h"
#import "ActivitiesCellStyle.h"
#import "ActivitiesDetailsViewController.h"
#import "Networking.h"


@interface ActivitiesViewController ()


@end

@implementation ActivitiesViewController 
@synthesize data;
@synthesize tableView;
@synthesize aname,aclick,aabs;

-(void)setupArray
{
    localSQL *sql = [[localSQL alloc]init];
    data = [sql getAct];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    data = [[NSMutableArray alloc]init];
    [self setupArray];
    [super viewDidLoad];
    
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

    //NSLog(@"%@",self.navigationItem);
    self.navigationItem.title = @"广州";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    [self setupArray];
    return [data count];
    
}

//设置cell显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActivitiesCellIdentifier";
    
    UINib *nib = [UINib nibWithNibName:@"ActivitiesCellStyle" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    ActivitiesCellStyle *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSUInteger row = [indexPath row];
    NSDictionary* tmp = [data objectAtIndex:row];
    aname = [tmp objectForKey:@"aname"];
    aabs = [tmp objectForKey:@"aabs"];
    aclick = [tmp objectForKey:@"aclick"];
    
    cell.titleLabel.text= aname;
    cell.subtitleLabel.text = aabs;
    cell.clickLabel.text = aclick;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53;
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

- (IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivitiesDetailsViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivitiesDetails"];
    int row=indexPath.row;
    NSDictionary* tmp = [data objectAtIndex:row];
    
    detail.aid = [tmp objectForKey:@"aid"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //根据活动id查询该活动
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          detail.aid,@"aid",
                          nil];
    Networking *net = [[Networking alloc]initWithPhp:@"visit_activity.php" method:@"POST" parameters:dict];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:net.request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        //NSLog(@"%@",JSON);
        id js=[JSON objectForKey:@"data"];
        detail.aname = [js objectForKey:@"aname"];
        detail.aabs= [js objectForKey:@"aabs"];
        detail.aclick = [js objectForKey:@"aclick"];
        detail.maxNum = [js objectForKey:@"maxNum"];
        detail.aintro = [js objectForKey:@"aintro"];
         NSLog(@"%@",detail.aintro);
        detail.timeBegin = [js objectForKey:@"timeBegin"];
        detail.timeEnd = [js objectForKey:@"timeEnd"];
        detail.address = [js objectForKey:@"address"];
        detail.apublic = [js objectForKey:@"apublic"];
        detail.cid = [js objectForKey:@"cid"];
        detail.ajoined = [js objectForKey:@"ajoined"];
        detail.acondition = [js objectForKey:@"acondition"];
        detail.maxNum = [js objectForKey:@"maxNum"];
        detail.applyDeadline = [js objectForKey:@"applyDeadline"];
        //NSLog(@"%@",detail.aclick);
        
        localSQL *sql = [[localSQL alloc]init];
        [sql updateActID:[detail.aid intValue] ForName:detail.aname ForMaxnum:detail.maxNum ForAbs:detail.aabs ForJoined:detail.ajoined ForClick:detail.aclick];
        [self.tableView reloadData];
        [self.navigationController pushViewController:detail animated:YES];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        XYShowAlert(@"网络连接失败！");
    }];
    [operation start];
}


- (IBAction)refresh:(id)sender {
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"20",@"aid",
                          nil];
    
    Networking *net = [[Networking alloc]initWithPhp:@"visit_activity" method:@"GET" parameters:dict];
    
    [net setJsonRequestForObject:self ifSuccess:@selector(success) ifFailure:@selector(failure)];
}

-(void)success
{
     Networking *net = [[Networking alloc]initWithPhp:@"visit_activity" method:@"GET" parameters:nil];
    [net getCloudActInfoWithSelector:@selector(reloadView) by:self];
}

- (void)failure
{
    XYShowAlert(@"网络连接失败");
}

- (void)reloadView
{
    NSLog(@"reloading...");
    [self.tableView reloadData];
}

#pragma mark - Navigation Pick city 

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

- (void)viewDidUnload {
    [self setSearchField:nil];
    [super viewDidUnload];
}

@end
