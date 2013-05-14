//
//  LoginPageViewController.m
//  myProj
//
//  Created by sky on 13-5-8.
//
//

#import "LoginPageViewController.h"

@interface LoginPageViewController ()

@end

@implementation LoginPageViewController
@synthesize tabController;


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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEmail:nil];
    [self setPassword:nil];
    [super viewDidUnload];
}



#pragma mark - SignUpViewControllerDelegate

- (void)SignUpViewControllerDidCancel:
(SignUpViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)SignUpViewControllerDidSave:
(SignUpViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"SignUp"])
	{
        SignUpViewController *SignUpViewController = segue.destinationViewController;
        SignUpViewController.delegate = self;
	}
    else if([segue.identifier isEqualToString:@"Login"])
	{
        
        MainTabBarViewController *MainTabBarViewController = segue.destinationViewController;
        MainTabBarViewController.delegate = self;
       
    }
   
}

@end
