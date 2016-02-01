//
//  DrugIconsView.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Drug;

@interface DrugIconsView : UIView {
	Drug * drug;
	UIImageView * heart;
	UIImageView * pregnant;
	UIImageView * drive;
	UIImageView * children;
}

-(void) displayDrug:(Drug *) _drug ;

@property (nonatomic,retain) Drug * drug;
@property (nonatomic,retain) UIImageView * heart;
@property (nonatomic,retain) UIImageView * pregnant;
@property (nonatomic,retain) UIImageView * drive;
@property (nonatomic,retain) UIImageView * children;

@end
