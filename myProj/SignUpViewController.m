//
//  SignUpViewController.m
//  myProj
//
//  Created by sky on 13-5-8.
//
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize email,password,password2,name;

@synthesize delegate;
@synthesize scrollview;

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
    scrollview.frame = CGRectMake(0,44,320,920);
    [scrollview setContentSize:CGSizeMake(320,920)];
    scrollview.backgroundColor=[UIColor redColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
	[self.delegate SignUpViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender
{
	[self.delegate SignUpViewControllerDidSave:self];
}

- (void)viewDidUnload {
    [self setEmail:nil];
    [self setPassword:nil];
    [self setPassword2:nil];
    [self setName:nil];
    [self setTelephone:nil];
    [self setDone:nil];
    [self setCancel:nil];
    scrollview = nil;
    scrollview = nil;
    scrollview = nil;
    [super viewDidUnload];
}
- (IBAction)testFieldDoneEditing:(id)sender {
    [self.view endEditing:YES];
    
    
}
- (IBAction)backgroundTap:(id)sender
{
   [self.view endEditing:YES];
}
@end
