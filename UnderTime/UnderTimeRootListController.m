#include "UnderTimeRootListController.h"
#import <spawn.h>



@protocol PreferencesTableCustomView
- (id)initWithSpecifier:(id)arg1;

@optional
- (CGFloat)preferredHeightForWidth:(CGFloat)arg1;
- (CGFloat)preferredHeightForWidth:(CGFloat)arg1 inTableView:(id)arg2;
@end

@interface UnderTimeCustomCell : UITableViewCell <PreferencesTableCustomView> {
    UILabel *label;
    UILabel *underLabel;
}
@end


@implementation UnderTimeCustomCell

- (id)initWithSpecifier:(PSSpecifier *)specifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    if (self) {

	#define kWidth [[UIApplication sharedApplication] keyWindow].frame.size.width
	CGRect labelFrame = CGRectMake(0, -15, kWidth, 70);
      CGRect underLabelFrame = CGRectMake(0, 22, kWidth, 70);
	
label = [[UILabel alloc] initWithFrame:labelFrame];
	[label setNumberOfLines:1];
	label.font = [UIFont fontWithName:@"HelveticaNeue" size:30];
	[label setText:@"UnderTime"];
	[label setBackgroundColor:[UIColor clearColor]];
	label.textColor = [UIColor blackColor];
	label.textAlignment = NSTextAlignmentCenter;

underLabel = [[UILabel alloc] initWithFrame:underLabelFrame];
	[underLabel setNumberOfLines:1];
	underLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:0];
	[underLabel setText:@"Nevermind this"];
	[underLabel setBackgroundColor:[UIColor clearColor]];
	underLabel.textColor = [UIColor clearColor];
	underLabel.textAlignment = NSTextAlignmentRight;

       [self addSubview:label];
       [self addSubview:underLabel];
    }
    return self;
}
- (CGFloat)preferredHeightForWidth:(CGFloat)arg1 {
    CGFloat prefHeight = 75.0;
    return prefHeight;
}
@end


@implementation UnderTimeRootListController
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void) respring {
pid_t pid;
int status;
const char* args[] = {"killall", "-9", "backboardd", NULL};
posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
waitpid(pid, &status, WEXITED);
}
@end
