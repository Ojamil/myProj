//
//  SelfDetailsViewController.m
//  myProj
//
//  Created by sky on 13-5-14.
//
//

#import "SelfDetailsViewController.h"
#import "localSQL.h"
@interface SelfDetailsViewController ()

@end

@implementation SelfDetailsViewController

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
    
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.frame = CGRectMake(0,0,20,20);
    [leftButton setBackgroundImage:[UIImage imageNamed: @"back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    NSDictionary *userInfo = [localSQL getLocalUserInfo];
    self.name.text = [userInfo objectForKey:@"uname"];
    self.apublic.text = [userInfo objectForKey:@"public"];
    self.gender.text = [userInfo objectForKey:@"gender"];
    self.birthdate.text = [userInfo objectForKey:@"birthdate"];
    self.mob.text = [userInfo objectForKey:@"mob"];
    self.email.text = [userInfo objectForKey:@"email"];
    
    
    
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
    [self setApublic:nil];
    [self setGender:nil];
    [self setBirthdate:nil];
    [self setMob:nil];
    [self setEmail:nil];
    [super viewDidUnload];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
