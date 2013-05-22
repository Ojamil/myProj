//
//  JoinUpViewController.h
//  myProj
//
//  Created by sky on 13-5-19.
//
//

#import <UIKit/UIKit.h>
@protocol JoinUpViewControllerDelegate<NSObject>

@end

@interface JoinUpViewController : UIViewController<UITextFieldDelegate>
{
    UITextView* applyReason;
}
@property (nonatomic, weak) id <JoinUpViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *anameLabel;
@property (nonatomic,retain) NSString* aname;
@property (nonatomic,retain) NSString* aid;
@property (strong, nonatomic) IBOutlet UITextView *applyReason;

- (IBAction)send:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)backgroundTap:(id)sender;
@end
