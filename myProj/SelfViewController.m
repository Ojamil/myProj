//
//  SelfViewController.m
//  myProj
//
//  Created by sky on 13-5-7.
//
//

#import "SelfViewController.h"
#import "SelfDetailsViewController.h"
#import "Networking.h"
#import "Photo.h"

@interface SelfViewController ()

@end

@implementation SelfViewController
@synthesize imageView,nameLabel,schoolLabel,hourLabel;
@synthesize each,data;
@synthesize tableView;


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
    [super viewDidLoad];
    
    UIButton *rightButton = [[UIButton alloc] init];
    rightButton.frame = CGRectMake(0,0,20,20);
    [rightButton setBackgroundImage:[UIImage imageNamed: @"out.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(LogOut:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ali" ofType:@"png"];
    UIImage* myImage= [UIImage imageWithContentsOfFile:path];
    [self.imageView setImage:myImage];
    
    
    NSDictionary *user_dict = [localSQL getLocalUserInfo];
    self.nameLabel.text = [user_dict objectForKey:@"uname"];
    UIImage *image =  [Photo string2Image:[user_dict objectForKey:@"photo"]];
    [self.imageView setImage:image];
    
    //获取已参加活动
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[user_dict objectForKey:@"uid"],@"uid",nil];//自己设计
    Networking *net = [[Networking alloc]initWithPhp:@"get_joined_activity.php" method:@"POST" parameters:dict];
    [net setJsonRequestForObject:self ifSuccess:@selector(success:) ifFailure:@selector(failure)];
   
    //获取公益时间
    Networking *net1 = [[Networking alloc]initWithPhp:@"get_time.php" method:@"POST" parameters:dict];
    [net1 setJsonRequestForObject:self ifSuccess:@selector(getTimeSuccess:) ifFailure:@selector(failure)];
}

- (void)getTimeSuccess:(id)JSON
{
    self.hourLabel.text = [JSON objectForKey:@"time"];
}



- (void)success:(id)JSON
{
    data=[[NSMutableArray alloc]init];
    
    NSArray* arr=[JSON allKeys];
    
    for(int i=0;i<[JSON count];i++)
    {
        NSDictionary* tmp = [JSON objectForKey:[arr objectAtIndex:i]];
        
        [data addObject:tmp];
    }
    [tableView reloadData];
    tableView.delegate = self;
    tableView.dataSource = self;
}

- (void) failure
{
    XYShowAlert(@"网络连接失败！");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {

    [self setTableView:nil];
    [super viewDidUnload];
}

- (IBAction)LogOut:(id)sender
{
    UIActionSheet *actionSheet =
    [[UIActionSheet alloc] initWithTitle:@"你确定退出吗?"
                           delegate:self
                           cancelButtonTitle:@"取消"
                           destructiveButtonTitle:@"确定"
                           otherButtonTitles:nil];
    [actionSheet showInView:self.view];
    
}



- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        [localSQL deleteLocalUserInfo];
         UIStoryboard *board = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *next = [board instantiateViewControllerWithIdentifier:@"LoginPage"];
        
        [self presentModalViewController:next animated:YES];
    }
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
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SelfActivitiesCellIdentifier";
    static BOOL nibsRegistered = NO;
    

        UINib *nib = [UINib nibWithNibName:@"SelfActivitiesCellStyle" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    
    SelfActivitiesCellStyle *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSUInteger row = [indexPath row];
    NSDictionary* tmp=[data objectAtIndex:row];
    cell.titleLabel.text= [tmp objectForKey:@"aname"];
    cell.subtitleLabel.text = [tmp objectForKey:@"abbs"];
    cell.clickLabel.text = [tmp objectForKey:@"aclick"];
    NSLog(@"tmp=%@",tmp);
    return cell;
    
    
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SelfActivitiesDetailsViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SelfActivitiesDetails"];
    NSDictionary *tmp=[data objectAtIndex:indexPath.row];
    detail.key = [tmp objectForKey:@"aname"];
    detail.content = [tmp objectForKey:@"aabs"];
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41;
}

- (IBAction)SelfDetail:(id)sender
{
    SelfDetailsViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"selfDetails"];
    NSDictionary *mine = [localSQL getLocalUserInfo];
    detail.name.text = [mine objectForKey:@"uname"];
    detail.birthdate.text = [mine objectForKey:@"birthdate"];
   // detail.city.text = [mine objectForKey:@"city"];
    detail.email.text = [mine objectForKey:@"email"];
  //detail.

    [self.navigationController pushViewController:detail animated:YES];
}

@end
