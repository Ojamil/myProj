//
//  SignUpViewController.h
//  myProj
//
//  Created by sky on 13-5-8.
//
//

#import <UIKit/UIKit.h>
#import "SignUpSuccessViewController.h"
#import "Networking.h"
#import <QuartzCore/QuartzCore.h>
#import "Photo.h"

@class SignUpViewController;

@protocol SignUpViewControllerDelegate <NSObject>

- (void)SignUpViewControllerDidCancel:
(SignUpViewController *)controller;
- (void)SignUpViewControllerDidSave:
(SignUpViewController *)controller;
@end

@interface SignUpViewController : UIViewController<UIScrollViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
   
    IBOutlet UIScrollView *myscrollview;
    UITextField *activeField;
}
@property(nonatomic,retain) UIScrollView *myscrollview;
- (IBAction)testFieldDoneEditing:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *password2;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *telephone;
@property (strong, nonatomic) IBOutlet UITextField *gender;
@property (strong, nonatomic) IBOutlet UITextField *school;
@property (strong, nonatomic) IBOutlet UITextField *birthdate;
@property (strong, nonatomic) IBOutlet UITextField *intro;

@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *qq;
@property (strong,nonatomic) IBOutlet UIImageView *photoView;
@property (strong,nonatomic) IBOutlet UIImage *photo;

@property (nonatomic, weak) id <SignUpViewControllerDelegate> delegate;



- (IBAction)backgroundTap:(id)sender;
- (IBAction)send:(id)sender;
- (IBAction)back:(id)sender;

- (IBAction)uploadPhoto:(id)sender;


@end