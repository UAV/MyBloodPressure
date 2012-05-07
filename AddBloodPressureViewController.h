//
//  AddBloodPressureViewController.h
//  MyBloodPressure
//
//  Created by Laureano Lopez on 2/6/10.
//  Copyright 2010 Bo Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddBloodPressureViewController : UIViewController<UITextFieldDelegate> {
	UITextField* systolic;
	UITextField* diastolic;
	UITextField* pulsePerMin;
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObject* managedObject;
	BOOL systolicEnabled;
	BOOL diastolicEnabled;
	BOOL pulsePerMinEnabled;
}

@property(nonatomic, retain) IBOutlet UITextField* systolic;
@property(nonatomic, retain) IBOutlet UITextField* diastolic;
@property(nonatomic, retain) IBOutlet UITextField* pulsePerMin;
@property(nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property(nonatomic, retain) NSManagedObject* managedObject;

- (IBAction) resignToKeyboard;
@end
