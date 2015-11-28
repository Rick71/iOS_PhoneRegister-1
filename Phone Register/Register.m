//
//  ViewController.m
//  Phone Register
//
//  Created by Walter Gonzalez Domenzain on 27/11/15.
//  Copyright © 2015 Smartplace. All rights reserved.
//

#import "Register.h"
#import <DigitsKit/DigitsKit.h>
#import "Conekta.h"

@interface Register ()

@end

@implementation Register
/*************************************/
#pragma mark - Initialization
/*************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [[Digits sharedInstance] logOut];
    // Do any additional setup after loading the view, typically from a nib.
}
//-----------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-----------------------------------------------
- (void)initDigits {
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
//-----------------------------------------------
- (void)initConekta {
    Conekta *conekta = [[Conekta alloc] init];
    
    [conekta setDelegate: self];
    
    [conekta setPublicKey:@"key_DMMumvx5mZnFhD3nqYJPqRQ"];
    
    [conekta collectDevice];
    
    Card *card = [conekta.Card initWithNumber: @"4242424242424242" name: @"Julian Ceballos" cvc: @"123" expMonth: @"10" expYear: @"2018"];
    
    Token *token = [conekta.Token initWithCard:card];
    
    [token createWithSuccess: ^(NSDictionary *data) {
        NSLog(@"%@", data);
    } andError: ^(NSError *error) {
        NSLog(@"%@", error);
    }];
}
/*************************************/
#pragma mark - Action methods
/*************************************/
- (IBAction)btnLoginPressed:(id)sender {
    
    [[Digits sharedInstance] authenticateWithCompletion:^(DGTSession *session, NSError *error) {
        // Inspect session/error objects
       
        if (session != nil) {
            NSString *stPhone = session.phoneNumber;
            self.lblPhone.text = [@"Teléfono: " stringByAppendingString:stPhone];
        }
        
    [[Digits sharedInstance] logOut];
    }];

    
}
@end
