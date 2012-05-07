//
//  AddBloodPressureViewController.m
//  MyBloodPressure
//
//  Created by Laureano Lopez on 2/6/10.
//  Copyright 2010 Bo Technologies. All rights reserved.
//

#import "AddBloodPressureViewController.h"


@implementation AddBloodPressureViewController
@synthesize systolic, diastolic, pulsePerMin;
@synthesize fetchedResultsController;
@synthesize managedObject;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] 
								   initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
								   target:self action:@selector(saveNewObject)];
	
	if (self.managedObject != nil) {
		systolicEnabled = YES;
		diastolicEnabled = YES;
		pulsePerMinEnabled = YES;
		self.systolic.text = [self.managedObject valueForKey:@"systolic"];
		self.diastolic.text = [self.managedObject valueForKey:@"diastolic"];
		self.pulsePerMin.text = [self.managedObject valueForKey:@"pulse"];
		NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterLongStyle];
		[formatter setTimeStyle:NSDateFormatterShortStyle];
		self.title = [formatter stringFromDate:[managedObject valueForKey:@"timeStamp"]];
		saveButton.enabled = YES;
		[formatter release];		
	}
	else {
		systolicEnabled = NO;
		diastolicEnabled = NO;
		pulsePerMinEnabled = NO;
		self.title = @"New";	
		saveButton.enabled = NO;		
	}		
	self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];	
}

-(void)resignToKeyboard {
	[self.systolic resignFirstResponder];
	[self.diastolic resignFirstResponder];
	[self.pulsePerMin resignFirstResponder];
}

- (void)saveNewObject {
	
	[self resignToKeyboard];
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	if (self.managedObject == nil) {
		// Create a new instance of the entity managed by the fetched results controller.		
		NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];
		self.managedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] 
														   inManagedObjectContext:context];
		[self.managedObject setValue:[NSDate date] forKey:@"timeStamp"];
	}	
	
	[self.managedObject setValue: self.systolic.text forKey:@"systolic"];
	[self.managedObject setValue: self.diastolic.text forKey:@"diastolic"];
	[self.managedObject setValue: self.pulsePerMin.text forKey:@"pulse"];
	
	// Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);
    }
	
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
	[managedObject release];
	[systolic release];
	[diastolic release];
	[pulsePerMin release];
	[fetchedResultsController release];
    [super dealloc];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField  {
	if (textField == self.systolic) {
		systolicEnabled = YES;
	}
	else if (textField == self.diastolic) {
		diastolicEnabled = YES;
	}
	else if (textField == self.pulsePerMin) {
		pulsePerMinEnabled = YES;
	}
	
	self.navigationItem.rightBarButtonItem.enabled = systolicEnabled && diastolicEnabled && pulsePerMinEnabled;
	
}

@end
