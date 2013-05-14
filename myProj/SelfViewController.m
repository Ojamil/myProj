//
//  SelfViewController.m
//  myProj
//
//  Created by sky on 13-5-7.
//
//

#import "SelfViewController.h"

@interface SelfViewController ()

@end

@implementation SelfViewController
@synthesize image,name,school,hour;
@synthesize keys,datasource;

-(void)setupArray{
    //obtain the rray
    
    keys = [[NSMutableDictionary alloc]init];
    [keys setObject:@"content1" forKey:@"key1"];
    [keys setObject:@"content2" forKey:@"key2"];
    [keys setObject:@"content3" forKey:@"key3"];
    
    datasource = [keys allKeys];
    
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
    [self setupArray];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Unknown" ofType:@"jpg"];
    UIImage* myImage= [UIImage imageWithContentsOfFile:path];
    [image setImage:myImage];
    name.text = @"Seffy";
    school.text = @"SYSU";
    hour.text = @"50";
       [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setName:nil];
    [self setSchool:nil];
    [self setHour:nil];
    [self setImage:nil];
    [super viewDidUnload];
}
- (IBAction)selfDetail:(id)sender
{
    
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
    return [keys count];
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
    cell.titleLabel.text= [datasource objectAtIndex:row];
    cell.subtitleLabel.text = [keys objectForKey:cell.titleLabel.text];
    
    
    return cell;
    
    
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


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SelfActivitiesDetailsViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"SelfActivitiesDetails"];
    detail.key = [datasource objectAtIndex:indexPath.row];
    detail.content = [keys objectForKey:detail.key];
    [self.navigationController pushViewController:detail animated:YES];
    
}

@end
