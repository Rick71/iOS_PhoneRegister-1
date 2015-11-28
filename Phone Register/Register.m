//
//  ViewController.m
//  Phone Register
//
//  Created by Walter Gonzalez Domenzain on 27/11/15.
//  Copyright © 2015 Smartplace. All rights reserved.
//

#import "Register.h"
#import <DigitsKit/DigitsKit.h>

@interface Register ()

@end

@implementation Register

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DGTAuthenticateButton *authButton;
    authButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
        if (session.userID) {
            // TODO: associate the session userID with your user model
            NSString *msg = [NSString stringWithFormat:@"Phone number: %@", session.phoneNumber];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You are logged in!"
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        } else if (error) {
            NSLog(@"Authentication error: %@", error.localizedDescription);
        }
    }];
    authButton.center = self.view.center;
    [self.view addSubview:authButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
