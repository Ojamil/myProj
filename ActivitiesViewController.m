//
//  ActivitiesViewController.m
//  myProj
//
//  Created by sky on 13-4-29.
//
//

#import "ActivitiesViewController.h"

@interface ActivitiesViewController ()

@end

@implementation ActivitiesViewController
@synthesize keys;
@synthesize datasource;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setupArray{
    //obtain the rray
    
    keys = [[NSMutableDictionary alloc]init];
    [keys setObject:@"content1" forKey:@"key1"];
    [keys setObject:@"content2" forKey:@"key2"];
    [keys setObject:@"content3" forKey:@"key3"];
    
    datasource = [keys allKeys];
}

- (void)viewDidLoad
{
    [self setupArray];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [keys count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActivitiesCellIdentifier";
    static BOOL nibsRegistered = NO;
 
        UINib *nib = [UINib nibWithNibName:@"ActivitiesCellStyle" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    
    ActivitiesCellStyle *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSUInteger row = [indexPath row];
    cell.titleLabel.text= [datasource objectAtIndex:row];
    cell.subtitleLabel.text = [keys objectForKey:cell.titleLabel.text];
    
    
    return cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ActivitiesDetailsViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivitiesDetails"];
    detail.key = [datasource objectAtIndex:indexPath.row];
    detail.content = [keys objectForKey:detail.key];
    [self.navigationController pushViewController:detail animated:YES];

}

@end
