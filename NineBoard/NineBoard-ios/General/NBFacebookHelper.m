//
//  NBFacebookHelper.m
//  NineBoard-ios
//
//  Created by Daniel Ernst on 12/4/14.
//  Copyright (c) 2014 Daniel Ernst. All rights reserved.
//
//  Reference: https://developers.facebook.com/docs/facebook-login/ios#login-apicalls

#import "NBFacebookHelper.h"

#import "NBAppDelegate.h"

@implementation NBFacebookHelper

// This method will handle ALL the session state changes in the app
+ (void)sessionStateChanged:(FBSession *)session state:(FBSessionState)state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        NBAppDelegate *appDelegate = (NBAppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate userLoggedIn];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        NBAppDelegate *appDelegate = (NBAppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];
                
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        [self logout];
    }
}

+ (void)showMessage:(NSString *)alertText withTitle:(NSString *)alertTitle {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:alertTitle message:alertText delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [av show];
}

+ (void)initiateLogin {
    if (FBSession.activeSession.state != FBSessionStateOpen
        && FBSession.activeSession.state != FBSessionStateOpenTokenExtended) {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"user_friends"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             // Call the sessionStateChanged:state:error method to handle session state changes
             [self sessionStateChanged:session state:state error:error];
         }];
    }
    else {
        NSLog(@"user already logged in!");
    }
}

+ (void)logout {
    // Close the session and remove the access token from the cache
    // The session state handler (in the app delegate) will be called automatically
    [FBSession.activeSession closeAndClearTokenInformation];
    // Show the user the logged-out UI
    NBAppDelegate *appDelegate = (NBAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate userLoggedOut];
}

@end
