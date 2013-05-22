//
//  PickCityViewController.m
//  myProj
//
//  Created by sky on 13-5-16.
//
//

#import "PickCityViewController.h"
#import "ActivitiesViewController.h"

@interface PickCityViewController ()

@end

@implementation PickCityViewController
@synthesize keys;
@synthesize city;
@synthesize passDelegate;

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
    [super viewDidLoad];
    
    [[self view]setBackgroundColor:[UIColor blackColor]];
	// Do any additional setup after loading the view.
}

-(void)setupArray{
    //obtain the rray
    
    keys = [NSArray alloc];
    keys = [NSArray arrayWithObjects:@"广州", @"上海", @"北京",nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PickOk:(id)sender {
    [self.passDelegate setValue:city];

    [self dismissModalViewControllerAnimated:NO];
    
}

- (IBAction)back:(id)sender {
 
    [self dismissModalViewControllerAnimated:YES];
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
    static NSString *CellIdentifier = @"City";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    cellLabel.text = [keys objectAtIndex:indexPath.row];
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


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    city=[keys objectAtIndex:indexPath.row];
    NSLog(@"%@",city);
    
}


- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

@end
